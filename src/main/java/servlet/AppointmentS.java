package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.AppointmentDAO;

@WebServlet("/bookAppointment")
public class AppointmentS extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        // 🔐 Only patient allowed
        if (role == null || !role.equals("patient")) {
            res.sendRedirect("login.jsp");
            return;
        }

        try {
            String doctorParam = req.getParameter("doctorId");
            String date = req.getParameter("date");

            // 🔥 Validation
            if (doctorParam == null || doctorParam.isEmpty() || date == null || date.isEmpty()) {
                res.sendRedirect("bookAppointment.jsp?error=invalid");
                return;
            }

            int doctorId = Integer.parseInt(doctorParam);
            Integer patientId = (Integer) session.getAttribute("userId");

            if (patientId == null) {
                res.sendRedirect("login.jsp");
                return;
            }

            AppointmentDAO dao = new AppointmentDAO();
            boolean status = dao.bookAppointment(patientId, doctorId, date);

            if (status) {
                // ✅ SUCCESS REDIRECT WITH MESSAGE
                res.sendRedirect("patientDashboard.jsp?msg=booked");
            } else {
                res.sendRedirect("bookAppointment.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("bookAppointment.jsp?error=exception");
        }
    }
}