import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(Endpoints.POPULAR_PRODUCT);
  }
}
