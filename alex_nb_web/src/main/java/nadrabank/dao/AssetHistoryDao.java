package nadrabank.dao;

import nadrabank.domain.AssetHistory;

import java.math.BigDecimal;
import java.util.List;

public interface AssetHistoryDao {
    Long create( AssetHistory  assetHistory);
    AssetHistory read(Long id);
    boolean update( AssetHistory assetHistory);
    boolean delete( AssetHistory assetHistory);

    BigDecimal getFirstAccPrice(Long lotId);

    List getLotIdHistoryByAsset(Long assId);

    BigDecimal getAccPriceByLotIdHistory(Long assetId, Long lotId);
}