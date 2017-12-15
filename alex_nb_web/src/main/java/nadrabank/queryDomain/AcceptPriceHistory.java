package nadrabank.queryDomain;

import java.io.Serializable;
import java.util.Date;

public class AcceptPriceHistory implements Serializable {

    private Date date;
    private int acceptedPrice;

    public AcceptPriceHistory() {
    }
    public AcceptPriceHistory(Date date, int acceptedPrice) {
        this.date = date;
        this.acceptedPrice = acceptedPrice;
    }

    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }

    public int getAcceptedPrice() {
        return acceptedPrice;
    }
    public void setAcceptedPrice(int acceptedPrice) {
        this.acceptedPrice = acceptedPrice;
    }

    @Override
    public String toString() {
        return "AcceptPriceHistory{" +
                "date=" + date +
                ", acceptedPrice=" + acceptedPrice +
                '}';
    }

}
