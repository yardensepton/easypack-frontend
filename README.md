# Easy Pack Frontend :luggage: :memo:

EasyPack is a Flutter application designed to help users create customized packing lists for trips based on the weather conditions and temperatures. This repository contains the frontend code for the EasyPack app.

The app uses [Provider](https://pub.dev/packages/provider) for state management to handle state updates and data flow throughout the application.

The server of EasyPack is maintained in a separate repository [easypack-server](https://github.com/yardensepton/easypack-server).

<img src="https://github.com/yardensepton/easypack-frontend/blob/ce82672abd3e5d3a93b73b971fd8bd6dba95444b/assets/background/EasyPack.png" width="100" />


## Table of Contents
* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
* [Screenshots](#screenshots)

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
* Set the backend URL in the [config.json](assets/config.json) file to the URL of your backend server.
* If you’re using an emulator, use http://localhost:8080.
* If you’re using an actual device, ensure that the device is connected to the same WiFi network as the server. Since the server is local, use the IPv4 address of the machine running the server instead of localhost.
4. Run the application:
```
flutter run
```

Important: The frontend application requires the EasyPack backend server to be running. Make sure to follow the instructions to start the backend server.


## Screenshots
#### Sign Up and Login

<img src="https://github.com/user-attachments/assets/4597c851-2a90-4581-9764-ce5dfbafbffa" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/28e854a2-bbaa-42d4-bdb2-ae69ef5da0ee" width="30%"></img> 

#### Forgot Password

<img src="https://github.com/user-attachments/assets/a4092c4c-9f4e-4a8f-b75f-f4ec17476686" width="30%"></img>
<img src="https://github.com/user-attachments/assets/869aa0ef-597e-4562-b2eb-ff525b175901" width="30%"></img>



#### App Screens

<img src="https://github.com/user-attachments/assets/2c9bded4-5800-42c8-8f40-0b2ff39af1ce" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/b4cf8a5a-287c-4d20-9918-e7bc4d32c729" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/24233325-55c8-4881-9d87-68c46e6fb22b" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/7ca79d88-0579-46b4-b33a-40e10b3b4f61" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/26421c06-5555-4101-9d9a-b68e24f95548" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/0cb0226e-3449-47aa-9866-fc9586601757" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/d61e369d-34e9-4eab-a9ef-58463892c42c" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/1ec7bc96-0447-4d07-96c7-bb21df770357" width="30%"></img> 
<img src="https://github.com/user-attachments/assets/210f9025-5cbe-47dd-a63d-c41491b0f047" width="30%"></img>
