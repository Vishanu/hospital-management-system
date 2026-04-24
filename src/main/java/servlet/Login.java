package servlet;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        String role = dao.login(email, password);

        HttpSession session = req.getSession();

// 🔥 IMPORTANT
        int id = dao.getUserId(email);

        session.setAttribute("userId", id);
        session.setAttribute("role", role);
        session.setAttribute("email", email);

        if ("admin".equals(role)) {

            res.sendRedirect("adminDashboard.jsp");

        } else if ("doctor".equals(role)) {

            res.sendRedirect("doctorDashboard.jsp");

        } else if ("patient".equals(role)) {

            res.sendRedirect("patientDashboard.jsp");

        } else {
            res.sendRedirect("login.jsp?error=invalid");
        }
    }
}