package nadrabank.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "LOTS")
public class Lot implements Serializable, Comparable<Lot> {
    @Id
    @SequenceGenerator(name = "sequence", sequenceName = "LOT_SEQ", initialValue = 1, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequence")
    @Column(name = "ID")
    private Long id;
    @Column(name = "LotNum")
    private String lotNum;
    @Column(name = "Status")
    private String workStage;
    @Column(name = "Sold")
    private Boolean isItSold;
    @Column(name = "Comments")
    private String comment;
    @Column(name = "Lot_Created")
    private Date lotDate;
    @Column(name = "BID_Stage")
    private String bidStage;
    @Column(name = "COUNT_OF_PARTICIPANTS")
    private int countOfParticipants;
    @Column(name = "Start_PRICE")
    private int startPrice;
    @Column(name = "FIRST_Start_PRICE")
    private int firstStartPrice;
    @Column(name = "FACT_PRICE")
    private int factPrice;
    @Column(name = "CUSTOMER")
    private String customerName;
    @Column(name = "CUSTOMER_INN")
    private int customerInn;
    @Column(name = "RESULT_Status")
    private String status;
    @Column(name = "ACT_SIGNED_DATE")
    private Date actSignedDate;
    @Column(name="lot_Type")
    private int lotType;

    @Column(name = "PLAN_SALE_DATE")
    private Date planSaleDate;
    @Column(name = "ACCEPTED_EXCHANGE")
    private String acceptExchange;
    @Column(name = "NEED_NEW_FD")
    private boolean needNewFondDec;
    @Column(name = "FOND_DEC_DATE")
    private Date fondDecisionDate;
    @Column(name = "FOND_DECISION")
    private String fondDecision;
    @Column(name = "FOND_DECISION_NUM")
    private String decisionNumber;

    @ManyToOne
    private User user;//класс
    @ManyToOne
    private Bid bid;//класс

    @Override
    public int compareTo(Lot entryLot) {
        if(entryLot.getBid()==null)
            return 1;
        else if(bid==null)
            return -1;
        else
        return bid.compareTo(entryLot.bid);
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getWorkStage() {
        return workStage;
    }
    public void setWorkStage(String workStage) {
        this.workStage = workStage;
    }

    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getLotDate() {
        return lotDate;
    }
    public void setLotDate(Date lotDate) {
        this.lotDate = lotDate;
    }

    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getItSold() {
        return isItSold;
    }
    public void setItSold(Boolean itSold) {
        isItSold = itSold;
    }

    public int getStartPrice() {
        return startPrice;
    }
    public void setStartPrice(int startPrice) {
        this.startPrice = startPrice;
    }

    public int getFactPrice() {
        return factPrice;
    }
    public void setFactPrice(int factPrice) {
        this.factPrice = factPrice;
    }

    public String getLotNum() {
        return lotNum;
    }
    public void setLotNum(String lotNum) {
        this.lotNum = lotNum;
    }

    public Bid getBid() {
        return bid;
    }
    public void setBid(Bid bid) {
        this.bid = bid;
    }

    public String getBidStage() {
        return bidStage;
    }
    public void setBidStage(String bidStage) {
        this.bidStage = bidStage;
    }

    public int getCountOfParticipants() {
        return countOfParticipants;
    }
    public void setCountOfParticipants(int countOfParticipants) {
        this.countOfParticipants = countOfParticipants;
    }

    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public int getFirstStartPrice() {
        return firstStartPrice;
    }
    public void setFirstStartPrice(int firstStartPrice) {
        this.firstStartPrice = firstStartPrice;
    }

    public Date getActSignedDate() {
        return actSignedDate;
    }
    public void setActSignedDate(Date actSignedDate) {
        this.actSignedDate = actSignedDate;
    }

    public int getLotType() {
        return lotType;
    }
    public void setLotType(int lotType) {
        this.lotType = lotType;
    }

    public Date getPlanSaleDate() {
        return planSaleDate;
    }
    public void setPlanSaleDate(Date planSaleDate) {
        this.planSaleDate = planSaleDate;
    }

    public String getAcceptExchange() {
        return acceptExchange;
    }
    public void setAcceptExchange(String acceptExchange) {
        this.acceptExchange = acceptExchange;
    }

    public boolean isNeedNewFondDec() {
        return needNewFondDec;
    }
    public void setNeedNewFondDec(boolean needNewFondDec) {
        this.needNewFondDec = needNewFondDec;
    }

    public Date getFondDecisionDate() {
        return fondDecisionDate;
    }
    public void setFondDecisionDate(Date fondDecisionDate) {
        this.fondDecisionDate = fondDecisionDate;
    }

    public String getFondDecision() {
        return fondDecision;
    }
    public void setFondDecision(String fondDecision) {
        this.fondDecision = fondDecision;
    }

    public String getDecisionNumber() {
        return decisionNumber;
    }
    public void setDecisionNumber(String decisionNumber) {
        this.decisionNumber = decisionNumber;
    }

    public int getCustomerInn() {
        return customerInn;
    }
    public void setCustomerInn(int customerInn) {
        this.customerInn = customerInn;
    }

    //Конструктора
    public Lot() {
    }

    public Lot(String comment, User user, Date lotDate, int lotType) {
        this.workStage = "Новий лот";
        this.isItSold = false;
        this.comment = comment;
        this.user = user;
        this.lotDate = lotDate;
        this.countOfParticipants=0;
        this.bidStage="Перші торги";
        this.lotType=lotType;
        this.planSaleDate = null;
        this.acceptExchange = null;
        this.needNewFondDec = false;
        this.fondDecisionDate = null;
        this.fondDecision = null;
        this.decisionNumber = null;
        this.bid = null;
        this.customerInn = 0;
    }

    public Lot(String lotNum, String workStage, Boolean isItSold, String comment, Date lotDate, String bidStage, int countOfParticipants, int startPrice, int firstStartPrice, int factPrice, String customerName, String status, Date actSignedDate, int lotType, Date planSaleDate, String acceptExchange, boolean needNewFondDec, Date fondDecisionDate, String fondDecision, String decisionNumber, User user, Bid bid, int customerInn) {
        this.lotNum = lotNum;
        this.workStage = workStage;
        this.isItSold = isItSold;
        this.comment = comment;
        this.lotDate = lotDate;
        this.bidStage = bidStage;
        this.countOfParticipants = countOfParticipants;
        this.startPrice = startPrice;
        this.firstStartPrice = firstStartPrice;
        this.factPrice = factPrice;
        this.customerName = customerName;
        this.status = status;
        this.actSignedDate = actSignedDate;
        this.lotType = lotType;
        this.planSaleDate = planSaleDate;
        this.acceptExchange = acceptExchange;
        this.needNewFondDec = needNewFondDec;
        this.fondDecisionDate = fondDecisionDate;
        this.fondDecision = fondDecision;
        this.decisionNumber = decisionNumber;
        this.user = user;
        this.bid = bid;
        this.customerInn = customerInn;
    }

    @Override
    public String toString() {
        return "Lot{" +
                "id=" + id +
                ", lotNum='" + lotNum + '\'' +
                ", workStage='" + workStage + '\'' +
                ", isItSold=" + isItSold +
                ", comment='" + comment + '\'' +
                ", lotDate=" + lotDate +
                ", bidStage='" + bidStage + '\'' +
                ", countOfParticipants=" + countOfParticipants +
                ", startPrice=" + startPrice +
                ", firstStartPrice=" + firstStartPrice +
                ", factPrice=" + factPrice +
                ", customerName='" + customerName + '\'' +
                ", customerInn=" + customerInn +
                ", status='" + status + '\'' +
                ", actSignedDate=" + actSignedDate +
                ", lotType=" + lotType +
                ", planSaleDate=" + planSaleDate +
                ", acceptExchange='" + acceptExchange + '\'' +
                ", needNewFondDec=" + needNewFondDec +
                ", fondDecisionDate=" + fondDecisionDate +
                ", fondDecision='" + fondDecision + '\'' +
                ", decisionNumber='" + decisionNumber + '\'' +
                ", user=" + user +
                ", bid=" + bid +
                '}';
    }
}