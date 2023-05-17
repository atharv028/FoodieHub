import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:delivery_app/pages/auth/signin_page.dart';
import 'package:delivery_app/pages/auth/signup_page.dart';
import 'package:delivery_app/pages/cart/cart_page.dart';
import 'package:delivery_app/pages/food/food_details_page.dart';
import 'package:delivery_app/pages/food/food_details_recommended.dart';
import 'package:delivery_app/pages/home/home_page.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String _splashScreen = "/splash-screen";
  static const String _initial = "/";
  static const String _popularFood = "/popular-food";
  static const String _foodDetailsRecommended = "/recommended-food";
  static const String _cartPage = "/cart-page";
  static const String _signInPage = "/sign-in";
  static const String _signUpPage = "/sign-up";

  static String getSplashPage() => _splashScreen;
  static String getInitial() => _initial;
  static String getPopularFood(int pageId, String page) =>
      '$_popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$_foodDetailsRecommended?pageId=$pageId&page=$page';

  static String getCartPage() => '$_cartPage';

  static String getSignInPage() => '$_signInPage';

  static String getSignUpPage() => '$_signUpPage';

  static List<GetPage> routes = [
    GetPage(name: _splashScreen, page: () => const SplashScreen()),
    GetPage(name: _initial, page: () => const HomePage()),
    GetPage(name: _signInPage, page: () => const SignInPage()),
    GetPage(name: _signUpPage, page: () => const SignUpPage()),
    GetPage(
        name: _popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return FoodDetails(pageId: pageId, page: page);
        },
        transition: Transition.fade),
    GetPage(
        name: _foodDetailsRecommended,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(pageId: pageId, page: page);
        }),
    GetPage(
        name: _cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fade)
  ];
}
