# 🛍️ Depot_App

A simple e-commerce-style Rails 7 application that allows users to manage products with authentication, Tailwind CSS styling, and a full test suite (model, controller, integration).

---

## 🚀 Features

- User authentication via Devise
- Full CRUD for products
- Tailwind CSS UI
- Unit, controller, and integration tests
- Image upload support (Active Storage)
- Clean and semantic HTML views

---

## 🧱 Tech Stack

- **Ruby on Rails 7**
- **PostgreSQL**
- **Tailwind CSS**
- **Devise** (Authentication)
- **Warden/Test Helpers** (Testing support)
- **MiniTest** (Rails default testing framework)

---

## 🛠️ Setup

### 1. Clone the repository

```bash
git clone https://github.com/your-username/depot.git
cd depot
```

### 2. Install dependencies

```bash
bundle install
yarn install # if using JS bundling
```

### 3. Setup database

```bash
rails db:setup
```

> This will create and migrate both `development` and `test` databases.

### 4. Start the server

```bash
bin/dev
```

> Runs Rails + Tailwind CSS watcher together.

---

## ✅ Running Tests

### All Tests

```bash
rails test
```

### With full output

```bash
rails test --verbose
```

### Single Test

```bash
rails test test/controllers/products_controller_test.rb:42
```

---

## 📦 Product Structure

- `app/models/product.rb`: Product model with validations
- `app/controllers/products_controller.rb`: Full CRUD
- `app/views/products/`: Tailwind-styled views
- `test/models/`, `test/controllers/`, `test/integration/`: Minitest suites

---

## 👨‍💻 Contributions

Feel free to open issues or pull requests. All contributions are welcome!

---

## 📸 Screenshot

<img src="screenshot.png" alt="Product Page Screenshot" width="600" />

---

## 📝 License

MIT

```

---

Want me to customize this further with your GitHub username, database settings, or any additional features you plan to add?
```
