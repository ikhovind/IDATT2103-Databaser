import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.io.File;
import java.net.MalformedURLException;
import java.util.*;
import java.util.stream.Collectors;

public class BidManager {
    private boolean isInitialized = false;
    private EntityManagerFactory emf;
    private static BidManager imageDatabase = null;
    Bid bid;

    BidManager(int minimumBid) {
        Bid bid = new Bid("minimum bid", minimumBid);
        Properties properties = new Properties();
        properties.put("javax.persistence.jdbc.url", "jdbc:mysql://mysql.stud.iie.ntnu.no:3306/ikhovind");
        properties.put("javax.persistence.jdbc.user", "ikhovind");
        emf = javax.persistence.Persistence.createEntityManagerFactory("DatabasePU", properties);
    }

    public boolean makeBid(String name, int additionalBid){
        EntityManager em = getEM();
        try {
            em.getTransaction().begin();
            
        } finally {
            closeEM(em);
        }

    }
    private EntityManager getEM() {
        return emf.createEntityManager();
    }

    private void closeEM(EntityManager em) {
        if (em != null && em.isOpen()) {
            em.close();
        }

    }
}
