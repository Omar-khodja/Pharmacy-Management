# pharmacy_management

# Architecture & State Management
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
