import 'package:http/http.dart' as http;
import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class UserExpenseRepository{
  final _apiService = NetworkApiServices();

  Future<String> getExpenseHeader(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getExpenseHeader, sessionManagement,data);
  }

  Future<String> getExpenseLines(Map<String,String> data,SessionManagement sessionManagement)async{
    return _apiService.getApi(AppUrl.getExpenseLines, sessionManagement,data);
  }
  Future<String> getExpenseCatagory(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getExpenseCatagory, sessionManagement);
  }

  Future<String> expenseCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expenseCreate, sessionManagement);
  }
  Future<String> expenseLinesSubmit(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiService.postFormApiHttpClient(clint_request,sessionManagement);
  }

  Future<String> getRegion(Map<String,String> data,SessionManagement sessionManagement)async{
    return _apiService.getApi(AppUrl.expenseRegionGet, sessionManagement,data);
  }

  Future<String> expenseComplete(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expenseComplete, sessionManagement);
  }
}