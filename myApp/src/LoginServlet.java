import javax.servlet.*;
import javax.servlet.http.*;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;

import backend.*;

import java.io.*;

public class LoginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        ServletContext ctx = getServletContext();

        HttpSession session = request.getSession();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Gson json = new Gson();

        PrintWriter out = response.getWriter();
        try {
            Account acc = Authenticator.login(username, password,session.getId(),ctx);
            String tmp = json.toJson(acc.username);
            session.setAttribute("username", acc.username);
            System.out.println(session.getAttribute("username"));
            out.println(tmp);
        } catch (RuntimeException e) {
            response.setStatus(Response.Status.BAD_REQUEST.getStatusCode());
            out.println(e.getMessage());
        }


    }

}
