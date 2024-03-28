import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../view_model/session_management/session_management_controller.dart';

class OnlineOfflineInspectionRepository{
  final _apiService=NetworkApiServices();
  Future<String> inspectionProductionLotGetOnline(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.InspectionProductionLotGetOnline, sessionManagement);
  }
  Future<String> inspectionMoveToOffline(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.moveToOfflineInspection, sessionManagement);
  }
  Future<String> inspectionMoveToOnline(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.moveToOnlineInspection, sessionManagement);
  }
  Future<String> inspectionProductionLotGetoffline(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.inspectionProductionLotGetoffline, sessionManagement);
  }
  Future<String> inspectionProductionLotDeatailGet(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.inspectionProductionLotDeatailGet, sessionManagement);
  }

  Future<String> inspectionComplete(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.inspectionComplete, sessionManagement);
  }
}