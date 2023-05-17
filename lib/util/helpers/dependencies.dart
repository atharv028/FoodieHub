import 'package:delivery_app/controllers/auth_controller.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/data/db/app_db.dart';
import 'package:delivery_app/data/repository/auth_repo.dart';
import 'package:delivery_app/data/repository/cart_repo.dart';
import 'package:delivery_app/data/repository/popular_product_repo.dart';
import 'package:delivery_app/data/repository/recommended_product_repo.dart';
import 'package:delivery_app/util/constants/strings.dart';
import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  //db
  final db = await $FloorAppDatabase.databaseBuilder('app_db.db').build();
  final cartDao = db.cartDao;
  final historyDao = db.historyDao;
  final sharedPref = await SharedPreferences.getInstance();
  Get.lazyPut(() => cartDao);
  Get.lazyPut(() => historyDao);
  Get.lazyPut(() => sharedPref);

  // Api Client
  Get.lazyPut(() => ApiClient(baseURL: AppConstants.BASE_URL));

  // Repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(cartDao: Get.find(), historyDao: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  // Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(
      () => CartController(cartRepo: Get.find(), historyDao: Get.find()));
  Get.lazyPut(() => AuthRepo(
      apiClient: Get.find(),
      sharedPreferences: Get.find(),
      cartDao: Get.find(),
      historyDao: Get.find()));
}
