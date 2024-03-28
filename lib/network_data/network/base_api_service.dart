import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

abstract class BaseApiServices{
  Future<dynamic> getApi(String url,SessionManagement sessionManagement,Map<String, String> queryParams);
  Future<dynamic> postApi(dynamic data, String url,SessionManagement sessionManagement);
}