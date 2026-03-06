# Grocery Shops Flutter App

A Flutter application that displays a list of grocery shops using a public API.  
The project was built as part of a Flutter technical assessment.

---


# Features

- Fetch grocery shops from API
- Display shop cards with:
    - Cover photo
    - Shop name
    - Description
    - Estimated delivery time
    - Minimum order
    - Location
    - Availability badge (Open / Closed)

- Search shops by name or description
- Debounced search input
- Sort by ETA (ascending)
- Sort by Minimum Order (ascending)
- Filter open shops
- Clear filters
- Empty state handling

---

# Architecture

The project follows **Clean Architecture** principles with clear separation between layers.

Layers used:

Presentation  
UI + Cubit state management

Domain  
Entities + UseCases

Data  
Repository + Remote Data Source

State management is implemented using **Flutter Bloc (Cubit)**.

---

# Tech Stack

Flutter  
Flutter Bloc / Cubit  
Dio (Networking)  
GetIt (Dependency Injection)  
Flutter ScreenUtil (Responsive UI)  
CachedNetworkImage

---
# Project Structure


lib
core
network
utils

features
shops
data
domain
presentation


---

# API Configuration

The API key is **not included in the repository** for security reasons.

Run the app using:


flutter run --dart-define=SECRET_KEY=PostInterview022026


---

# Setup Instructions

1. Clone the repository


git clone https://github.com/YOUR_USERNAME/flutter-grocery-shops-assessment.git


2. Install dependencies


flutter pub get


3. Run the application


flutter run --dart-define=SECRET_KEY=your_api_key


---

# Assumptions

- All shop data is fetched from the provided API endpoint.
- Search is implemented locally after fetching shops.

---

# Trade-offs

- Pagination was not implemented to keep the scope focused on the required features.
- Only remote data source was used.

---

# Demo

Screen recording:  
https://drive.google.com/file/d/1f4CvEZ28qICf3Yxzt_CrtyDLzLpXeYLz/view?usp=sharing
APK build:  
https://drive.google.com/file/d/1CvVSnmcDjLJ2D2pNQbR3ksmpdjA5hsVl/view?usp=sharing
---