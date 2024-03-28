import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/resourse/appUrl/app_url.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

class CustomerRequestRepository {
  final _apiServices=NetworkApiServices();

  Future<String> getCustomerRequestListHitApi(var data, SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.customerRequestList, sessionManagement);
  }


  Future<String> createCustomerRequestHitApi(var data, SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.customerRequestCreate, sessionManagement);
  }

  Future<String> getCustomerType(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiServices.getApi(AppUrl.getCustomerType, sessionManagement,data);
  }

  Future<String> getVenderType(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiServices.getApi(AppUrl.getVenderType, sessionManagement,data);
  }

  Future<String> StateListApiHit(Map<String, String> data,SessionManagement sessionManagement)async{
    return _apiServices.getApi( AppUrl.getStateList, sessionManagement,data);
  }


  Future<String> getSalePerson(var data, SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.getSalePerson, sessionManagement);
  }

  Future<String> CustomerRequestUpdateHitApi(var data, SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.customerRequestUpdate, sessionManagement);
  }


  Future<String> CustomerRequestCompleteHitApi(var data, SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.customerRequestComplete, sessionManagement);
  }


  Future<String> CustomerRequestApperverHitApi(var data, SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.customerRequestApprovarList, sessionManagement);
  }

  Future<String> getEmployeeTeamEmail(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }


  Future<String> customerRejectedApproveApiHit(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.customerRequestApprovarRejected, sessionManagement);
  }


}