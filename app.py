from flask import Flask, jsonify, render_template, request, session, redirect
from dotenv import load_dotenv
import os
import mysql.connector

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY')


def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="restaurantWebsite",
        port=8889
    )

# INDEX


@app.route('/')
def index():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM foods")
    foods = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('index.html', foods=foods)


@app.route("/logout")
def logout():
    session.clear()
    return redirect("/")


# END OF INDEX
# MENU

@app.route('/menu')
def menu():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM foods")
    foods = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('menu.html', foods=foods)

# END OF MENU
# OREDR


@app.route('/order')
def order():
    if not session.get('userid'):
        return redirect('/login')
    return render_template('order.html')

# END OF ORDER
# LOGIN AND PROCESS OF LOGIN


@app.route('/login')
def login():

    return render_template('login.html')


@app.route("/process-login", methods=["POST"])
def process_login():
    username = request.form.get("username")
    password = request.form.get("password")

    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    sql = """
        SELECT * FROM users
        WHERE username = %s AND password = %s
    """
    cursor.execute(sql, (username, password))
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    if user:
        session["userid"] = user["id"]
        session["username"] = user["username"]
        session["role"] = user["role"]      # 👈 نقش کاربر
        return redirect("/")

    return render_template("not-logged-in.html", username=username, password=password)


# END OF LOGIN AND PROCESS OF LOGIN

# CREATE ACCOUNT

@app.route('/create-account')
def create_account():
    return render_template('create-account.html')


@app.route("/submitted-create-account", methods=['POST'])
def submitted_create_account():

    username = request.form.get('username')
    password = request.form.get('password')
    email = request.form.get('email')
    phone = request.form.get('phone')
    address = request.form.get('address')

    conn = get_db()
    cursor = conn.cursor()

    sql = '''
        INSERT INTO users (username, password, email, phone, address, role)
        VALUES (%s, %s, %s, %s, %s, %s)
    '''
    values = (username, password, email, phone, address, 1)

    cursor.execute(sql, values)
    conn.commit()

    new_user_id = cursor.lastrowid

    cursor.close()
    conn.close()

    session["userid"] = new_user_id
    session["username"] = username
    session["password"] = password
    session["role"] = 1

    return redirect("/")
# END OF CREATE ACCOUNT

# CONTACT  AND ABOUT PAGE


@app.route('/contact')
def contact():
    return render_template('contact.html')


@app.route('/about')
def about():
    return render_template('about.html')


@app.route("/send-message", methods=['POST'])
def send_message():
    data = request.get_json()

    name = data.get("name")
    email = data.get("email")
    message = data.get("message")

    conn = get_db()
    cursor = conn.cursor()

    sql = '''
        INSERT INTO contacts (name, email, message)
        VALUES (%s, %s, %s)
    '''
    values = (name, email, message)

    cursor.execute(sql, values)
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({"success": True})
# END OF CONTACT AND ABOUT PAGE

# ADMIN DASHBOARD


@app.route('/admin/dashboard')
def admin_dashboard():
    # Check role
    if session.get('role') != 2:
        return "STOP! You are not admin.", 403

    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM foods")
    foods = cursor.fetchall()

    cursor.execute("SELECT * FROM gallery")
    photos = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('admin-dashboard.html', foods=foods, photos=photos)


@app.route('/admin/messages')
def admin_messages():
    if session.get('role') != 2:
        return "STOP! You are not admin.", 403

    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM contacts ORDER BY id DESC")
    messages = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('contact-messages.html', messages=messages)
# END OF ADMIN DASHBOARD

# ADD FOOD


@app.route("/add-food", methods=['POST'])
def add_food():

    name = request.form.get('edit-name')
    price = request.form.get('edit-price')
    description = request.form.get('edit-desc')
    image_file = request.files['edit-image']

    image_name = image_file.filename
    image_path = os.path.join("static/img/foods", image_name)
    image_file.save(image_path)

    conn = get_db()
    cursor = conn.cursor()

    sql = '''
        INSERT INTO foods (name, price, description, image)
        VALUES (%s, %s, %s, %s)
    '''
    values = (name, price, description, image_name)

    cursor.execute(sql, values)
    conn.commit()

    cursor.close()
    conn.close()

    return render_template("food-added.html", name=name)
# END OF ADD FOOD
# DELETE FOOD


@app.route("/delete-food/<int:food_id>", methods=['POST'])
def delete_food(food_id):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM foods WHERE fid = %s", (food_id,))
    conn.commit()

    cursor.close()
    conn.close()

    return render_template("food-deleted.html", food_id=food_id)
# END OF DELETE FOOD

# EDIT FOOD


@app.route("/edit-food/<int:food_id>", methods=["GET"])
def edit_food(food_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM foods WHERE fid = %s", (food_id,))
    food = cursor.fetchone()

    cursor.close()
    conn.close()

    return render_template("food-edited.html", food=food)


@app.route("/update-food/<int:food_id>", methods=["POST"])
def update_food(food_id):
    name = request.form["name"]
    price = request.form["price"]
    description = request.form["description"]

    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("""
        UPDATE foods
        SET name = %s, price = %s, description = %s
        WHERE fid = %s
    """, (name, price, description, food_id))

    conn.commit()
    cursor.close()
    conn.close()

    return render_template("food-edited-successfully.html", food_id=food_id)
# END OF EDIT FOOD
# FEEDBACK


@app.route("/submit-feedback", methods=["POST"])
def submit_feedback():
    message = request.form.get("message")

    user_id = session.get("userid")
    username = session.get("username")

    conn = get_db()
    cursor = conn.cursor()

    sql = "INSERT INTO feedback (user_id, username, message) VALUES (%s, %s, %s)"
    cursor.execute(sql, (user_id, username, message))

    conn.commit()
    cursor.close()
    conn.close()

    return render_template("submit-feedback.html")
# END OF FEEDBACK
# GALLERY


@app.route('/gallery')
def gallery():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM gallery")
    photos = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('gallery.html', photos=photos)


@app.route("/add-photo", methods=["POST"])
def add_photo():
    title = request.form.get("title")
    image_file = request.files["image"]

    image_name = image_file.filename
    image_path = os.path.join("static/img/gallery", image_name)
    image_file.save(image_path)

    conn = get_db()
    cursor = conn.cursor()

    sql = "INSERT INTO gallery (image, title) VALUES (%s, %s)"
    cursor.execute(sql, (image_name, title))

    conn.commit()
    cursor.close()
    conn.close()

    return render_template("add-photo-successfully.html")

# END OF ADD PHOTO
# DELETE PHOTO


@app.route("/delete-photo/<int:photo_id>", methods=['POST'])
def delete_photo(photo_id):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM gallery WHERE id = %s", (photo_id,))
    conn.commit()

    cursor.close()
    conn.close()

    return render_template("delete-gallery.html", photo_id=photo_id)
# END OF DELETE PHOTO

# EDIT PHOTO


@app.route("/edit-photo/<int:photo_id>", methods=["GET"])
def edit_photo(photo_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM gallery WHERE id = %s", (photo_id,))
    photo = cursor.fetchone()

    cursor.close()
    conn.close()

    return render_template("edit-photo.html", photo=photo)


@app.route("/update-photo/<int:photo_id>", methods=["POST"])
def update_photo(photo_id):
    title = request.form["title"]
    image_file = request.files.get("image")

    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM gallery WHERE id = %s", (photo_id,))
    photo = cursor.fetchone()

    if image_file and image_file.filename:
        image_name = image_file.filename
        image_path = os.path.join("static/img/gallery", image_name)
        image_file.save(image_path)
        cursor.execute("""
            UPDATE gallery
            SET title = %s, image = %s
            WHERE id = %s
        """, (title, image_name, photo_id))
    else:
        cursor.execute("""
            UPDATE gallery
            SET title = %s
            WHERE id = %s
        """, (title, photo_id))

    conn.commit()
    cursor.close()
    conn.close()

    return render_template("edit-photo-successfully.html", photo_id=photo_id)
# END OF EDIT PHOTO
