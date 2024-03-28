import 'package:pristine_seeds/network_data/network/network_api_service.dart';

import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class IptRepository{
  final _apiService=NetworkApiServices();


  Future<String> getIptListHitApi(var data, SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.iptgetList, sessionManagement);
  }

  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getCustomers, sessionManagement);
  }
  Future<String> createIptApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.createipt, sessionManagement);
  }


  Future<String> getIPtItemCategoryApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getItemCategory, sessionManagement);
  }



  Future<String> getIPtItemGroupApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getItemGroup, sessionManagement);
  }


  Future<String> getIPtItemGetApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getIptItemGet, sessionManagement);
  }

  Future<String> IptLineInsertApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.iptLineInsert, sessionManagement);
  }
  Future<String> IptHeaderCompleteApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.iptHeaderComplete, sessionManagement);
  }

  Future<String> IptLotNoApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.iptLotNo, sessionManagement);
  }

  Future<String> IptApproverApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.iptApproverList, sessionManagement);
  }


  Future<String> getEmployeeApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }


  Future<String> approvarLineUpadateApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.iptApproverLineUpdate, sessionManagement);
  }

  Future<String> approvarCompleteRejectedApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.iptApproverCompleteRejected, sessionManagement);
  }

}