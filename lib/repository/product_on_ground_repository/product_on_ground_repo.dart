
import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class ProductOnGroundRepository {
  final _apiService=NetworkApiServices();
  Future<String> zoneGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.zoneGet,sessionManagement,data);
  }


  Future<String> categoryCodeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.itemCategoryMstGet,sessionManagement,data);
  }

  Future<String> itemGroupCode(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.itemGroupMstGet,sessionManagement);
  }
  Future<String> itemNoApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.itemMstGet,sessionManagement);
  }

  Future<String> productionOnGroundLineApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.productOnGroundCreate,sessionManagement);
  }

  Future<String> productOnGroundGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.productOnGroundGet,sessionManagement);
  }

  Future<String> productOnGroundcompleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.productOnGroundComplete,sessionManagement);
  }

  Future<String> productOnGroundUpdateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.productOnGroundUpdate,sessionManagement);
  }

  Future<String> productOnGroundApprovalApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.productOnGroundApprovalGet,sessionManagement);
  }

  Future<String> getEmployeeTeamEmail(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }

  Future<String> getPogApprovalRejectApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.productOnGroundApprove, sessionManagement);
  }

  Future<String> pogDiscardApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.productOnGroundDiscard, sessionManagement);

  }

  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomers, sessionManagement);
  }
}