package servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.UserDAO;
import dao.PatientDAO;
import model.Patient;

@WebServlet("/register")
public class Register extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        UserDAO userDao = new UserDAO();
        boolean status = userDao.register(name, email, password, role);

        if (status) {

            // 🔥 user_id निकालो
            int userId = userDao.getUserId(email);

            // 🔥 अगर patient है तो patients table में proper insert
            if ("patient".equals(role)) {

                Patient p = new Patient();

                p.setName(name);

                // 👉 safe defaults (kyunki register.jsp me ye fields nahi hain)
                p.setAge(0);
                p.setGender("NA");
                p.setPhone("0000000000");
                p.setDisease("NA");

                // 🔥 MOST IMPORTANT
                p.setUserId(userId);

                PatientDAO pdao = new PatientDAO();
                pdao.addPatient(p);
            }

            res.sendRedirect("login.jsp?msg=registered");

        } else {
            res.sendRedirect("register.jsp?error=failed");
        }
    }
}