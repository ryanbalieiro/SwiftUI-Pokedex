# <img src="readme-assets/logo.png"> SwiftUI Pokédex

This demo project showcases the setup of the SwiftUI framework with the Clean MVVM architecture.

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

## Key Features

- The app's UI is entirely built with SwiftUI.
- CoreData is used for saving and managing data.
- It dynamically fetches and updates the Pokémon catalog from the cloud.
- Combine is used for handling network interactions.
- The whole design is focused on scalability for future growth.

## Project Overview

The project is organized into these groups:

- **Data**: Handles saving and loading local data with CoreData.
- **Helpers**: Contains useful methods, constants, and extensions that can be reused across the app.
- **Models**: Manages the core functionality and business logic.
- **Network**: Responsible for getting data from the server.
- **ViewModels**: Bridges the gap between the app’s logic and the user interface.
- **Views**: Focuses on displaying data to users.

## Screenshots

### 1. Dark Mode

![alt tag1](readme-assets/dark.png)

### 2. Light Mode

![alt tag1](readme-assets/light.png)

## Preview

Just like the original Pokédex, it gives you detailed profiles and stats for every Pokémon, covering their types, abilities, evolution stages, base stats, and more:

![alt tag1](readme-assets/preview1.gif)
![alt tag1](readme-assets/preview2.gif)