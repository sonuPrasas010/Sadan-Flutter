# 🚘 Sadan - Vehicle Rental App (Frontend)

**Sadan** is the mobile frontend for a vehicle rental application, developed using **Flutter**. It communicates with a Node.js backend via RESTful APIs and provides a clean, intuitive user interface for booking and managing vehicle rentals.

---

## 📱 Features

- 🔐 User Authentication (Login/Signup)
- 🚙 Browse available vehicles
- 📆 Book a vehicle for specific dates
- ⭐ Rate and review vehicles
- 👤 View and edit user profile
- 🧾 View booking history
- 📸 Upload documents and vehicle images
- 🌐 Open links via `url_launcher`
- 📱 Responsive UI for all screen sizes

---

## 🛠 Tech Stack

- **Flutter** (SDK: `>=2.19.1 <3.0.0`)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **HTTP Clients**: `dio`, `http`
- **Image Uploading**: `image_picker`
- **Date & Time Handling**: `intl`
- **Rating Widget**: `flutter_rating_bar`
- **External Links**: `url_launcher`

---

## 📦 Dependencies

From your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5
  dio: ^5.0.1
  http: ^0.13.5
  flutter_rating_bar: ^4.0.1
  image_picker: ^0.8.6+4
  intl: ^0.18.0
  url_launcher: ^6.1.10
