import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws SQLException {
        Connection conn = null;
        String url = "jdbc:sqlite:path-to-db/chinook/chinook.db";
        conn = DriverManager.getConnection(url);

        System.out.println("Nåværende bud er på:");
        System.out.println("Hvor mye ekstra vil du by?");
        Scanner s = new Scanner(System.in);
        int bidDifference = s.nextInt();
        System.out.println("Byr " + bidDifference);
    }
}
