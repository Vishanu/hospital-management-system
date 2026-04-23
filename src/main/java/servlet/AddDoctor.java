package servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.DoctorDAO;
import model.Doctor;

@WebServlet("/addDoctor")
public class AddDoctor extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("role");

        // 🔐 Only admin allowed
        if (role == null || !role.equals("admin")) {
            res.sendRedirect("login.jsp");
            return;
        }

        try {
            String name = req.getParameter("name");
            String specialization = req.getParameter("specialization");
            String phone = req.getParameter("phone");

            Doctor d = new Doctor();
            d.setName(name);
            d.setSpecialization(specialization);
            d.setPhone(phone);

            DoctorDAO dao = new DoctorDAO();
            boolean status = dao.addDoctor(d);

            if (status) {
                res.sendRedirect("addDoctor.jsp?msg=success");
            } else {
                res.sendRedirect("addDoctor.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("addDoctor.jsp?error=exception");
        }
    }
}