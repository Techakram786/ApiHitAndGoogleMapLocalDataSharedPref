import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class ShippedOrderRepository{
  final _apiService = NetworkApiServices();
  Future<String> getOrderHeaderGetApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.orderHeaderGet, sessionManagement);
  }


  Future<String> shippedOrderGetApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.shipmentOrderGet, sessionManagement);
  }
}