import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.*;


public class Main{
    public static void main(String args[]){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection(
                "jdbc:mysql://mysql.stud.iie.ntnu.no:3306/ikhovind","ikhovind","Blo33G6F");
            //here sonoo is database name, root is username and password
            Statement stmt=con.createStatement();
            stmt.execute("SET AUTOCOMMIT = 0;");
            stmt.execute("SET TRANSACTION ISOLATION LEVEL READ COMMITTED;");
            stmt.close();

            Scanner s = new Scanner(System.in);
            Statement bid = con.createStatement();
            ResultSet rs = bid.executeQuery("select bud from budrunde");
            if(rs.next()){
                int currentBid = rs.getInt(1);

                System.out.println("hva heter du");
                String name = s.nextLine();
                System.out.println("hvor mye over vil du by");
                int additionalBid = s.nextInt();

                //budet før vi gjør endringer
                rs.close();
                //sjekk
                bid.execute("UPDATE budrunde set bud = bud + " + additionalBid + ", navn= " + "'" + name + "'" +";");
                //sjekker budet
                //sjekker bud


                //lås fra
                ResultSet updatedBid = bid.executeQuery("select bud from budrunde");

                //dersom noen har rukket å by før oss

                if(updatedBid.next() && updatedBid.getInt(1) == currentBid + additionalBid){
                    System.out.println("Du har nå det høyeste budet med " + currentBid + additionalBid + " kr");
                    bid.execute("commit;");
                    //lås til


                }
                else{
                    System.out.println("Noen andre har bydd og budet ditt gikk ikke gjennom");
                    bid.execute("ROLLBACK;");
                }
            }

            bid.close();
            con.close();
        }catch(Exception e){ System.out.println(e);}
    }
}
