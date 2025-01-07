# Shopping Assistant Application

## Overview
The Shopping Assistant Application is a Java-based software designed to suggest items to users based on their preferences and budget. This project leverages object-oriented programming principles and streams for efficient data processing.

## Features
- Add and manage a collection of items.
- Suggest the best item based on user preferences.
- Provide alternative suggestions within a lower budget.
- Modular and extensible design with clear class responsibilities.

## Class Diagram
![Class Diagram](path/to/class-diagram.png)

The Class Diagram represents the structure of the application, showcasing:
- **Item**: Represents an item with attributes like name, category, price, and rating.
- **User**: Stores user details such as name, preferred category, and budget.
- **UserPreference**: Encapsulates a user's preferred category and budget.
- **Criteria**: Encodes conditions to match items.
- **ShoppingAssistant**: Core class for managing items and suggesting suitable ones.
- Relationships and interactions between the above classes.

## Software Architecture
The application follows a layered architecture with clear separation of concerns:

### 1. **Data Layer**
- Contains the `Item` and `User` classes.
- Represents entities in the system.

### 2. **Business Logic Layer**
- Contains the `ShoppingAssistant` class for item management and suggestions.
- Includes `Criteria` for filtering items based on user-defined conditions.

### 3. **Presentation Layer**
- The `ShoppingAssistantApp` class provides a console-based interface for interacting with the application.
- Includes user input handling and output display.

## State Diagram
![State Diagram](path/to/state-diagram.png)

The State Diagram represents the lifecycle of the application:
- **Idle**: The system awaits user interaction.
- **Adding Items**: Items are added to the system.
- **Suggesting Best Item**: The system processes user preferences and suggests an item.
- **Suggesting Lower Budget Item**: Iteratively suggests alternative items within a lower budget.
- **Exit**: The application terminates upon user confirmation.

## Usage
### Prerequisites
- Java Development Kit (JDK) installed.
- IDE or text editor of your choice.

### Steps to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/shopping-assistant.git
   ```
2. Navigate to the project directory:
   ```bash
   cd shopping-assistant
   ```
3. Compile the code:
   ```bash
   javac ShoppingAssistantApp.java
   ```
4. Run the application:
   ```bash
   java ShoppingAssistantApp
   ```

## Contribution
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
For questions or suggestions, feel free to reach out:
- **Email**: your.email@example.com
- **GitHub**: [your-username](https://github.com/your-username)

