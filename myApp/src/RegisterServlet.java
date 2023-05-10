import javax.servlet.*;
import javax.servlet.http.*;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;

import backend.Account;
import backend.Authenticator;

import java.io.*;

public class RegisterServlet extends HttpServlet {

    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        ServletContext ctx = getServletContext();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        Gson json = new Gson();

        PrintWriter out = response.getWriter();

        try{
            Account acc = Authenticator.createAccount(username, password, confirm, ctx);
            String tmp = json.toJson(acc);
            out.println(tmp);
        }catch(RuntimeException e){
            out.println(e.getMessage());
            response.setStatus(Response.Status.BAD_REQUEST.getStatusCode());
        }
    }
}
