package servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.AppointmentDAO;

@WebServlet("/updateStatus")
public class UpdateStatus extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("role");

        // 🔐 Only doctor allowed
        if (role == null || !role.equals("doctor")) {
            res.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");

            if (status == null || status.isEmpty()) {
                res.sendRedirect("viewAppointments.jsp?error=invalid");
                return;
            }

            AppointmentDAO dao = new AppointmentDAO();
            dao.updateAppointmentStatus(id, status);

            res.sendRedirect("viewAppointments.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("viewAppointments.jsp?error=failed");
        }
    }
}