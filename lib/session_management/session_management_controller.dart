import 'dart:convert';

import 'package:pristine_seeds/models/loginModel/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement {
  Future<void> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Email', email);
  }
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Email');
  }

  Future<String?> getAuthToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('AuthToken');
      if (token == null || token == "") return null;
      return token;
    } catch (e) {
      return null;
    }
  }
  Future<void> setAuthToken(String AuthToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('AuthToken', AuthToken);
  }

  Future<void> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }
  Future<String?> getName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var name = prefs.getString('name');
      if (name == null || name == "") return null;
      return name;
    } catch (e) {
      return null;
    }
  }

  Future<void> setPhoneNo(String phoneNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNo', phoneNo);
  }
  Future<String?> getPhoneNo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var phoneNo = prefs.getString('phoneNo');
      if (phoneNo == null || phoneNo == "") return null;
      return phoneNo;
    } catch (e) {
      return null;
    }
  }

  Future<void> setRoleName(String role_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role_name', role_name);
  }
  Future<String?> getRoleName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var role_name = prefs.getString('role_name');
      if (role_name == null || role_name == "") return null;
      return role_name;
    } catch (e) {
      return null;
    }
  }

  Future<void> setCompanyId(String company_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('company_id', company_id);
  }
  Future<String?> getCompanyId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var company_id = prefs.getString('company_id');
      if (company_id == null || company_id == "") return null;
      return company_id;
    } catch (e) {
      return null;
    }
  }

  Future<void> setEmployeeId(String employee_id_auto_genrated) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('employee_id_auto_genrated', employee_id_auto_genrated);
  }
  Future<String?> getEmployeeId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var employee_id_auto_genrated = prefs.getString('employee_id_auto_genrated');
      if (employee_id_auto_genrated == null || employee_id_auto_genrated == "") return null;
      return employee_id_auto_genrated;
    } catch (e) {
      return null;
    }
  }

  Future<void> setIsHo(String is_ho) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('is_ho', is_ho);
  }
  Future<String?> getIsHo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var is_ho = prefs.getString('is_ho');
      if (is_ho == null || is_ho == "") return null;
      return is_ho;
    } catch (e) {
      return null;
    }
  }

  Future<void> setEmpId(String emp_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('emp_id', emp_id);
  }
  Future<String?> getEmpId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var emp_id = prefs.getString('emp_id');
      if (emp_id == null || emp_id == "") return null;
      return emp_id;
    } catch (e) {
      return null;
    }
  }

  Future<void> setLocationId(String location_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location_id', location_id);
  }
  Future<String?> getLocationId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var location_id = prefs.getString('location_id');
      if (location_id == null || location_id == "") return null;
      return location_id;
    } catch (e) {
      return null;
    }
  }

  Future<void> setManagerId(String manager_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('manager_id', manager_id);
  }
  Future<String?> getManagerId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var manager_id = prefs.getString('manager_id');
      if (manager_id == null || manager_id == "") return null;
      return manager_id;
    } catch (e) {
      return null;
    }
  }

  Future<void> setShiftCode(String shift_code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('shift_code', shift_code);
  }
  Future<String?> getShiftCode() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var shift_code = prefs.getString('shift_code');
      if (shift_code == null || shift_code == "") return null;
      return shift_code;
    } catch (e) {
      return null;
    }
  }

  Future<void> setState(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('state', state);
  }
  Future<String?> getState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var state = prefs.getString('state');
      if (state == null || state == "") return null;
      return state;
    } catch (e) {
      return null;
    }
  }

  Future<void> setCountry(String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('country', country);
  }
  Future<String?> getCountry() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var country = prefs.getString('country');
      if (country == null || country == "") return null;
      return country;
    } catch (e) {
      return null;
    }
  }

  Future<void> setGrade(String grade) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('grade', grade);
  }
  Future<String?> getGrade() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var grade = prefs.getString('grade');
      if (grade == null || grade == "") return null;
      return grade;
    } catch (e) {
      return null;
    }
  }

  Future<void> setDesignation(String designation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('designation', designation);
  }
  Future<String?> getDesignation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var designation = prefs.getString('designation');
      if (designation == null || designation == "") return null;
      return designation;
    } catch (e) {
      return null;
    }
  }

  Future<void> setDepartment(String department) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('department', department);
  }
  Future<String?> getDepartment() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var department = prefs.getString('department');
      if (department == null || department == "") return null;
      return department;
    } catch (e) {
      return null;
    }
  }

  Future<void> setRequestHostName(String request_host_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('request_host_name', request_host_name);
  }
  Future<String?> getRequestHostName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var request_host_name = prefs.getString('request_host_name');
      if (request_host_name == null || request_host_name == "") return null;
      return request_host_name;
    } catch (e) {
      return null;
    }
  }

  Future<void> setMenuList(List<Menu> menuList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final menuJsonList = menuList.map((menu) => menu.toJson()).toList();
    await prefs.setString('MenuList', json.encode(menuJsonList));
  }
  Future<List<Menu>> getMenuList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final menuJson = prefs.getString('MenuList');
    if (menuJson != null) {
      final List<dynamic> menuJsonList = json.decode(menuJson);
      final List<Menu> menuList =
      menuJsonList.map((json) => Menu.fromJson(json)).toList();
      return menuList;
    }
    return [];
  }

  Future<void> setCheckIn(String checkin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('checkin', checkin);
  }
  Future<String?> getCheckIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var checkin = prefs.getString('checkin');
      if (checkin == null || checkin == "") return null;
      return checkin;
    } catch (e) {
      return null;
    }
  }

  Future<void> setStartTime(String shiftStartTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('shiftStartTime', shiftStartTime);
  }
  Future<String?> getStartTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var shiftStartTime = prefs.getString('shiftStartTime');
      if (shiftStartTime == null || shiftStartTime == "") return null;
      return shiftStartTime;
    } catch (e) {
      return null;
    }
  }

  Future<void> setEndTime(String shiftEndTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('shiftEndTime', shiftEndTime);
  }
  Future<String?> getEndTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var shiftEndTime = prefs.getString('shiftEndTime');
      if (shiftEndTime == null || shiftEndTime == "") return null;
      return shiftEndTime;
    } catch (e) {
      return null;
    }
  }

  Future<void> setProfile(String profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile', profile);
  }
  Future<String?> getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var profile = prefs.getString('profile');
      if (profile == null || profile == "") return null;
      return profile;
    } catch (e) {
      return null;
    }
  }
  Future<void> setFirebaseToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
  Future<String> getFirebaseToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token == null || token == "") return '';
      return token;
    } catch (e) {
      return '';
    }
  }

  Future<bool> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }
}