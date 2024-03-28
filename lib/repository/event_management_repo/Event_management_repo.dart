import 'package:http/http.dart' as http;

import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class EventManagementRepository{
  final _apiService=NetworkApiServices();

  Future<String> eventTypeCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.eventTypeCreate, sessionManagement);
  }
  Future<String> eventManagementGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.eventManagementGet, sessionManagement);
  }
  Future<String> eventManagementCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.eventManagementCreate, sessionManagement);
  }
  //todo special
  Future<String> eventManagementExpenseInsert(http.MultipartRequest clint_request,SessionManagement sessionManagement)async{
    return _apiService.postFormApiHttpClient(clint_request, sessionManagement);
  }
  Future<String> upLoadEventHeaderImageApi(http.MultipartRequest clint_request,SessionManagement sessionManagement)async{
    return _apiService.postFormApiHttpClient(clint_request, sessionManagement);
  }


  Future<String> eventManagementComplete(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.eventManagementComplete, sessionManagement);
  }
  Future<String> imageDiscardApi(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.imageDiscardApi, sessionManagement);
  }
  Future<String> eventApprovalRejected(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.eventApprovalRejected, sessionManagement);
  }


  Future<String> getEventType(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getEvetntTypeApi, sessionManagement,data);
  }
  Future<String> getEvetntTExpense(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getEvetntTExpenseApi, sessionManagement,data);
  }
  Future<String> getEvetntTDelete(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getEvetntTDeleteApi, sessionManagement,data);
  }


  Future<String> getEventManagementApprover(var data,SessionManagement sessionManagement) async {
    return _apiService.postApi(data,AppUrl.getEventManagementApproverApi, sessionManagement);
  }




}