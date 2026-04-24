package model;

public class Doctor {
    private int id;
    private String name;
    private String specialization;
    private String phone;
    private int userId;

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Doctor() {}

    public Doctor(String name, String specialization, String phone) {
        this.name = name;
        this.specialization = specialization;
        this.phone = phone;
    }

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}