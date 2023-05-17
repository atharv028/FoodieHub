import 'package:delivery_app/data/models/history/history.dart';
import 'package:floor/floor.dart';

@dao
abstract class HistoryDao {
  @Query('SELECT * FROM history')
  Future<List<History>> getAllOrders();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(History historyItem);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllOrders(List<History> historyItemList);

  @delete
  Future<void> deleteOrder(History cart);

  @Query('DELETE FROM history')
  Future<void> deleteAllOrders();
}
