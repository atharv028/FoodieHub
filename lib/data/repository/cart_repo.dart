import 'package:delivery_app/data/db/cart_dao.dart';
import 'package:delivery_app/data/db/history_dao.dart';
import 'package:delivery_app/data/models/history/history.dart';
import 'package:get/get.dart';

import '../models/CartModel/cart_model.dart';

class CartRepo extends GetxService {
  final CartDao cartDao;
  final HistoryDao historyDao;
  CartRepo({required this.historyDao, required this.cartDao});

  clearData(List<Cart> cartItems) {
    cartItems.forEach((cart) {
      cartDao.deleteItem(cart);
    });
  }

  void addToCartList(List<Cart> cartList) async {
    cartList.forEach((cart) {
      cartDao.insertItem(cart);
    });

    (await cartDao.getAllItems()).forEach((element) {
      print(element.toJson());
    });
  }

  void addToHistoryList(List<Cart> cart) async {
    History newItems = History(time: DateTime.now().toString(), cart: cart);
    await historyDao.insertOrder(newItems);
    printAllItems();
  }

  void printAllItems() async {
    print("CALLED FOR THING");
    var list = await historyDao.getAllOrders();
    list.forEach((element) {
      print("This is the aftermath : $element");
    });
  }

  Future<List<Cart>> getAllItems() async {
    return await cartDao.getAllItems();
  }

  getHistoryList() async {
    Map<String, List<Cart>> historyItems = Map();

    var items = await historyDao.getAllOrders();
    var map = {for (var v in items) v.time: v};
  }
}
