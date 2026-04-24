package servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.DoctorDAO;
import dao.UserDAO;
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

            String email = req.getParameter("email");
            String password = req.getParameter("password");

            UserDAO userDao = new UserDAO();

            // 🔥 CHECK: email already exists
            if (userDao.getUserId(email) != 0) {
                res.sendRedirect("addDoctor.jsp?error=exist");
                return;
            }

            // 🔥 STEP 1: insert into users table
            boolean userCreated = userDao.register(name, email, password, "doctor");

            if (!userCreated) {
                res.sendRedirect("addDoctor.jsp?error=userfail");
                return;
            }

            // 🔥 STEP 2: get userId
            int userId = userDao.getUserId(email);

            // 🔥 STEP 3: insert into doctors table
            Doctor d = new Doctor();
            d.setName(name);
            d.setSpecialization(specialization);
            d.setPhone(phone);
            d.setUserId(userId);

            DoctorDAO dao = new DoctorDAO();
            boolean status = dao.addDoctor(d);

            if (status) {
                res.sendRedirect("addDoctor.jsp?msg=success");
            } else {
                res.sendRedirect("addDoctor.jsp?error=doctorfail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("addDoctor.jsp?error=exception");
        }
    }
}