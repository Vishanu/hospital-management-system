# 🏥 Hospital Management System

A full-stack web-based Hospital Management System built using **Java (JSP + Servlet), JDBC, and MySQL**.
This project allows Admin, Doctors, and Patients to manage hospital operations efficiently.

---

## 🚀 Features

### 👨‍💼 Admin

* Add Doctors (with login credentials)
* View Doctors list
* Delete Doctors
* View all Patients
* View all Appointments

---

### 🩺 Doctor

* Login using credentials created by Admin
* View assigned Appointments
* Approve / Reject appointments
* Track patient requests

---

### 🧑‍🤝‍🧑 Patient

* Register & Login
* Book Appointment with Doctor
* View Appointment Status (Pending / Approved / Rejected)

---

## 🧠 System Flow

1. Admin adds Doctor → stored in `users` + `doctors`
2. Patient registers → stored in `users` + `patients`
3. Patient books appointment → stored in `appointments`
4. Doctor views appointments → updates status
5. Patient sees updated status

---

## 🛠️ Tech Stack

* **Frontend:** JSP, HTML, CSS
* **Backend:** Java Servlets, JDBC
* **Database:** MySQL
* **Server:** Apache Tomcat
* **Version Control:** Git & GitHub

---

## 🗂️ Project Structure

```
hospital-management/
│
├── src/
│   ├── servlet/
│   ├── dao/
│   ├── model/
│   └── util/
│
├── webapp/
│   ├── *.jsp
│   └── css/
│
├── pom.xml
└── README.md
```

---

## 🗄️ Database Design

### 🔹 users

| id | name | email | password | role |
| -- | ---- | ----- | -------- | ---- |

### 🔹 doctors

| id | name | specialization | phone | user_id |

### 🔹 patients

| id | name | age | gender | phone | disease | user_id |

### 🔹 appointments

| id | patient_id | doctor_id | appointment_date | status |

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/hospital-management.git
```

### 2️⃣ Import in IDE

* Open Eclipse / IntelliJ
* Import as Maven Project

### 3️⃣ Setup Database

* Create MySQL database
* Run SQL scripts (tables creation)

### 4️⃣ Configure DB Connection

Update:

```java
DBConnection.java
```

### 5️⃣ Run on Server

* Deploy on Apache Tomcat
* Open:

```
http://localhost:8080/hospital-management
```

---

## 🔐 Default Roles

* Admin → manually created in DB
* Doctor → created by Admin
* Patient → self registration

---

## 🧪 Sample Workflow

```text
Admin → Add Doctor
Patient → Register → Login
Patient → Book Appointment
Doctor → Login → Approve/Reject
Patient → View Status
```

---

## 💡 Key Highlights

* Role-based authentication
* Clean MVC structure (DAO + Servlet + JSP)
* Database relationships (Foreign Keys)
* Real-world workflow implementation

---

## 🚀 Future Enhancements

* Forgot Password system
* Appointment time slots
* Search/filter doctors
* Dashboard analytics
* Responsive UI

---

## 👨‍💻 Author

**Giri**

---

## ⭐ If you like this project

Give it a ⭐ on GitHub and share with others!
