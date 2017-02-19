package nadrabank.dao;

import nadrabank.domain.AssetHistory;

import java.math.BigDecimal;

public interface AssetHistoryDao {
    Long create( AssetHistory  assetHistory);
    AssetHistory read(Long id);
    boolean update( AssetHistory assetHistory);
    boolean delete( AssetHistory assetHistory);

    BigDecimal getFirstAccPrice(Long lotId);
}