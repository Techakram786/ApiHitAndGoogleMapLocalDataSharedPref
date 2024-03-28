import 'package:http/http.dart' as http;
import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';


class DashBoardRepository{
  final _apiService=NetworkApiServices();
  Future<String> getEmployeeMasterDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.get_employee_master_details,sessionManagement);
  }

  Future<String> userLocationInsertApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.userLocationInsert,sessionManagement);
  }

  Future<String> uploadImage(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiService.postFormApiHttpClient(clint_request,sessionManagement);
  }

  Future<String> sendPushNotificationToServer(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.userFireBaseTokenUpdate,sessionManagement);
  }
}