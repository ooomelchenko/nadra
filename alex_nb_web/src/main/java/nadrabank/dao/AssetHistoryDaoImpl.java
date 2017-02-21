package nadrabank.dao;

import nadrabank.domain.AssetHistory;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public class AssetHistoryDaoImpl implements AssetHistoryDao {
    @Autowired
    private SessionFactory factory;

    public AssetHistoryDaoImpl(){
    }
    public AssetHistoryDaoImpl(SessionFactory factory){
        this.factory = factory;
    }

    public SessionFactory getFactory() {
        return factory;
    }
    public void setFactory(SessionFactory factory) {
        this.factory = factory;
    }

    @Override
    public Long create( AssetHistory assetHistory) {
        return (Long)factory.getCurrentSession().save(assetHistory);
    }
    @Override
    public  AssetHistory read(Long id) {
        return (AssetHistory)factory.getCurrentSession().get(AssetHistory.class, id);
    }
    @Override
    public boolean update(AssetHistory assetHistory) {
        factory.getCurrentSession().update(assetHistory);
        return true;
    }
    @Override
    public boolean delete(AssetHistory assetHistory) {
        factory.getCurrentSession().delete(assetHistory);
        return true;
    }
    @Override
    public BigDecimal getFirstAccPrice(Long assId) {
        Query query = factory.getCurrentSession().createQuery("select ah.acceptPrice from AssetHistory ah where ah.id=:assId and ah.acceptPrice is not null ORDER BY ah.changeDate ASC ");
        query.setParameter("assId", assId);
        try {
            return (BigDecimal) query.list().get(0);
        }
        catch(IndexOutOfBoundsException e){
            return null;
        }
    }
}