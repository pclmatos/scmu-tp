package backend;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.util.Properties;

import javax.servlet.ServletContext;

public class DBConnection {

    public static Connection connnect(ServletContext ctx) {
        String dbPath = "";
        Connection conn = null;
        
        try {
            Class.forName("org.sqlite.JDBC");
            InputStream fis = ctx.getResourceAsStream("/WEB-INF/data/config.props");

            Properties conf = new Properties();
            conf.load(fis);
        
            dbPath = conf.getProperty("path");

            String dbUrl = String.format("jdbc:sqlite:%s", ctx.getRealPath(dbPath));

            conn = DriverManager.getConnection(dbUrl);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }

        return conn;

    }

}
