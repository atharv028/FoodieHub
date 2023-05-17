import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/data/models/CartModel/cart_model.dart';
import 'package:delivery_app/data/models/popular_item/popular_item.dart';
import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:delivery_app/data/repository/popular_product_repo.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  @override
  void onInit() async {
    super.onInit();
    await getPopularProductList();
  }

  CartController? _cartController;
  Product? _product;

  List<Product> _list = [];
  List<Product> get popularProductList => _list;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  RxInt _quantity = 0.obs;
  RxInt get getQuantity => _quantity;

  RxInt _inCartItems = 0.obs;
  RxInt get getCartItems => (_inCartItems.value + _quantity.value).obs;

  RxInt _adjustedPrice = 0.obs;
  RxInt get getPrice => _adjustedPrice;

  int totalItems = 0;

  void initProduct(CartController cartController, Product product) {
    _product = product;
    _quantity.value = 0;
    _inCartItems.value = 0;
    _cartController = cartController;
    _adjustedPrice.value = 0;
    var exist = false;
    exist = cartController.existInCart(product);
    if (exist) {
      _quantity.value = cartController.getQuantity(product) ?? 0;
      // _inCartItems.value = cartController.getQuantity(product) ?? 0;
    }
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      PopularItem popularItem = PopularItem.fromMap(response.body);
      _list.addAll(popularItem.products!);
      print(_list);
      _isLoaded = true;
      update();
    } else {
      print("Failed to fetch Data with ${response.statusText}");
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      if (_quantity < 20) {
        ++_quantity;
        _adjustedPrice.value = (_quantity.toInt() * _product!.price!.toInt());
      } else {
        Get.snackbar("Item Count", "You can't Add more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    } else {
      if (_quantity > 0) {
        --_quantity;
        _adjustedPrice.value = (_quantity.toInt() * _product!.price!.toInt());
      } else {
        Get.snackbar("Item Count", "You can't reduce more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    print("PRICE: $_adjustedPrice");
  }

  void addItemToCart(Product product) {
    if (_quantity > 0) {
      _cartController?.addItem(product, _quantity.value,
          productType: ProductType.popular);
      updateTotalItems();
    } else {
      Get.snackbar("Cart Items", "Please add atleast one item",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }

  updateTotalItems() async {
    if (_cartController != null) {
      await _cartController!.updateItemsFromStorage();
      totalItems = _cartController!.totalItems.value;
      print(totalItems);
      update();
    }
  }
}
