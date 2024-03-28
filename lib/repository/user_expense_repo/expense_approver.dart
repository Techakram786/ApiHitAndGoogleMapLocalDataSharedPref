import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/resourse/appUrl/app_url.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

class ExpenseApproverRepository{
  final _apiService=NetworkApiServices();
  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }
  Future<String> GetApproverData(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expense_approverData, sessionManagement);
  }
  Future<String> markApproveReject(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expenseMarkApprove, sessionManagement);
  }

  Future<String> expenseCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expenseCreate, sessionManagement);
  }
}