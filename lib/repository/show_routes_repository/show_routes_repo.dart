import 'package:pristine_seeds/network_data/network/network_api_service.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../resourse/appUrl/app_url.dart';

class ShowRoutesRepository {
  final _apiService = NetworkApiServices();
  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }

  Future<String> userWiseCoordinatesApiHit(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.getDateWiseUserCoordinate, sessionManagement);
  }
}