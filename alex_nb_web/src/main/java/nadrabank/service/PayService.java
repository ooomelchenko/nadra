package nadrabank.service;

import nadrabank.domain.Pay;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

public interface PayService {
    Pay getPay(Long id);
    Long createPay(Pay pay);
    boolean delete(Long id);
    boolean delete(Pay pay);
    boolean updatePay(Pay pay);
    List getAllPays();

    @Transactional(readOnly = true)
    Date getLastDateByBid(Long lotId);

    @Transactional(readOnly = true)
    Date getLastDateByCustomer(Long lotId);

    @Transactional(readOnly = true)
    int sumByLotFromBid(Long lotId);

    @Transactional(readOnly = true)
    int sumByLotFromCustomer(Long lotId);

    @Transactional(readOnly = true)
    List getPaysByDates(Date s, Date e);
}