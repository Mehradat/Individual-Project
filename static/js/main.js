//ajax for contact part
const contactForm = document.getElementById("contactForm");

if (contactForm) {
  contactForm.addEventListener("submit", (e) => {
    e.preventDefault();

    const formData = new FormData(e.target);

    const data = {
      name: formData.get("name"),
      email: formData.get("email"),
      message: formData.get("message"),
    };

    fetch("http://127.0.0.1:5000/send-message", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.success) {
          alert("Thanks for sending us a message.");
        } else {
          alert("Error!");
        }

        document.getElementById("name").value = "";
        document.getElementById("email").value = "";
        document.getElementById("message").value = "";
      });
  });
}

function loadCart() {
  try {
    return JSON.parse(localStorage.getItem("cart")) || [];
  } catch (e) {
    return [];
  }
}
function saveCart(cart) {
  localStorage.setItem("cart", JSON.stringify(cart));
}
function cartTotalCount(cart) {
  return cart.reduce((sum, item) => sum + item.qty, 0);
}
function findItem(cart, id) {
  return cart.find((i) => i.id === id);
}

function updateCartCountDisplay() {
  const el = document.querySelector(".cart-count");
  if (!el) return;
  const cart = loadCart();
  el.textContent = cartTotalCount(cart);
}

function addToCart(food) {
  const cart = loadCart();
  const existing = findItem(cart, food.id);
  if (existing) {
    existing.qty += 1;
  } else {
    cart.push({ ...food, qty: 1 });
  }
  saveCart(cart);
  updateCartCountDisplay();
}
const addBtns = document.querySelectorAll(".add-btn");
for (let i = 0; i < addBtns.length; i++) {
  const btn = addBtns[i];
  btn.addEventListener("click", (e) => {
    e.preventDefault();

    const cartCountEl = document.querySelector(".cart-count");
    if (!cartCountEl) {
      window.location.href = "/login";
      return;
    }

    const id = btn.getAttribute("data-id");
    const name = btn.getAttribute("data-name");
    const price = parseFloat(btn.getAttribute("data-price"));
    if (!id || !name || isNaN(price)) return;
    addToCart({ id, name, price });
  });
}
const cartCountEl = document.querySelector(".cart-count");
if (cartCountEl) {
  cartCountEl.addEventListener("click", (e) => {
    if (cartCountEl.getAttribute("href") !== "/order") {
      e.preventDefault();
      window.location.href = "/order";
    }
  });
}

function renderOrderPage() {
  if (window.location.pathname !== "/order") return;
  const listEl = document.getElementById("cart-items");
  const totalEl = document.getElementById("total-price");
  if (!listEl || !totalEl) return;

  const cart = loadCart();
  if (cart.length === 0) {
    listEl.innerHTML = "<p>You did not add anything</p>";
    totalEl.textContent = "0";
    return;
  }

  let html = "";
  let total = 0;
  for (let i = 0; i < cart.length; i++) {
    const item = cart[i];
    const line = item.price * item.qty;
    total += line;
    html += `<div class="cart-row">${item.name} x ${item.qty} = $${line.toFixed(
      2
    )}</div>`;
  }
  listEl.innerHTML = html;
  totalEl.textContent = total.toFixed(2);

  const placeBtn = document.getElementById("place-order-btn");
  if (placeBtn) {
    placeBtn.addEventListener("click", () => {
      alert("Your order has been successfully placed");
    });
  }
}

// Clear cart on logout
const logoutBtns = document.querySelectorAll('a[href="/logout"]');
for (let i = 0; i < logoutBtns.length; i++) {
  const btn = logoutBtns[i];
  btn.addEventListener("click", (e) => {
    localStorage.removeItem("cart");
  });
}

updateCartCountDisplay();
renderOrderPage();
//creating hover with js
const navLinks = document.querySelectorAll(".menu-link");

for (let i = 0; i < navLinks.length; i++) {
  const link = navLinks[i];
  link.addEventListener("mouseover", () => {
    link.style.color = "#ea6d27";
    link.style.fontWeight = "bold";
  });

  link.addEventListener("mouseout", () => {
    link.style.color = "";
    link.style.fontWeight = "";
  });
}
//active zoomed css when we click on each picture on gallery.html
document.addEventListener("DOMContentLoaded", function () {
  const images = document.querySelectorAll(".photo-card img");

  let isZoomed = false;
  let activeImage = null;

  for (let i = 0; i < images.length; i++) {
    images[i].addEventListener("click", function () {
      if (isZoomed) {
        activeImage.classList.remove("zoomed");
      }

      if (activeImage === images[i]) {
        isZoomed = false;
        activeImage = null;
        return;
      }
      images[i].classList.add("zoomed");
      isZoomed = true;
      activeImage = images[i];
    });
  }

  document.addEventListener("click", function (e) {
    if (isZoomed && activeImage && e.target !== activeImage) {
      activeImage.classList.remove("zoomed");
      isZoomed = false;
      activeImage = null;
    }
  });
});
