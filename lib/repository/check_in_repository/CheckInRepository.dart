import 'package:http/http.dart' as http;
import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/resourse/appUrl/app_url.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

class CheckInRepository{
  final _apiService=NetworkApiServices();

  Future<String> currentRunningCheckInDataApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.currentRunningCheckInData, sessionManagement);
  }


  Future<String> vehileTypeGetInsert(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.vehileTypeGetInsert, sessionManagement);
  }

  Future<String> getEmployeeMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.get_employee_master,sessionManagement);
  }
  Future<String> SubmitCheckinpostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiService.postFormApiHttpClient(clint_request,sessionManagement);
  }

  Future<String> getVehicleDetails(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getVehicleDetails, sessionManagement);
  }

  Future<String> SubmitCheckOutpostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiService.postFormApiHttpClient(clint_request,sessionManagement);
  }

  Future<String> submitExpLinepostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiService.postFormApiHttpClient(clint_request,sessionManagement);
  }

  Future<String> checkOutComplete(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.checkOutComplete, sessionManagement);
  }
}