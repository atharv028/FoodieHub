import 'package:delivery_app/data/models/sign_in_request.dart';
import 'package:delivery_app/data/models/sign_up_request.dart';
import 'package:delivery_app/data/models/signup_response.dart';
import 'package:delivery_app/data/repository/auth_repo.dart';
import 'package:delivery_app/widgets/custom_toast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  RxBool isLoading = false.obs;

  RxBool isLoggedIn = false.obs;

  loginState() {
    if (authRepo.getUserToken() != null) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<Response> register(SignUpRequest request) async {
    isLoading.value = true;
    var response = await authRepo.register(request);
    print(response.body);
    print(response.bodyString);
    print(response.statusText);
    if (response.statusCode == 200) {
      isLoading.value = false;
      authRepo.saveToken(SignupResponse.fromMap(response.body).token!);
      return response;
    } else {
      isLoading.value = false;
      showSnackbar("Cannot register");
      return response;
    }
  }

  Future<Response> login(SignInRequest request) async {
    isLoading.value = true;
    var response = await authRepo.login(request);
    print(response.body);
    print(response.bodyString);
    print(response.statusText);
    if (response.statusCode == 200) {
      isLoading.value = false;
      authRepo.saveToken(SignupResponse.fromMap(response.body).token!);
      return response;
    } else {
      isLoading.value = false;
      showSnackbar(response.bodyString!);
      return response;
    }
  }
}
