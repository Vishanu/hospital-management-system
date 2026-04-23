import dao.DoctorDAO;
import model.Doctor;

import java.util.Scanner;

public class MainApp {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        DoctorDAO dao = new DoctorDAO();

        System.out.println("Enter Doctor Name:");
        String name = sc.nextLine();

        System.out.println("Enter Specialization:");
        String spec = sc.nextLine();

        System.out.println("Enter Phone:");
        String phone = sc.nextLine();

        Doctor doctor = new Doctor(name, spec, phone);
        dao.addDoctor(doctor);
    }
}