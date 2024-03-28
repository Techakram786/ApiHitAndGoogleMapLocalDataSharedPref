import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../resourse/appUrl/app_url.dart';

class CreatePassRepository{
  final _apiService=NetworkApiServices();
  Future<String> createPassApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.create_pass_url,sessionManagement);
  }
}