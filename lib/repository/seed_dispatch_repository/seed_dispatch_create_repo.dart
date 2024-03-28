import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class seedDispatchCreationRepository{
  final _apiService=NetworkApiServices();
  Future<String> seedDispatchHeaderCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.seedDispatchHeaderCreate, sessionManagement);
  }
  Future<String> seedDispatchHeaderGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.seedDispatchHeaderGet, sessionManagement);
  }
  Future<String> seedDispatchLineCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.seedDispatchLineCreate, sessionManagement);
  }
  Future<String> seedDispatchLineGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.seedDispatchLineGet, sessionManagement,data);
  }
  Future<String> seedDispatchLineUpdate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.seedDispatchLineUpdate, sessionManagement);
  }
  Future<String> getSeedDispatchLocation(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.seedDispatchLocation, sessionManagement,data);
  }
  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomers, sessionManagement);
  }
  Future<String> getItemCategory(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.itemCategoryMstGet, sessionManagement,data);
  }
  Future<String> getItemGroupCategory(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.itemGroupCategoryMstGet, sessionManagement);
  }
  Future<String> getItemMaster(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.itemmastermst, sessionManagement);
  }
  Future<String> discardHeaderApi(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.discardHeaderApi, sessionManagement);
  }
  Future<String> discardLineApi(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.discardLineApi, sessionManagement);
  }
  Future<String> completeHeaderApi(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.completeHeaderApi, sessionManagement);
  }

  Future<String> getproductionApi(var data,SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.getLotNo, sessionManagement);
  }

}