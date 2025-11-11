# Super Fitness 🏋️‍♂️🔥  

The **Super Fitness App** is a Flutter-based health and fitness application designed to help users **train smarter, eat better, and stay consistent** in achieving their fitness goals.  
It combines **personalized workouts**, **meals recommendations**, and an **AI-powered Smart Coach chatbot** — all in one intuitive and engaging experience.  

Built with **clean architecture**, **Bloc/Cubit (MVI pattern)**, and a **scalable modular design**, Super Fitness delivers performance, reliability, and a smooth user experience across Android and iOS.  

---

## Features ✨  

### 🚀 Onboarding & Authentication  
- **Onboarding Flow**: Interactive introduction screens that showcase the app’s features.  
- **Login / Sign Up**:  
  - Secure authentication using **email and password**.  
  - New users can easily create accounts through the sign-up flow.  
- **Forgot Password**:  
  - Simple reset password process through a dedicated view.  

---

### 🏠 Home Screen  
The main dashboard providing users with personalized recommendations and progress insights.  
Includes the following sections:  

- **Categories Section**: Explore workout and nutrition categories.  
- **Recommended Exercises for Today**: Smart daily workout suggestions.  
- **Upcoming Workouts**:  
  - Select a **muscle group** (e.g., Chest, Back, Legs).  
  - View related workouts displayed in a horizontal scroll list.  
- **Recommended Meals for You**: Curated meal recommendations.  
- **Popular Training Section**: Discover trending workouts from the community.  

#### 💪 Muscle Details View  
- Displays a list of exercises for the selected muscle group.  
- Each exercise includes a **tutorial video** for proper form and guidance.  

#### 🍽️ Food Recommendation View  
- Divided into **food sections**, each containing a list of meals.  
- Each meal includes:  
  - **Meal details & ingredients list**.  
  - **Related meal recommendations**.  
  - **Preparation video** integrated via **YouTube Player**.  

---

### 🤖 Smart Coach Chat Bot  
Your personal AI fitness assistant built with **Gemini AI** and **Sqflite** local storage.  
- Chat naturally with the AI coach for:  
  - Workout plans.  
  - Nutrition advice.  
  - Motivation & consistency tips.  
- All conversations are **stored locally** for offline access.  

---

### 🏋️ Workouts
- Browse all **muscle groups** available in the app.  
- Tap a group to view its **specific muscles**.  
- Each muscle includes a list of **exercises with instructional videos** for guided training.  

---

### 👤 Profile
Comprehensive user account management and app customization features:  
- **Edit Profile**: Update name, profile picture, goal, and personal details.  
- **Change Password**: Secure password management.  
- **Language Switch**: Instantly toggle between **English** and **Arabic**.  
- **Security View**: Manage privacy and data permissions.  
- **Privacy Policy & Help Views**: Access legal info and support.  
- **Logout**: Securely sign out anytime.  

---

## 🧪 Testing & Quality Assurance  

Super Fitness includes comprehensive **unit testing** and **widget testing** to ensure reliability and code quality.  
- Covers key components such as:  
  - API data handling and repository layers.  
  - UI widgets and Bloc/Cubit state transitions.  
- Achieved a **test coverage of 84%**, ensuring robust and maintainable code.  

---

## Technologies Used 🛠️  

- **Flutter**: Cross-platform UI toolkit for Android and iOS.  
- **Dio + Retrofit**: Efficient and type-safe HTTP client for networking.  
- **Bloc / Cubit (MVI Pattern)**: Reactive and scalable state management.  
- **Sqflite**: Local database for storing Smart Coach chat history.  
- **YouTube Player**: Embedded video player for exercise and meal tutorials.  
- **Flutter Secure Storage**: Securely stores tokens and credentials.  
- **Clean Architecture + Repository Pattern**: Ensures scalability and maintainability.  

---

## 📂 Project Structure  

```bash
lib/
├── api/
│   └── client/           # Retrofit API client
│   └── models/           # Data models
│   └── responses/        # API responses
│   └── data_source_impl/ # API implementations
├── data/
│   └── data_source/      # Local/remote data sources
│   └── repositories/     # Repository implementations
├── domain/
│   └── entities/         # Core business entities
│   └── repositories/     # Repository contracts
│   └── usecases/         # Business logic & use cases
├── presentation/
│   └── views/            # UI screens & widgets
│   └── view_models/      # Bloc/Cubit classes

```

---

## 🛠️ Setup Instructions

### 1.Clone the repository
```bash
git clone https://github.com/0Elevate0/fitness-app.git
```
### 2.Navigate into the project directory
```bash
cd fitness-app
```
### 3.Install dependencies
```bash
flutter pub get
```
### 4.Run the app
```bash
flutter run
```

---

## Screenshots 📸

<img src="https://github.com/user-attachments/assets/5474097f-b9e1-4ca6-9026-6d75c179019c" alt="Screenshot 1" width="300"/>
<img src="https://github.com/user-attachments/assets/10ecf2fc-bfd5-4a13-8db1-0a659d2bd089" alt="Screenshot 2" width="300"/>
<img src="https://github.com/user-attachments/assets/61d6e517-ac6b-43d5-bc35-0f463d3a4ff7" alt="Screenshot 3" width="300"/>
<img src="https://github.com/user-attachments/assets/d80a42a3-9053-4da4-afa8-5ec89e60b464" alt="Screenshot 4" width="300"/>
<img src="https://github.com/user-attachments/assets/57867735-bd6e-496d-8c19-1fd2d4dca509" alt="Screenshot 5" width="300"/>
<img src="https://github.com/user-attachments/assets/0a392675-5e87-4335-bc6f-aebd34a33a57" alt="Screenshot 6" width="300"/>
<img src="https://github.com/user-attachments/assets/f762b8d1-211a-462d-b68a-1020cd352c3a" alt="Screenshot 7" width="300"/>
<img src="https://github.com/user-attachments/assets/00e64269-81dc-4616-ae49-759187178766" alt="Screenshot 8" width="300"/>
<img src="https://github.com/user-attachments/assets/737ccf20-4b3a-4c71-9588-e0529c952be6" alt="Screenshot 9" width="300"/>
<img src="https://github.com/user-attachments/assets/92ed7d19-f461-49d4-99bf-39bcf3436a75" alt="Screenshot 10" width="300"/>
<img src="https://github.com/user-attachments/assets/47d5bff3-3ed4-45e2-8e2f-57f62a73caea" alt="Screenshot 11" width="300"/>
<img src="https://github.com/user-attachments/assets/0807c990-c5f9-475d-9d31-406dbf4ff38d" alt="Screenshot 12" width="300"/>
<img src="https://github.com/user-attachments/assets/f49ab2a1-9151-483b-8737-69bc8733affc" alt="Screenshot 13" width="300"/>
<img src="https://github.com/user-attachments/assets/581925ac-9c69-4956-949d-9b7ba44434da" alt="Screenshot 14" width="300"/>
<img src="https://github.com/user-attachments/assets/7786136a-8281-4e9e-83be-48d0f3dea301" alt="Screenshot 15" width="300"/>
<img src="https://github.com/user-attachments/assets/12956adf-4610-4115-bb91-1f157e57cd2d" alt="Screenshot 16" width="300"/>
<img src="https://github.com/user-attachments/assets/719e83ad-e321-4d06-a3ec-e1b410186229" alt="Screenshot 17" width="300"/>
<img src="https://github.com/user-attachments/assets/7cce6385-1935-4f88-8c24-155d740f90c3" alt="Screenshot 18" width="300"/>
<img src="https://github.com/user-attachments/assets/5e0adb91-c729-4d1b-90f5-01a47f884b79" alt="Screenshot 19" width="300"/>
<img src="https://github.com/user-attachments/assets/d35b8a4c-327c-41f1-9657-7790918eae81" alt="Screenshot 20" width="300"/>
<img src="https://github.com/user-attachments/assets/1777d00b-17d8-4458-9b0d-08f0b5b71ae6" alt="Screenshot 21" width="300"/>
<img src="https://github.com/user-attachments/assets/92dc0991-2c53-452b-a3fe-d77e30246635" alt="Screenshot 22" width="300"/>
<img src="https://github.com/user-attachments/assets/36805978-ed0b-4555-9d63-a8e27017141d" alt="Screenshot 23" width="300"/>
<img src="https://github.com/user-attachments/assets/89a902ca-b307-49be-9cd4-95d5a16fc18e" alt="Screenshot 24" width="300"/>
<img src="https://github.com/user-attachments/assets/23b79bf3-a941-48f0-b91e-31073b18e1d4" alt="Screenshot 25" width="300"/>
<img src="https://github.com/user-attachments/assets/7b7a8dfc-6b69-41fb-9858-7dd453871102" alt="Screenshot 26" width="300"/>
<img src="https://github.com/user-attachments/assets/aa1b1fd9-13fa-43a2-ba64-27464598ca17" alt="Screenshot 27" width="300"/>
<img src="https://github.com/user-attachments/assets/2607b3cd-faf3-462b-8781-d79b070dc70d" alt="Screenshot 28" width="300"/>
<img src="https://github.com/user-attachments/assets/0634d760-9b7c-4d37-8a3c-4c073da01a20" alt="Screenshot 29" width="300"/>
<img src="https://github.com/user-attachments/assets/c2684a18-77b6-4381-b787-5ddd3a92950b" alt="Screenshot 30" width="300"/>
<img src="https://github.com/user-attachments/assets/8f2e2269-4ff0-4165-9030-04cde3e21607" alt="Screenshot 31" width="300"/>
<img src="https://github.com/user-attachments/assets/2bf00cc6-887c-4a52-a719-b152ffd2f98b" alt="Screenshot 32" width="300"/>
<img src="https://github.com/user-attachments/assets/981c94e8-d640-40fe-856d-73200274c6d0" alt="Screenshot 33" width="300"/>
<img src="https://github.com/user-attachments/assets/fc806d3b-6b8d-4150-b9ff-d22dd02a0548" alt="Screenshot 34" width="300"/>
<img src="https://github.com/user-attachments/assets/f2a2e2f1-0941-4cac-8ccf-3000cb708c58" alt="Screenshot 35" width="300"/>
<img src="https://github.com/user-attachments/assets/fdbbb231-9260-42ae-89e9-2987ee65ee33" alt="Screenshot 36" width="300"/>
<img src="https://github.com/user-attachments/assets/1cdb9cfa-678a-456b-8560-7723b58c0fb2" alt="Screenshot 37" width="300"/>
<img src="https://github.com/user-attachments/assets/62afe126-8790-44aa-9d77-cc7d6de44919" alt="Screenshot 38" width="300"/>
<img src="https://github.com/user-attachments/assets/21241439-9f7d-4bcf-a91d-405f55e21e55" alt="Screenshot 39" width="300"/>
<img src="https://github.com/user-attachments/assets/03207c1f-8298-4eb8-818c-bf4f6b6ada8b" alt="Screenshot 40" width="300"/>
<img src="https://github.com/user-attachments/assets/caa56998-e790-4e50-9ef7-fbf7255b5dbd" alt="Screenshot 41" width="300"/>
<img src="https://github.com/user-attachments/assets/3d90084d-a7ff-4b4a-83d3-800376709904" alt="Screenshot 42" width="300"/>
<img src="https://github.com/user-attachments/assets/0a48b225-ab38-48e7-9a86-43aaf7854f12" alt="Screenshot 43" width="300"/>
<img src="https://github.com/user-attachments/assets/c19ae86a-90df-4c10-bcad-83293a0392a2" alt="Screenshot 44" width="300"/>
<img src="https://github.com/user-attachments/assets/c42383b2-b38e-49c1-845a-e29a7b3784c7" alt="Screenshot 45" width="300"/>
<img src="https://github.com/user-attachments/assets/bf9bd2f1-cc55-45f5-9326-92cebd247e1b" alt="Screenshot 46" width="300"/>
<img src="https://github.com/user-attachments/assets/3b21a01e-8b7e-488d-b786-367a950a57e7" alt="Screenshot 47" width="300"/>
<img src="https://github.com/user-attachments/assets/f90fa296-85bb-48cd-8f64-cd66eac292d3" alt="Screenshot 48" width="300"/>
<img src="https://github.com/user-attachments/assets/63376c9c-fb97-46b2-ae5f-6f2f0f94358e" alt="Screenshot 49" width="300"/>
<img src="https://github.com/user-attachments/assets/b4e2d9a0-dc6d-402d-87a0-71659d925eaa" alt="Screenshot 50" width="300"/>
<img src="https://github.com/user-attachments/assets/0770cbaa-0013-44d2-bd8e-9a35bb008691" alt="Screenshot 51" width="300"/>
<img src="https://github.com/user-attachments/assets/f379b1f1-a53e-4b4d-94f7-d61241fec4de" alt="Screenshot 52" width="300"/>
<img src="https://github.com/user-attachments/assets/ec290c35-43a1-4b41-883e-d06c8e93e23c" alt="Screenshot 53" width="300"/>
<img src="https://github.com/user-attachments/assets/be3b4f94-07a7-4c4c-bd7e-852fca7b11c2" alt="Screenshot 54" width="300"/>
<img src="https://github.com/user-attachments/assets/059b5a43-6374-44c7-ace6-331568bcf3cb" alt="Screenshot 55" width="300"/>
<img src="https://github.com/user-attachments/assets/13283f12-2658-46df-9c66-99b4fe56774a" alt="Screenshot 56" width="300"/>
<img src="https://github.com/user-attachments/assets/a4f39115-b57c-404e-986f-1a5a39a94761" alt="Screenshot 57" width="300"/>
<img src="https://github.com/user-attachments/assets/db8e4b77-1648-4bb6-9610-73a43e57ddb5" alt="Screenshot 58" width="300"/>

---

## Download 📥
Get the Super Fitness app on your device:

- [Download for Android](https://drive.google.com/file/d/1JUgbs6pv03tN1-fyG2RjgPeChPG5ZBcF/view?usp=sharing)
