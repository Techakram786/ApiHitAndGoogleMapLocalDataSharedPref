import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class OrdersRepository{
  final _apiService = NetworkApiServices();
  Future<String> getOrderHeaderGetApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.orderHeaderGet, sessionManagement);
  }

  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomers, sessionManagement);
  }

  Future<String> getPaymentTerms(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getPaymentTermsCreate, sessionManagement);
  }

  Future<String> getConsignee(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getConsigneeMstGet, sessionManagement);
  }

  Future<String> getStates(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getStateList, sessionManagement,data);
  }

  Future<String> consigneeMstInsertUpdate(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.consigneeMstInsertUpdate, sessionManagement);
  }
  Future<String> orderHeaderCreate(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderCreate, sessionManagement);
  }
  Future<String> getItemCategoryMstGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.consigneeMstInsertUpdate, sessionManagement);
  }
  Future<String> getOrderItemCategoryGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderItemCategoryGet, sessionManagement);
  }

  Future<String> getOrderItemGroupGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderItemGroupGet, sessionManagement);
  }

  Future<String> getOrderItemGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderItemGet, sessionManagement);
  }

  Future<String> orderLineInsert(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderLineInsert, sessionManagement);
  }

  Future<String> orderHeaderComplete(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderComplete, sessionManagement);
  }
}