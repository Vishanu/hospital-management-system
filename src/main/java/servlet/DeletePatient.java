package servlet;

import dao.PatientDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deletePatient")
public class DeletePatient extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        PatientDAO dao = new PatientDAO();
        dao.deletePatientById(id);

        res.sendRedirect("viewPatients.jsp");
    }
}