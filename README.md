# 🎓 Student Feedback System

A web-based Student Feedback Management System built using Java Servlets, JSP, JDBC, and MySQL, deployed on Apache Tomcat.

---

## 📌 Project Description

This project is a college-level web application where an admin can manage students, subjects, and collect feedback from students about their teachers and subjects. It replaces the traditional paper-based feedback system with a digital solution.

---

## 🚀 Features

- 🔐 **Admin Login / Logout** — Secure session-based authentication
- 👨‍🎓 **Manage Students** — Add and delete student records
- 📚 **Manage Subjects** — Add subjects with teacher names
- 💬 **Submit Feedback** — Record student feedback with star ratings and comments
- 📊 **View Reports** — See all feedback in one organized table

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java Servlets | Handle business logic and form submissions |
| JSP | Dynamic web pages |
| JDBC | Java to MySQL database connection |
| MySQL | Database to store all data |
| Apache Tomcat 10 | Web application server |
| Maven | Dependency and build management |
| Bootstrap 5 | Frontend UI styling |
| HTML/CSS | Web page structure and design |

---

## 🗄️ Database Design

```sql
USE college;

-- Admin Table
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

-- Students Table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    year INT NOT NULL
);

-- Subjects Table
CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    teacher_name VARCHAR(100) NOT NULL
);

-- Feedback Table
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    rating INT NOT NULL,
    comments TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);
```

---

---

## ⚙️ How to Run

### Prerequisites
- Java JDK 21
- Apache Tomcat 10
- MySQL
- Maven

### Steps

1. **Clone the repository**
```bash
git clone https://github.com/ayushsingh721/StudentFeedbackSystem.git
```

2. **Setup Database**
```bash
# Open MySQL and run all SQL commands from Database Design section above
```

3. **Update DB credentials in `DBConnection.java`**
```java
con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college",
    "root",
    "your_password"
);
```

4. **Build the project**
```bash
mvn clean package
```

5. **Deploy WAR to Tomcat**



## 👨‍💻 Developer

- **Name:** Ayushmaan Singh
- **Project:** College Java Web Development Project
- **Stack:** Java + JSP + Servlets + JDBC + MySQL + Tomcat
