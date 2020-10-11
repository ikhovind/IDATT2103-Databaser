

import javax.persistence.*;
import java.io.File;
import java.net.MalformedURLException;
@Entity
public class Bid {
    @Id
    private int id;
    private String name;
    private int bid;
    public Bid(String name, int originalBid){
        id = 1;
        this.name = name;
        this.bid = originalBid;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getBid() {
        return bid;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }
}

