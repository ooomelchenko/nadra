package nadrabank.dao;

import nadrabank.domain.Bid;
import nadrabank.domain.LotHistory;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface LotHistoryDao {
    Long create(LotHistory lotHistory);
    LotHistory read(Long id);
    boolean update(LotHistory lotHistory);
    boolean delete(LotHistory lotHistory);

    List getAllBidsId(Long lotId);

    List getLotsFromHistoryByBid(Bid bid);

    BigDecimal getStartSumFromHistoryByBid(long bidId);

    List getLotsHistoryByBidDates(Date startDate, Date endDate);

    List getLotsFromHistoryByBid(long bidId);
}