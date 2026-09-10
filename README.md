# pharmacy_management_App

A Flutter-based Pharmacy Management App that handles authentication, medicine inventory, sales, and alerts. Built with clean architecture and REST API integration
- it was developed as part of your trainee assessment.
## Tech Stack & Key Dependencies

   - **Framework:** Flutter (Dart SDK ^3.13.1)
   - **State Management:** flutter_bloc, get_it
   - **Networking:** dio
   - **Secure Storage:** flutter_secure_storage
   - **UI/UX:** skeletonizer, google_nav_bar, flutter_advanced_drawer, lottie
   - **Utilities:** intl, connectivity_plus, fluttertoast, equatable
   - **Branding:** flutter_native_splash, flutter_launcher_icons
# Installation & Setup
   ```bash
git clone https://github.com/your-username/pharmacy_management.git](https://github.com/Omar-khodja/Pharmacy-Management
cd pharmacy_management
flutter pub get
```



### Architecture & State Management
The project follows **Clean Architecture principles** with a **feature based modular structure**:
- Each feature (Authentication, Dashboard, Sales, Inventory) is organized into three layers:
   - **Data** -> API integration, repositories, model
      - **data**  -> Dio client, endpoints, interceptors, error handling.
      - **model** -> Parse JSON responses and map them to domain entities.
      - **Repositories**(implementations) ->Catches API/network errors (Exception) and translates them into standardized Failure objects for the domain layer and  provides the actual logic to fulfill those contracts using APIs, local DB, or other data sources.

   - **Domain** -> business logic, entities, use cases
      - **entities** -> Pure business models (e.g., Medicine, Sale, User).
      - **use cases** -> Encapsulate a single business rule or action.
         - Each use case is a class/function that executes one piece of logic (e.g., AddMedicine, GetLowStockMedicines, CreateInvoice ....).
      - **Repository** (Abstract) -> Abstract contracts that define what operations are possible.

   - **Presentation** -> UI screens, controllers Bloc/Cubit, widgets
      - **screens** -> Flutter UI screens for each feature.
      - **Controllers** -> Manage state and business logic for the UI.
         - They call Domain Use Cases and expose reactive variables to update the UI.
      - **Widgets** -> Reusable UI components
         - Keep screens clean by extracting common UI parts.
     
- A **core folder** is essentially the foundation layer that holds all the cross cutting utilities and shared resources that don’t belong to a single feature but are used across multiple features (widgets , themes , error handling ,Dependence Injection , entities and models .....).
  
- This ensures separation of concerns, testability, and scalability as new features are added.
# Folder Structure
 ```bash
lib/
 ├── core/
 │    ├── network/
 │    └── widget/
 |    ├── controler/ and other folders
 ├── features/                 # Feature-based modular structure
 │    ├── auth/                # Authentication feature
 │    │    ├── data/           # API integration, repositories, models
 │    │    ├── domain/         # Entities, use cases, repository contracts
 │    │    └── presentation/   # Screens, controllers, widgets
 │    ├── medicine/            # Medicine management 
 │    ├── sales/               # Sales & invoice creation
 │    └── inventory/           # Stock management
 ├──navigation_screen/
 ├──splashScreen/
 ├── widgets/                  # Global reusable UI components
 └── main.dart
 ```
# Features
  - Authentication & session management
  - Dashboard
  - Medicine CRUD (create, read, update, delete) + search
  - Sales/invoice creation
  - Inventory & stock management
  - Low-stock & expiry alerts
  - Responsive UI with error/loading/empty  states



   
