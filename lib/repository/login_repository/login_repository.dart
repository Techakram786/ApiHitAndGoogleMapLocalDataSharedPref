import 'package:pristine_seeds/models/loginModel/login_model.dart';
import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/resourse/appUrl/app_url.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';
class LoginRepository{
  final _apiService=NetworkApiServices();
  Future<String> loginApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.login_url,sessionManagement);
  }
}
