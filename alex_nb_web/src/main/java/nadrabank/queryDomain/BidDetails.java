package nadrabank.queryDomain;

import java.io.Serializable;

public class BidDetails implements Serializable {

    private Long bidId;
    private int startPrice;

    public BidDetails() {
    }
    public BidDetails(Long bidId, int startPrice) {
        this.bidId = bidId;
        this.startPrice = startPrice;
    }

    public Long getBidId() {
        return bidId;
    }
    public void setBidId(Long bidId) {
        this.bidId = bidId;
    }

    public int getStartPrice() {
        return startPrice;
    }
    public void setStartPrice(int startPrice) {
        this.startPrice = startPrice;
    }

    @Override
    public String toString() {
        return "BidDetails{" +
                "bidId=" + bidId +
                ", startPrice=" + startPrice +
                '}';
    }
}
