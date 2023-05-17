import 'package:floor/floor.dart';

import '../models/CartModel/cart_model.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM Cart')
  Future<List<Cart>> getAllItems();

  @Query('SELECT * FROM Cart WHERE id = :id')
  Stream<Cart?> findCartItemById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertItem(Cart cart);

  @delete
  Future<void> deleteItem(Cart cart);

  @Query('DELETE FROM Cart')
  Future<void> deleteAllCartItems();
}
