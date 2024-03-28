import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class plantingCreationRepository{
  final _apiService=NetworkApiServices();
  Future<String> plantingHeaderGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.plantingHeaderGet, sessionManagement);
  }
  Future<String> productionLocationGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.productionLocationGet, sessionManagement);
  }
  Future<String> seasonMstGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.seasonMstGet, sessionManagement);
  }
  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomers, sessionManagement);
  }
  Future<String> plantingHeaderCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.plantingHeaderCreate, sessionManagement);
  }

  //todo for add line section..................
  Future<String> plantingFsioBsioDocumentGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.plantingFsioBsioDocumentGet, sessionManagement);
  }
  Future<String> plantingFsioBsioDocumentDetailsGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.plantingFsioBsioDocumentDetailsGet, sessionManagement);
  }

  Future<String> plantingLineCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.plantingLineCreate, sessionManagement);
  }

  Future<String> plantingHeaderLineDiscard(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.PlantingHeaderLineDiscard, sessionManagement);
  }

  Future<String> PlantingHeaderComplete(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.PlantingHeaderComplete, sessionManagement);
  }

  Future<String> plantingLineGPSTag(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.plantingLineGPSTag, sessionManagement);
  }
  Future<String> getSupervisor(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getSupervisior, sessionManagement,data);
  }
}