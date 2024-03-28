import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/resourse/appUrl/app_url.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

class OrderApproverRepository{
  final _apiService=NetworkApiServices();
  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }
  Future<String> GetApproverData(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.orderINApproverGet, sessionManagement);
  }
  Future<String> markApproveReject(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.OrderMarkApprove, sessionManagement);
  }

  Future<String> orderDetailGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderCreate, sessionManagement);
  }

  Future<String> orderApproverLineInsert(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderApprovalLineUpdate, sessionManagement);
  }
}