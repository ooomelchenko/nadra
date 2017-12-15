package nadrabank.dao;

import nadrabank.domain.AssetHistory;
import java.util.List;

public interface AssetHistoryDao {
    Long create( AssetHistory  assetHistory);
    AssetHistory read(Long id);
    boolean update( AssetHistory assetHistory);
    boolean delete( AssetHistory assetHistory);

    Integer getFirstAccPrice(Long lotId);

    Integer getLastAccPrice(Long assId);

    List getLotIdHistoryByAsset(Long assId);

    Integer getAccPriceByLotIdHistory(Long assetId, Long lotId);

    List getDateAndAccPriceHistoryByAsset(Long assId);
}