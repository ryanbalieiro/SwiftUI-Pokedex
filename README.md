
# SwiftUI Pokédex

This demo project showcases the setup of the SwiftUI framework with the Clean MVVM architecture.

Similar to the original Pokédex, the implementation serves as an extensive repository of knowledge, providing detailed profiles and statistics for each Pokémon, including their types, abilities, evolutionary stages, base stats, and more.

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)


## Key Features

- Presentation layer implemented using SwiftUI
- Data persistence using CoreData
- Dynamic fetching and updating of app data from a BAAS service
- Utilization of Combine for interaction with the Network layer
- Designed with scalability in mind

## Project Overview

The project files have been organized into the following groups:

- Data: This layer takes charge of persistent storage and entity retrieval from CoreData, ensuring data integrity and seamless access.
- Helpers: A collection of methods, constants, and extensions crafted to serve multiple classes throughout the application.
- Models: The heart and soul of the project - it implements the business logic, capturing the essence of the app's functionality.
- Network: A dedicated layer responsible for handling data retrieval from the server.
- ViewModels: Classes that serve as a link connecting the logical layer with the views.
- Views: The presentation layer, designed to showcase the app's state focusing solely on displaying information without encumbering itself with business logic.

## Screenshots
