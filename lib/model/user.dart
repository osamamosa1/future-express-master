class User {
  final int id;
  final String code;
  final String companyName;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String bankName;
  final String bankAccountNumber;
  final List<dynamic> work;
  final int dailyReportShow;
  final String apiToken;

  User({
    required this.id,
    required this.code,
    required this.companyName,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.bankName,
    required this.bankAccountNumber,
    required this.work,
    required this.dailyReportShow,
    required this.apiToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      code: json['user']['code'],
      companyName: json['user']['company_name'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      avatar: json['user']['avatar'],
      bankName: json['user']['bank_name'],
      bankAccountNumber: json['user']['bank_account_number'],
      work: json['user']['work'],
      dailyReportShow: json['user']['Daily_Report_show'],
      apiToken: json['user']['api_token'],
    );
  }
}


class LoginModelV2 {
  int? success;
  UserV2? user;

  LoginModelV2({this.success, this.user});

  LoginModelV2.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? UserV2.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserV2 {
  int? id;
  String? code;
  String? companyName;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? bankName;
  String? bankAccountNumber;
  List<int>? work;
  int? dailyReportShow;
  String? apiToken;

  UserV2(
      {this.id,
        this.code,
        this.companyName,
        this.name,
        this.email,
        this.phone,
        this.avatar,
        this.bankName,
        this.bankAccountNumber,
        this.work,
        this.dailyReportShow,
        this.apiToken});

  UserV2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    companyName = json['company_name'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    work = json['work'].cast<int>();
    dailyReportShow = json['Daily_Report_show'];
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['company_name'] = companyName;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['bank_name'] = bankName;
    data['bank_account_number'] = bankAccountNumber;
    data['work'] = work;
    data['Daily_Report_show'] = dailyReportShow;
    data['api_token'] = apiToken;
    return data;
  }
}
