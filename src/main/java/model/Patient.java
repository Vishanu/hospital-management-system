package model;

public class Patient {
    private int id;
    private String name;
    private int age;
    private String gender;
    private String phone;
    private String disease;

    // 🔥 ADD THIS
    private int userId;

    public Patient() {}

    public Patient(String name, int age, String gender, String phone, String disease) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.phone = phone;
        this.disease = disease;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDisease() { return disease; }
    public void setDisease(String disease) { this.disease = disease; }

    // 🔥 FIXED METHODS
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}