package servlet;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import dao.DoctorDAO;

@WebServlet("/deleteDoctor")   // 🔥 VERY IMPORTANT
public class DeleteDoctor extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            DoctorDAO dao = new DoctorDAO();

// 🔥 STEP 1: get user_id
            int userId = dao.getUserIdByDoctorId(id);

// 🔥 STEP 2: delete doctor
            boolean doctorDeleted = dao.deleteDoctor(id);

// 🔥 STEP 3: delete user
            UserDAO userDao = new UserDAO();
            boolean userDeleted = userDao.deleteUser(userId);

            if(doctorDeleted){
                res.sendRedirect("viewDoctors.jsp");
            }else{
                res.sendRedirect("viewDoctors.jsp?error=failed");
            }

        } catch(Exception e){
            e.printStackTrace();
            res.sendRedirect("viewDoctors.jsp?error=exception");
        }
    }
}