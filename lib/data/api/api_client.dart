import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiClient extends GetConnect implements GetxService {
  late String? token;
  final String baseURL;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.baseURL}) {
    baseUrl = baseURL;
    timeout = const Duration(seconds: 10);
    _mainHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
    };
  }

  updateHeaders(String token) {
    this.token = token;
    _mainHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
  }

  Future<Response> getData(
    String endpoint,
  ) async {
    try {
      print("Api URL :" + baseUrl! + endpoint);
      Response response = await get(endpoint);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String endpoint, dynamic body) async {
    try {
      Response res = await post(endpoint, body, headers: _mainHeaders);
      return res;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
