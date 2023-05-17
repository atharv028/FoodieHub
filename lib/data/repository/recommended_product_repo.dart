import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(Endpoints.RECOMMENDED_PRODUCT);
  }
}
