package nadrabank.dao;

import nadrabank.domain.Bid;
import nadrabank.domain.LotHistory;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class LotHistoryDaoImpl implements LotHistoryDao {
    @Autowired
    private SessionFactory factory;

    public LotHistoryDaoImpl(){
    }
    public LotHistoryDaoImpl(SessionFactory factory){
        this.factory = factory;
    }

    public SessionFactory getFactory() {
        return factory;
    }
    public void setFactory(SessionFactory factory) {
        this.factory = factory;
    }

    @Override
    public Long create(LotHistory lotHistory) {
        return (Long)factory.getCurrentSession().save(lotHistory);
    }
    @Override
    public LotHistory read(Long id) {
        return (LotHistory)factory.getCurrentSession().get(LotHistory.class, id);
    }
    @Override
    public boolean update(LotHistory lotHistory) {
        factory.getCurrentSession().update(lotHistory);
        return true;
    }
    @Override
    public boolean delete(LotHistory lotHistory) {
        factory.getCurrentSession().delete(lotHistory);
        return true;
    }
    @Override
    public List getAllBidsId(Long lotId){
        Query query = factory.getCurrentSession().createQuery("SELECT lotHistory.bidId FROM nadrabank.domain.LotHistory lotHistory Where lotHistory.id=:lotId and lotHistory.bidId is not null GROUP BY lotHistory.bidId ORDER BY max(lotHistory.idKey) DESC");
        query.setParameter("lotId", lotId);
        return query.list();
    }
    @Override
    public List getLotsFromHistoryByBid(Bid bid) {
        return getLotsFromHistoryByBid(bid.getId());
        }
    @Override
    public List getLotsHistoryByBidDates(Date startDate, Date endDate) {
        Query query = factory.getCurrentSession().createQuery("FROM nadrabank.domain.LotHistory lh " +
                "Where lh.idKey in (SELECT max(idKey) FROM LotHistory WHERE id=lh.id)" +
                "and lh.bidId in (select id from Bid bid where bidDate>=:startDate and bidDate<=:endDate)");
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.list();
    }
    @Override
    public List getLotsFromHistoryByBid(long bidId) {
        Query query = factory.getCurrentSession().createQuery("FROM nadrabank.domain.LotHistory lh " +
                "Where lh.bidId=:bidId and lh.idKey = (SELECT max(idKey) FROM LotHistory WHERE id=lh.id and lh.bidId=bidId)");
        query.setParameter("bidId", bidId);
        return query.list();
    }
/*    select id_key, bid_id, id from lots_history a where id_key in (select max(id_key) from lots_history where id=a.id
and bid_id in (select id from bids b where bid_date>='24.04.2017' and bid_date<='27.04.2017') and bid_id in (403,393));*/

}