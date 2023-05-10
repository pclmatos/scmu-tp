import javax.servlet.*;
import javax.servlet.http.*;
import javax.ws.rs.core.Response;

import backend.Authenticator;

import java.io.*;

public class LogoutServlet extends HttpServlet {

    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

            PrintWriter out = response.getWriter();

            try{
                Authenticator.logout(request.getParameter("username"), getServletContext());
                response.setStatus(Response.Status.OK.getStatusCode());
            }catch(RuntimeException e){
                response.setStatus(Response.Status.BAD_REQUEST.getStatusCode());
                out.println(e.getMessage());
            }

    }
}
