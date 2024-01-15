# Flutter Movie App

Welcome to the Flutter Movie App! This project is a simple Flutter application that fetches movie data from an API and allows users to view a list of movies and mark their favorites.

## Table of Contents

- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Features](#features)
- [Project Structure](#Project-Structure)

## Project Structure

The project is structured to promote modularity, maintainability, and scalability. Here's an overview of the key folders:

- **lib/core**: Contains core functionality and business logic.
  - `constants`: App constants, such as API URLs, are centralized in `app_url.dart`.
  - `models`: Data models used throughout the application.
  - `providers`: State management using Provider package.
  - `services`: API communication and data fetching.
  - `utils`: Utility functions, global styles, and constants.

- **lib/ui**: Holds user interface components.
  - `favorites`: UI for displaying favorite movies.
  - `movies_list_widget`: UI component for displaying a list of movies.
  - `splash_screen.dart`: Initial screen displayed when the app is launched.

- **lib/main.dart**: Entry point for the Flutter application.

## Getting Started

To run the app locally, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/flutter-movie-app.git

## Features

 - Fetch and display a list of movies.
 - Mark movies as favorites.
 - View a list of favorite movies.

## Project Structure

The project's folder structure is designed to enhance maintainability, scalability, and code readability:

- **Modular Design:**
  - Logical separation into `core` and `ui` modules.
  - `core` contains subfolders (`constants`, `models`, `providers`, `services`, `utils`) for clear organization of functionalities.

- **Reusability and Scalability:**
  - Models, providers, and services are modularized for easy reuse across different parts of the application.
  - Modular design supports straightforward scalability, making it easy to add or extend features.

- **Project Entry Points:**
  - Key entry points (`main.dart`, `splash_screen.dart`) are placed at the root for easy identification and understanding.

- **Utilization of Utils Folder:**
  - `utils` centralizes utility functions, image paths, sizes, styles, and theme-related helpers for consistency and global configurations.

- **Logical UI Component Organization:**
  - `ui` is organized based on major UI components (`favorites`, `movies_list_widget`), facilitating code navigation and encouraging widget reusability.

This structure promotes collaboration, simplifies code navigation, and establishes a foundation for a scalable Flutter application.

