package nadrabank.dao;

import nadrabank.domain.Lot;
import nadrabank.domain.Pay;
import java.util.Date;
import java.util.List;

public interface PayDao {
    Long create(Pay pay);
    Pay read(Long id);
    boolean update(Pay pay);
    boolean delete(Pay pay);
    List findAll();

    List getPaysByDates(Date startDate, Date endDate);

    int sumByLot(Lot lot);

    int sumByLotFromBid(Long lotId);

    int sumByLotFromCustomer(Long lotId);

    List getPaymentsByLot(Lot lot);

    Date getLastDateByBid(Long lotId);

    Date getLastDateByCustomer(Long lotId);
}