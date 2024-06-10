# Scanago

Scanago is a Flutter application designed to streamline and digitalize the in and out entry system using barcodes. The robust backend, built with Node.js, Express, and MongoDB, ensures seamless and efficient data management. This application not only saves time but also provides additional functionalities like night entry and mess food rating.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Backend Setup](#backend-setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features
- **Barcode Scanning**: Quickly scan barcodes for entry and exit.
- **Digital Entry System**: Eliminate paper-based entry logs.
- **Night Entry**: Special functionality for night-time entries.
- **Mess Food Rating**: Rate the quality of the mess food.

## Getting Started

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- A working knowledge of Dart and Flutter.
- [Node.js](https://nodejs.org/en/download/) and [npm](https://www.npmjs.com/get-npm) installed.
- [MongoDB](https://docs.mongodb.com/manual/installation/) installed and running.

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/om13rajpal/scanago.git
    cd scanago
    ```

2. **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```

3. **Navigate to the backend directory and install dependencies:**
    ```bash
    cd backend
    npm install
    ```

### Running the App

1. **Start the backend server:**
    ```bash
    cd backend
    npm start
    ```

2. **Run the Flutter app:**
    ```bash
    flutter run
    ```

## Backend Setup

The backend of Scanago is built with Node.js, Express, and MongoDB. Follow these steps to set up the backend:

1. **Configure MongoDB:**
    Ensure that MongoDB is running and accessible. You can configure the connection string in `backend/config/db.js`.

2. **Environment Variables:**
    Create a `.env` file in the `backend` directory with the following variables:
    ```env
    PORT=3000
    MONGO_URI=your_mongodb_connection_string
    ```

3. **Start the backend server:**
    ```bash
    npm start
    ```

The backend server will start on the port specified in the `.env` file (default is 3000).

## Usage

1. **Scan Barcode:**
    Open the app and use the barcode scanner to scan in and out.

2. **Night Entry:**
    Use the special night entry feature for logging entries during night hours.

3. **Rate Mess Food:**
    Rate the food in the mess to provide feedback.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes. Make sure to follow the coding standards and include relevant tests for your changes.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Happy Scanning with Scanago! 🚀