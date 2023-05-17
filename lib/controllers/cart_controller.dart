import 'package:delivery_app/data/db/history_dao.dart';
import 'package:delivery_app/data/models/CartModel/cart_model.dart';
import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

import '../data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  final HistoryDao historyDao;
  CartController({required this.cartRepo, required this.historyDao});

  final Map<int, Cart> _savedProducts = {};
  Map<int, Cart> get cartItems => _savedProducts;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("ITEMS AT CHECKOUT");
    // (await cartRepo.historyDao.getAllOrders()).forEach((element) {
    //   print(element.toJson());
    // });
  }

  updateItemsFromStorage() async {
    List<Cart> items = await cartRepo.getAllItems();
    items.forEach((element) {
      _savedProducts.putIfAbsent(element.id!, () => element);
    });
  }

  RxInt itemQuantity(int? id) {
    return _itemQuantity(id);
  }

  RxInt _itemQuantity(int? id) {
    RxInt quantity = 0.obs;
    if (id != null && productInCart(id)) {
      quantity.value = _savedProducts[id]!.quantity!;
    }
    return quantity;
  }

  RxInt get _totalItems {
    RxInt total = 0.obs;
    _savedProducts.forEach((key, value) {
      total.value += value.quantity!;
    });
    return total;
  }

  RxInt get totalItems => _totalItems;

  RxInt totalAmount = 0.obs;

  clearData() async {
    var data = await cartRepo.getAllItems();
    await cartRepo.clearData(data);
  }

  addItemsToHistory() {
    cartRepo.addToHistoryList(_savedProducts.values.toList());
    cartRepo.clearData(_savedProducts.values.toList());
    _savedProducts.clear();
    update();
  }

  updateTotalAmount() {
    int currAmount = 0;
    var count = 0;
    _savedProducts.forEach((key, value) {
      print("called ${count++} times");
      currAmount += value.quantity! * value.price!;
    });
    totalAmount.value = currAmount;
    print("CALLED UPDATE");
  }

  void addItem(Product product, int quantity,
      // ignore: avoid_init_to_null
      {ProductType? productType = null}) {
    if (_savedProducts.containsKey(product.id) == false) {
      _savedProducts.putIfAbsent(
          product.id!,
          () => Cart(
                id: product.id,
                name: product.name,
                price: product.price,
                img: product.img,
                quantity: quantity,
                isExist: true,
                time: DateTime.now().toString(),
                product: product,
              ));
    } else {
      _savedProducts.update(product.id!, (value) {
        return Cart(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: value.isExist,
          time: value.time,
          product: value.product,
        );
      });
      update();
      updateTotalAmount();
    }

    _savedProducts.forEach((key, value) {
      print("This is the product ${value.id} with quantity ${value.quantity}");
    });
    cartRepo.addToCartList(_savedProducts.values.toList());
  }

  bool existInCart(Product product) {
    return _savedProducts.containsKey(product.id);
  }

  bool productInCart(int id) {
    return _savedProducts.containsKey(id);
  }

  int? getQuantity(Product product) {
    return _savedProducts.containsKey(product.id)
        ? _savedProducts[product.id]!.quantity
        : 0;
  }
}
