[My Portfolio](https://maelfosso.github.io)

# Andi Taxi (mobile)

> clone app of some Uber features

## Built With

- Flutter
- Dart

## Requirements

To run this application, you must have installed

- Flutter
- Docker
- Docker compose

`docker` and `docker-compose` are necessary for the backend available at [https://github.com/maelfosso/andi-taxi-api](https://github.com/maelfosso/andi-taxi-api)

## Setup

Follow these steps to launch the application

### **Step 1**: Run the backend

The backend is available at `https://github.com/maelfosso/andi-taxi-api`. Follow the steps indicated there to run it.


### **Step 2**: Get the IP address of the computer running the backend

You can use `ifconfig` or `ip addr show` to get your IP address

### **Step 3**: Clone the repository 

`git clone https://github.com/maelfosso/andi-taxi-api`

### **Step**: Change the directory 

`cd andi-taxi-api`

### **Step 4**: Create an `.env` file in the root directory of the project

`touch .env`

### **Step 5**: Add variables into the `.env` file

The application depends on

- The backend, so we need the IP address of the host running this one. Remember you wrote it down at **Step 2**. You refer to it in the `env` file with the `BASE_URL` variable.

- Google Maps, so we need your Google maps API Key. You refer to it into the `env` file through the `GOOGLE_MAPS_API_KEY` variable.

At the end, your `.env` file will look like this
```.env
BASE_URL=http://x.x.x.x:3000/api
GOOGLE_MAPS_API_KEY=
```

### **Step 6**: Run the application

`flutter run`



## Usage

- Creates an account as client or driver
- Sign in (keep the code displayed)
- Enter the code. You have one minute.

## Internationalization

The default language of the application is the **English**. It's possible for you to add a new language.

If you want to add the **Russian** language for example, here is the process

### **Step 1**: Find the code of the language

The code of the Russian language is `**ru**`

### **Step 2**: Add the language

Open the `lib/main.dart` file.
In the `_AppViewState` class, localise the line with
```dart
const Locale('en', '')
```
Add this line below directly after
```dart
const Locale('ru', '')
```

### **Step 3**: Add the language file

Into the folder `lib/l10n`, create a new file called `app_ru.arb`. 

Copy the content of `app_en.arb` and modify it with the good content.

### Run the app

Please, enable the **Location** on your smartphone.

Just run the app like usual with `flutter run`

## Run tests


## Authors

- GitHub: [@maelfosso](https://github.com/maelfosso)
- Twitter: [@maelfosso](https://twitter.com/maelfosso)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/mael-fosso-650b6346/)

## 📝 License

This project is [MIT](./MIT.md) licensed.

## Screenshots

![screenshot](./screenshots/2.png)
![screenshot](./screenshots/4.png)
![screenshot](./screenshots/8.png)
