import 'package:get/get.dart';
import 'package:shopping_app/data/repository/user_repo.dart';
import 'package:shopping_app/models/response_model.dart';
import 'package:shopping_app/models/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel _userModel =
      UserModel(email: "", name: "", id: 0, phone: "", orderCount: 0);
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.formJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "SuccessFully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
