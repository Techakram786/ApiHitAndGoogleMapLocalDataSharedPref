class LoginResponse {
  String? name;
  String? email;
  String? password;
  String? roleId;
  String? roleName;
  String? condition;
  String? message;
  String? isHo;
  String? clusterId;
  String? company_id;
  String? employee_id_auto_genrated;
  String? grade;
  String? shiftCode;
  String? managerId;
  String? phoneNo;
  String? emailIds;
  String? locationCode;
  String? jwtToken;
  String? requestHostName;
  String? userType;
  String? profile;
  List<Menu>? menu;

  LoginResponse(
      {this.name,
        this.email,
        this.password,
        this.roleId,
        this.roleName,
        this.condition,
        this.message,
        this.isHo,
        this.clusterId,
        this.company_id,
        this.employee_id_auto_genrated,
        this.grade,
        this.shiftCode,
        this.managerId,
        this.phoneNo,
        this.emailIds,
        this.locationCode,
        this.jwtToken,
        this.requestHostName,
        this.userType,
        this.profile,
        this.menu});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    roleId = json['roleId'];
    roleName = json['role_name'];
    condition = json['condition'];
    message = json['message'];
    isHo = json['is_ho'];
    clusterId = json['cluster_id'];
    company_id = json['company_id'];
    employee_id_auto_genrated = json['employee_id_auto_genrated'];
    grade = json['grade'];
    shiftCode = json['shift_code'];
    managerId = json['manager_id'];
    phoneNo = json['phoneNo'];
    emailIds = json['email_ids'];
    locationCode = json['locationCode'];
    jwtToken = json['jwt_token'];
    requestHostName = json['request_host_name'];
    userType = json['user_type'];
    profile = json['profile'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['roleId'] = this.roleId;
    data['company_id'] = this.company_id;
    data['employee_id_auto_genrated'] = this.employee_id_auto_genrated;
    data['role_name'] = this.roleName;
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['is_ho'] = this.isHo;
    data['cluster_id'] = this.clusterId;
    data['grade'] = this.grade;
    data['shift_code'] = this.shiftCode;
    data['manager_id'] = this.managerId;
    data['phoneNo'] = this.phoneNo;
    data['email_ids'] = this.emailIds;
    data['locationCode'] = this.locationCode;
    data['jwt_token'] = this.jwtToken;
    data['request_host_name'] = this.requestHostName;
    data['user_type'] = this.userType;
    data['profile'] = this.profile;
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? id;
  String? title;
  String? tooltip;
  String? translate;
  String? type;
  String? icon;
  List<Children>? children;

  Menu(
      {this.id,
        this.title,
        this.tooltip,
        this.translate,
        this.type,
        this.icon,
        this.children});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tooltip = json['tooltip'];
    translate = json['translate'];
    type = json['type'];
    icon = json['icon'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tooltip'] = this.tooltip;
    data['translate'] = this.translate;
    data['type'] = this.type;
    data['icon'] = this.icon;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? title;
  String? type;
  String? icon;
  String? id;
  String? link;

  Children({this.title, this.type, this.icon, this.id, this.link});

  Children.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['link'] = this.link;
    return data;
  }
}