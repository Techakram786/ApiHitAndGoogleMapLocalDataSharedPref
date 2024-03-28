import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class CustomerRepository{
  final _apiService = NetworkApiServices();
  Future<String> getCustomerApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomerList, sessionManagement);
  }

  Future<String> getCustomerGeoTagApi(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomerGeoTag, sessionManagement);
  }

}