package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.UserDAO;

@WebServlet("/register")
public class Register extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // patient / doctor

        UserDAO dao = new UserDAO();
        boolean status = dao.register(name, email, password, role);

        if (status) {
            res.sendRedirect("login.jsp?msg=registered");
        } else {
            res.sendRedirect("register.jsp?error=failed");
        }
    }
}