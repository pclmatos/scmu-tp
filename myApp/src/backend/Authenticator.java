package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

public class Authenticator {

    public static Account createAccount(String name, String pwd1, String pwd2, ServletContext ctx) {
        String query = "INSERT INTO accounts(name,pwd) VALUES(?,?)";
        Account acc = null;
        if (pwd1 == "") {
            throw new RuntimeException("Missing password!");
        } else if (pwd2 == "") {
            throw new RuntimeException("Missing confirmation!");
        } else if (!pwd1.equals(pwd2)) {
            throw new RuntimeException("Password and confirmation don't match!");

        } else {
            try {
                acc = getAccount(name, ctx);

                if (acc != null) {
                    throw new RuntimeException("Account already exists.");
                }
                ;
            } catch (UndefinedAccountException e) {
                try {
                    List<String> queryParams = new ArrayList<>();

                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    md.update(pwd1.getBytes());
                    String pwd = byteArrayToHex(md.digest());

                    queryParams.add(name);
                    queryParams.add(pwd);
                    updateDb(query, queryParams, ctx);

                    acc = new Account(name, pwd);

                    return acc;
                } catch (NoSuchAlgorithmException d) {
                    e.printStackTrace();
                }
            }
        }
        return null;

    }

    public static Account getAccount(String name, ServletContext ctx) {
        String query = "SELECT name,pwd FROM accounts WHERE name = ?";
        Account acc = null;

        try {
            Connection c = DBConnection.connnect(ctx);
            PreparedStatement ps = c.prepareStatement(query);

            ps.setString(1, name);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                acc = new Account(rs.getString("name"), rs.getString("pwd"));
            } else {
                ps.close();
                c.close();
                throw new UndefinedAccountException();
            }
            ps.close();
            c.close();
            return acc;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return acc;

    }

    public static Account login(String name, String pwd, String sessionId, ServletContext ctx) {
        Account acc = getAccount(name, ctx);

        if (acc == null) {
            throw new UndefinedAccountException();
        } else if (verifySession(name   , ctx)) {
            throw new RuntimeException("Account is logged in!");
        } else {
            doLogin(acc, name, pwd, sessionId, ctx);
        }

        return acc;
    }

    public static void logout(String name, ServletContext ctx) {
        List<String> params = new ArrayList<>();
        if (!verifySession(name, ctx)) {
            throw new RuntimeException("User isn't logged in!");
        } else {
            params.add(name);
            updateDb("DELETE FROM sessions WHERE username = ?", params, ctx);
        }
    }

    private static void updateDb(String query, List<String> params, ServletContext ctx) {
        try {
            Connection c = DBConnection.connnect(ctx);
            PreparedStatement ps = c.prepareStatement(query);

            int i = 1;
            for (String s : params) {
                ps.setString(i++, s);
            }

            ps.executeUpdate();

            ps.close();
            c.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String byteArrayToHex(byte[] a) {
        StringBuilder sb = new StringBuilder(a.length * 2);

        for (byte b : a)
            sb.append(String.format("%02x", b));
        return sb.toString();
    }

    private static boolean doLogin(Account acc, String name, String pwd, String sessionId, ServletContext ctx) {
        List<String> queryParams = new ArrayList<>();

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(pwd.getBytes());

            String testPwd = byteArrayToHex(md.digest());
            String realPwd = acc.password;

            if (!testPwd.equals(realPwd)) {
                throw new AuthenticationErrorException();
            } else {
                queryParams.add(name);
                queryParams.add(sessionId);
                updateDb("INSERT INTO sessions(username,id) VALUES (?,?)", queryParams, ctx);
                return true;
            }
        } catch (

        NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return false;
    }

    private static boolean verifySession(String name, ServletContext ctx) {
        String query = "select username,id from sessions where username = ?";

        try {
            Connection c = DBConnection.connnect(ctx);
            PreparedStatement ps = c.prepareStatement(query);

            ps.setString(1, name);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ps.close();
                c.close();
                return true;
            }

            ps.close();
            c.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /*public static boolean checkAuthenticatedRequest(HttpSession session, ServletContext ctx) {
        String username = (String) session.getAttribute("username");
        String sessionId = session.getId();
        return verifySession(username ctx);
    }*/

}
