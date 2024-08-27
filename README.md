# Easy Pack Frontend :luggage: :memo:

EasyPack is a Flutter application designed to help users create customized packing lists for trips based on the weather conditions and temperatures. This repository contains the frontend code for the EasyPack app.

The app uses [Provider](https://pub.dev/packages/provider) for state management to handle state updates and data flow throughout the application.

The server of EasyPack is maintained in a separate repository [easypack-server](https://github.com/yardensepton/easypack-server).

<img src="https://github.com/yardensepton/easypack-frontend/blob/ce82672abd3e5d3a93b73b971fd8bd6dba95444b/assets/background/EasyPack.png" width="100" />


## Table of Contents
* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
* [Demo](#demo)

## Features
* Profile Management
    * Create a profile with your preferences.
    * Sign up, log in, and use the forgot password functionality.
    * Edit user profile data to keep your information up-to-date.
* Trip Planning
    * Create upcoming trips with ease.
    * View the upcoming weather conditions for your trips, which are updated daily.
    * Generate packing lists with a single click, based on:
        * Weather conditions at your destination.
        * Your profile data.
        * Your preferences.
* User Personalization
    * Customize your packing lists by adding or removing items to suit your specific needs.
    *  Adjust the amount of each item as needed.
    * Item Categorization: Items are organized into categories like clothing, toiletries, and special items.
    * Mark items as packed by checking off a checkbox.
* Past and Future Trips Management:
    * Separate sections for managing and viewing your past and future trips.

## Installation
To get started with the EasyPack frontend, follow these steps:
1. Clone the repository:
```bash
git clone https://github.com/yardensepton/easypack-frontend.git
```
2. Navigate to the project directory:
```bash
cd easypack-frontend
```
3. Install the required dependencies:
```bash
flutter pub get
```
## Usage
To run the frontend application:
1. Ensure you have Flutter installed on your machine.
2. Start an emulator or connect a physical device.
3. Configure Frontend to Connect to Backend:
* Set the backend URL in the [constants_classes.dart](lib/constants/constants_classes.dart) file to the URL of your backend server.
* If you followed the instructions for running the server, use http://localhost:8000.
4. Run the application:
```
flutter run
```

Important: The frontend application requires the EasyPack backend server to be running. Make sure to follow the instructions to start the backend server.

## Demo 📸
