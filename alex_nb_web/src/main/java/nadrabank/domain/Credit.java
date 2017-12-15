package nadrabank.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Entity
@Table(name = "Credits")
public class Credit implements Serializable {
    static final SimpleDateFormat sdfshort = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);

    @Id
    @SequenceGenerator(name = "sequence", sequenceName = "Credit_SEQ", initialValue = 1, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequence")
    @Column(name = "KEY_N")
    private Long id;
    @Column(name = "ND_NLS")
    private Long nd;
    @Column(name = "REGION")
    private String region;
    @Column(name = "MFO")
    private String mfo;
    @Column(name = "TYPE_CODE")
    private String assetTypeCode;
    @Column(name = "GROUP_CODE")
    private String assetGroupCode;
    @Column(name = "TYPE_CLIENT")
    private String clientType;
    @Column(name = "PRODUCT")
    private String product;
    @Column(name = "ZAST")
    private String zast;
    @Column(name = "F_IDCODE")
    private String inn;
    @Column(name = "CLIENT_NAME")
    private String fio;
    @Column(name = "AGREEMENT_NUMBER")
    private String contractNum;
    @Column(name = "START_DATE")
    private Date contractStart;
    @Column(name = "END_DATE")
    private Date contractEnd;
    @Column(name = "FX_NUMBER")
    private String curr;
    @Column(name = "INTEREST")
    private int interestRate;
    @Column(name = "CONTRACT_SUM_FX")
    private int contractSumVal;
    @Column(name = "CONTRACT_SUM_UAH")
    private int contractSumUAH;
    @Column(name = "ACA_UAH_EVA")
    private int zbRateDay;
    @Column(name = "BODY_UAH")
    private int bodyUAH;
    @Column(name = "PRC_UAH")
    private int prcUAH;
    @Column(name = "COMMIS")
    private int comission;
    @Column(name = "ACA_UAH")
    private int zb;
    @Column(name = "DPD_NEW")
    private int dpd;
    @Column(name = "FDAT")
    private Date lastPayDate;
    @Column(name = "RV_BEZ_PDV_UAH")
    private int ratingPriceNoPDV;
    @Column(name = "RV_UAH")
    private int rv;
    @Column(name = "KAT")
    private String nbuRate;
    @Column(name = "FIN")
    private String ownerClass;
    @Column(name = "TIP_ZASTAVI")
    private String gageType;
    @Column(name = "VID_ZASTAVI")
    private String gageVid;
    @Column(name = "S031")
    private String gageCode;
    @Column(name = "RV_DISCOUNT_UAH")
    private int discountPrice;

    @Column(name = "Start_PRICE")
    private int startPrice;
    @Column(name = "FIRST_Start_PRICE")
    private int firstStartPrice;

    @Column(name = "FACT_SALE_PRICE_UAH")
    private int factPrice;
    @Column(name = "ZASTAVA_NBU_GIOC")
    private String nbuPladge;
    @Column(name = "IS_IT_SOLD")
    private Boolean isSold;
    /*@Column(name = "FOND_DEC_DATE")
    private Date fondDecisionDate;
    @Column(name = "FOND_DECISION")
    private String fondDecision;
    @Column(name = "FOND_DECISION_NUM")
    private String decisionNumber;*/
    @Column(name = "ACCEPTED_PRICE")
    private int acceptPrice;
    @Column(name = "PAYMENTS_BID")
    private int paysBid;
    @Column(name = "PAYMENTS_CUSTOMER")
    private int paysCustomer;
    @Column(name = "LAST_BID_PAY_DATE")
    private Date bidPayDate;
    @Column(name = "LAST_CUSTOMER_PAY_DATE")
    private Date customerPayDate;
    @Column(name = "PLAN_SALE_DATE")
    private Date planSaleDate;
    /*@Column(name = "ACCEPTED_EXCHANGE")
    private String acceptExchange;
    @Column(name = "NEED_NEW_FD")
    private boolean neadNewFondDec;*/

    @Column(name = "LOT_ID")
    private Long lot;

    public Long getNd() {
        return nd;
    }
    public void setNd(Long nd) {
        this.nd = nd;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getRegion() {
        return region;
    }
    public void setRegion(String region) {
        this.region = region;
    }

    public String getMfo() {
        return mfo;
    }
    public void setMfo(String mfo) {
        this.mfo = mfo;
    }

    public String getAssetTypeCode() {
        return assetTypeCode;
    }
    public void setAssetTypeCode(String assetTypeCode) {
        this.assetTypeCode = assetTypeCode;
    }

    public String getAssetGroupCode() {
        return assetGroupCode;
    }
    public void setAssetGroupCode(String assetGroupCode) {
        this.assetGroupCode = assetGroupCode;
    }

    public String getClientType() {
        return clientType;
    }
    public void setClientType(String clientType) {
        this.clientType = clientType;
    }

    public String getProduct() {
        return product;
    }
    public void setProduct(String product) {
        this.product = product;
    }

    public String getZast() {
        return zast;
    }
    public void setZast(String zast) {
        this.zast = zast;
    }

    public String getInn() {
        return inn;
    }
    public void setInn(String inn) {
        this.inn = inn;
    }

    public String getFio() {
        return fio;
    }
    public void setFio(String fio) {
        this.fio = fio;
    }

    public String getContractNum() {
        return contractNum;
    }
    public void setContractNum(String contractNum) {
        this.contractNum = contractNum;
    }

    public Date getContractStart() {
        return contractStart;
    }
    public void setContractStart(Date contractStart) {
        this.contractStart = contractStart;
    }

    public Date getContractEnd() {
        return contractEnd;
    }
    public void setContractEnd(Date contractEnd) {
        this.contractEnd = contractEnd;
    }

    public String getCurr() {
        return curr;
    }
    public void setCurr(String curr) {
        this.curr = curr;
    }

    public int getInterestRate() {
        return interestRate;
    }
    public void setInterestRate(int interestRate) {
        this.interestRate = interestRate;
    }

    public int getContractSumVal() {
        return contractSumVal;
    }
    public void setContractSumVal(int contractSumVal) {
        this.contractSumVal = contractSumVal;
    }

    public int getContractSumUAH() {
        return contractSumUAH;
    }
    public void setContractSumUAH(int contractSumUAH) {
        this.contractSumUAH = contractSumUAH;
    }

    public int getZbRateDay() {
        return zbRateDay;
    }
    public void setZbRateDay(int zbRateDay) {
        this.zbRateDay = zbRateDay;
    }

    public int getBodyUAH() {
        return bodyUAH;
    }
    public void setBodyUAH(int bodyUAH) {
        this.bodyUAH = bodyUAH;
    }

    public int getPrcUAH() {
        return prcUAH;
    }
    public void setPrcUAH(int prcUAH) {
        this.prcUAH = prcUAH;
    }

    public int getComission() {
        return comission;
    }
    public void setComission(int comission) {
        this.comission = comission;
    }

    public int getZb() {
        return zb;
    }
    public void setZb(int zb) {
        this.zb = zb;
    }

    public int getDpd() {
        return dpd;
    }
    public void setDpd(int dpd) {
        this.dpd = dpd;
    }

    public Date getLastPayDate() {
        return lastPayDate;
    }
    public void setLastPayDate(Date lastPayDate) {
        this.lastPayDate = lastPayDate;
    }

    public int getRatingPriceNoPDV() {
        return ratingPriceNoPDV;
    }
    public void setRatingPriceNoPDV(int ratingPriceNoPDV) {
        this.ratingPriceNoPDV = ratingPriceNoPDV;
    }

    public int getCreditPrice() {
        return rv;
    }
    public void setCreditPrice(int rv) {
        this.rv = rv;
    }

    public String getNbuRate() {
        return nbuRate;
    }
    public void setNbuRate(String nbuRate) {
        this.nbuRate = nbuRate;
    }

    public String getOwnerClass() {
        return ownerClass;
    }
    public void setOwnerClass(String ownerClass) {
        this.ownerClass = ownerClass;
    }

    public String getGageType() {
        return gageType;
    }
    public void setGageType(String gageType) {
        this.gageType = gageType;
    }

    public String getGageVid() {
        return gageVid;
    }
    public void setGageVid(String gageVid) {
        this.gageVid = gageVid;
    }

    public String getGageCode() {
        return gageCode;
    }
    public void setGageCode(String gageCode) {
        this.gageCode = gageCode;
    }

    public int getDiscountPrice() {
        return discountPrice;
    }
    public void setDiscountPrice(int discountPrice) {
        this.discountPrice = discountPrice;
    }

    public int getFactPrice() {
        return factPrice;
    }
    public void setFactPrice(int factPrice) {
        this.factPrice = factPrice;
    }

    public String getNbuPladge() {
        return nbuPladge;
    }
    public void setNbuPladge(String nbuPladge) {
        this.nbuPladge = nbuPladge;
    }

    public Boolean getSold() {
        return isSold;
    }
    public void setSold(Boolean sold) {
        isSold = sold;
    }

    public Long getLot() {
        return lot;
    }
    public void setLot(Long lot) {
        this.lot = lot;
    }

    public int getRv() {
        return rv;
    }
    public void setRv(int rv) {
        this.rv = rv;
    }

    public int getAcceptPrice() {
        return acceptPrice;
    }
    public void setAcceptPrice(int acceptPrice) {
        this.acceptPrice = acceptPrice;
    }

    public int getPaysBid() {
        return paysBid;
    }
    public void setPaysBid(int paysBid) {
        this.paysBid = paysBid;
    }

    public int getPaysCustomer() {
        return paysCustomer;
    }
    public void setPaysCustomer(int paysCustomer) {
        this.paysCustomer = paysCustomer;
    }

    public Date getBidPayDate() {
        return bidPayDate;
    }
    public void setBidPayDate(Date bidPayDate) {
        this.bidPayDate = bidPayDate;
    }

    public Date getCustomerPayDate() {
        return customerPayDate;
    }
    public void setCustomerPayDate(Date customerPayDate) {
        this.customerPayDate = customerPayDate;
    }

    public Date getPlanSaleDate() {
        return planSaleDate;
    }
    public void setPlanSaleDate(Date planSaleDate) {
        this.planSaleDate = planSaleDate;
    }

    public int getStartPrice() {
        return startPrice;
    }
    public void setStartPrice(int startPrice) {
        this.startPrice = startPrice;
    }

    public int getFirstStartPrice() {
        return firstStartPrice;
    }
    public void setFirstStartPrice(int firstStartPrice) {
        this.firstStartPrice = firstStartPrice;
    }

    public Credit() {
    }

    @Override
    public String toString() {
        return "Credit{" +
                "id=" + id +
                ", n=" + nd +
                ", region='" + region + '\'' +
                ", mfo='" + mfo + '\'' +
                ", assetTypeCode='" + assetTypeCode + '\'' +
                ", assetGroupCode='" + assetGroupCode + '\'' +
                ", clientType='" + clientType + '\'' +
                ", product='" + product + '\'' +
                ", zast='" + zast + '\'' +
                ", inn='" + inn + '\'' +
                ", fio='" + fio + '\'' +
                ", contractNum='" + contractNum + '\'' +
                ", contractStart=" + contractStart +
                ", contractEnd=" + contractEnd +
                ", curr='" + curr + '\'' +
                ", interestRate=" + interestRate +
                ", contractSumVal=" + contractSumVal +
                ", contractSumUAH=" + contractSumUAH +
                ", zbRateDay=" + zbRateDay +
                ", bodyUAH=" + bodyUAH +
                ", prcUAH=" + prcUAH +
                ", comission=" + comission +
                ", zb=" + zb +
                ", dpd=" + dpd +
                ", lastPayDate=" + lastPayDate +
                ", ratingPriceNoPDV=" + ratingPriceNoPDV +
                ", rv=" + rv +
                ", nbuRate='" + nbuRate + '\'' +
                ", ownerClass='" + ownerClass + '\'' +
                ", gageType='" + gageType + '\'' +
                ", gageVid='" + gageVid + '\'' +
                ", gageCode='" + gageCode + '\'' +
                ", discountPrice=" + discountPrice +
                ", startPrice=" + startPrice +
                ", firstStartPrice=" + firstStartPrice +
                ", factPrice=" + factPrice +
                ", nbuPladge=" + nbuPladge +
                ", isSold=" + isSold +
                ", acceptPrice=" + acceptPrice +
                ", paysBid=" + paysBid +
                ", paysCustomer=" + paysCustomer +
                ", bidPayDate=" + bidPayDate +
                ", customerPayDate=" + customerPayDate +
                ", planSaleDate=" + planSaleDate +
                ", lot=" + lot +
                '}';
    }

    public String toShotString() {
        String startDate="";
        String endDate="";
        if(contractStart!=null){startDate=sdfshort.format(contractStart);}
        if(contractEnd!=null){endDate=sdfshort.format(contractEnd);}
        return
                "|"+inn + '|' +
                        contractNum + '|' +
                        fio+ '|' +
                        region + '|' +
                        assetTypeCode + '|' +
                        assetGroupCode+ '|' +
                        clientType+ '|' +
                        startDate+ '|' +
                        endDate+ '|' +
                        curr + '|' +
                        product+ '|' +
                        zb+ '|' +
                        dpd+ '|' +
                        rv;
    }

}