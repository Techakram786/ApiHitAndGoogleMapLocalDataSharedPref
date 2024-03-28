
import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class CollectionRepository{
  final _apiService=NetworkApiServices();
  Future<String> collectionMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.collectionMasterGet,sessionManagement);
  }

  Future<String> collectionMasterCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.collectionMasterCreate,sessionManagement);
  }

  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomers, sessionManagement);
  }
}