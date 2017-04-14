package nadrabank.service;

import nadrabank.dao.*;
import nadrabank.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Service //(name ="LotServiceImpl")
@Transactional
public class LotServiceImpl implements LotService {
    @Autowired
    private LotHistoryDao lotHistoryDao;
    @Autowired
    private LotDao lotDao;
    @Autowired
    private AssetDao assetDao;
    @Autowired
    private PayDao payDao;
    @Autowired
    private CreditDao creditDao;

    public LotServiceImpl() {
    }
    public LotServiceImpl(LotDaoImpl lotDao) {
        this.lotDao = lotDao;
    }

    public LotDao getLotDao() {
        return lotDao;
    }
    public void setLotDao(LotDaoImpl lotDao) {
        this.lotDao = lotDao;
    }

    @Override
    @Transactional(readOnly = true)
    public Lot getLot(Long id) {
        return lotDao.read(id);
    }
    @Override
    public Long createLot(Lot lot) {
        return lotDao.create(lot);
    }
    @Override
    public Long createLot(String userName, Lot lot) {
        Long lotId =lotDao.create(lot);
        lotHistoryDao.create(new LotHistory(userName,lot));
        return lotId;
    }
    @Override
    public boolean delete(Long id) {
        Lot lot = lotDao.read(id);
        lotDao.delete(lot);
        return true;
    }
    @Override
    public boolean delete(Lot lot) {
        lotDao.delete(lot);
        return true;
    }
    @Override
    public boolean updateLot( Lot lot) {
        return lotDao.update(lot);
    }
    @Override
    public boolean updateLot(String userName, Lot lot) {
        boolean r =lotDao.update(lot);
        lotHistoryDao.create(new LotHistory(userName,lot));
       return r;
    }
    @Override
    @Transactional(readOnly = true)
    public List getLots() {
        return lotDao.findAll();
    }
    @Override
    @Transactional(readOnly = true)
    public List getLotsByType(int lotType){
        return lotDao.findByLotType(lotType);
    }
    @Override
    @Transactional(readOnly = true)
    public List getLotsId() {
        return lotDao.findAllId();
    }
    @Override
    @Transactional(readOnly = true)
    public BigDecimal lotSum(Lot lot){
        return lotDao.lotSum(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public BigDecimal lotAcceptedSum(Lot lot){
        return lotDao.lotAcceptedSum(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public Long lotCount(Lot lot){
        return lotDao.lotCount(lot);
    }
    @Override
    public boolean delLot(Lot lot) {
        try {
            List<Pay> paysByLot = payDao.getPaymentsByLot(lot);

            for (Pay pay : paysByLot) {
                pay.setHistoryLotId(pay.getLotId());
                pay.setLotId(null);
                payDao.update(pay);
            }
        } catch (NullPointerException e) {
        }
        assetDao.delAssetsFromLot(lot);
        creditDao.delCreditsFromLot(lot.getId());
        return lotDao.delete(lot);
    }
    @Override
    public boolean delLot(Long lotId) {
        Lot lot = getLot(lotId);
        try {
            List<Pay> paysByLot = payDao.getPaymentsByLot(lot);
            for (Pay pay : paysByLot) {
                pay.setHistoryLotId(pay.getLotId());
                pay.setLotId(null);
                payDao.update(pay);
            }
        } catch (NullPointerException e) {
        }
        assetDao.delAssetsFromLot(lot);
        creditDao.delCreditsFromLot(lotId);
        return lotDao.delete(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List getAssetsByLot(Lot lot){
        return lotDao.getAssetsByLot(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List getTMCAssetsByLot(Lot lot){
        return lotDao.getTMCAssetsByLot(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List getNotTMCAssetsByLot(Lot lot){
        return lotDao.getNotTMCAssetsByLot(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List getCRDTSByLot(Lot lot){
        return lotDao.getCRDTSByLot(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List getAssetsByLot(Long lotId){
        return lotDao.getAssetsByLot(lotDao.read(lotId));
    }
    @Override
    @Transactional(readOnly = true)
    public List getLotsByBidDate(Date first, Date last){
        return lotDao.getLotsByBidDate(first, last);
    }
    @Override
    @Transactional(readOnly = true)
    public BigDecimal paymentsSumByLot(Lot lot){
        return payDao.sumByLot(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List paymentsByLot(Lot lot){
        return payDao.getPaymentsByLot(lot);
    }
    @Override
    @Transactional(readOnly = true)
    public List getLotsByBid(Bid bid){
        return lotDao.getLotsByBid(bid);
    }
    @Override
    @Transactional(readOnly = true)
    public List getLotsByExchange(Exchange exchange){
        return lotDao.getLotsByExchange(exchange);
    }
    @Override
    @Transactional(readOnly = true)
    public List getBidsIdByLot(Long lotId){
        return lotHistoryDao.getAllBidsId(lotId);
    }
    @Override
    public List getLotsFromHistoryByBid(Bid bid) {
        return lotHistoryDao.getLotsFromHistoryByBid(bid);
    }
    @Override
    public List getLotsFromHistoryByBid(long bidId) {
        return lotHistoryDao.getLotsFromHistoryByBid(bidId);
    }
}