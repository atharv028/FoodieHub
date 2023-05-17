import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/data/models/CartModel/cart_model.dart';
import 'package:delivery_app/data/models/popular_item/popular_item.dart';
import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:delivery_app/data/repository/recommended_product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../util/constants/Colors.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<Product> _list = [];
  List<Product> get recommendedProductList => _list;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getRecommendedProductList();
  }

  CartController? _cartController;
  Product? _product;

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

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
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
        _quantity.value += 1;
        _adjustedPrice.value =
            (_quantity.value.toInt() * _product!.price!.toInt());
      } else {
        Get.snackbar("Item Count", "You can't Add more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    } else {
      if (_quantity > 0) {
        _quantity.value -= 1;
        _adjustedPrice.value =
            (_quantity.value.toInt() * _product!.price!.toInt());
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
          productType: ProductType.recommended);
      updateTotalItems();
    } else {
      Get.snackbar("Cart Items", "Please add atleast one item",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }

  updateTotalItems() {
    if (_cartController != null) {
      totalItems = _cartController!.totalItems.value;
      print(totalItems);
      update();
    }
  }
}
