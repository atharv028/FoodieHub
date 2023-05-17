import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:delivery_app/data/db/cart_dao.dart';
import 'package:delivery_app/data/db/history_dao.dart';
import 'package:delivery_app/data/models/sign_up_request.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sign_in_request.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  final HistoryDao historyDao;
  final CartDao cartDao;
  AuthRepo(
      {required this.historyDao,
      required this.cartDao,
      required this.apiClient,
      required this.sharedPreferences});

  Future<Response> register(SignUpRequest body) async {
    var response =
        await apiClient.postData(Endpoints.REGISTER_URL, body.toJson());
    return response;
  }

  Future<Response> login(SignInRequest body) {
    var response = apiClient.post(Endpoints.LOGIN_URL, body.toJson());
    return response;
  }

  String? getUserToken() {
    return sharedPreferences.getString("token");
  }

  saveToken(String token) async {
    apiClient.updateHeaders(token);
    await sharedPreferences.setString("token", token);
  }

  logout() async {
    await sharedPreferences.clear();
    await historyDao.deleteAllOrders();
    await cartDao.deleteAllCartItems();
  }
}
