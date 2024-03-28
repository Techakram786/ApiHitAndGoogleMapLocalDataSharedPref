import 'package:http/http.dart' as http;
import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import '../../view_model/session_management/session_management_controller.dart';

class CheckOutRepository{
  final _apiService=NetworkApiServices();
  Future<String> SubmitCheckOutpostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiService.postFormApiHttpClient(clint_request,sessionManagement);
  }
}