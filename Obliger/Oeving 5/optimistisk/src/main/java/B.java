import java.io.Console;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.*;


public class B {
    public static void main(String[] args) {

        try {
            //Hvorfor får jeg ikke dette til å kjøre i command line
            Connection con=DriverManager.getConnection(
                "jdbc:mysql://mysql.stud.iie.ntnu.no:3306/ikhovind","ikhovind","");
            //here sonoo is database name, root is username and password
            Scanner scanner = new Scanner(System.in);
            System.out.println("ISBN:");
            String isbn = scanner.nextLine();

            PreparedStatement p = con.prepareStatement("select forfatter, tittel from boktittel where isbn = '" + isbn+"';");
            PreparedStatement p2 = con.prepareStatement("select count(*) antall from eksemplar where isbn = '" + isbn + "';");

            p.execute();
            p2.execute();

            if(p.getResultSet().next()) System.out.println(p.getResultSet().getString("forfatter") + " " + p.getResultSet().getString("tittel"));
            if (p2.getResultSet().next()) {
                System.out.println("antall eksemplarer: " + p2.getResultSet().getInt("antall"));
            }

            System.out.println("Utlånsprogram -----------------------------");
            System.out.println("ISBN til boken du vil låne ut:");
            String utlånt = scanner.nextLine();
            System.out.println("Navn til låneren");
            String låneNavn = scanner.nextLine();
            System.out.println("Eksemplarnummer du vil låne ut");
            String eksemplarNummer = scanner.nextLine();

            PreparedStatement utlaan =
                con.prepareStatement("UPDATE eksemplar SET laant_av = '" + låneNavn + "' WHERE " +
                    "isbn = '" + utlånt + "' AND eks_nr = '" + eksemplarNummer + "' and laant_av " +
                    "is null");

            PreparedStatement sjekk = con.prepareStatement("select isbn, eks_nr from eksemplar " +
                "where laant_av = '" + låneNavn + "';");
            sjekk.execute();
            if(utlaan.executeUpdate() > 0){
                System.out.println("Boken er nå lånt ut");
            }
            else{
                System.out.println("Det skjedde en feil\nDet kan skyldes ugyldig isbn, ugyldig eksemplarnr eller at eksemplaret allerede er utlånt");
            }

        } catch(Exception ex) {
            // if any error occurs
            ex.printStackTrace();
        }
    }

    public static void opgB(){

    }

}
