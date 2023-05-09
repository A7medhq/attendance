class UserData {
  String? status;
  Data? data;
  String? message;

  UserData({this.status, this.data, this.message});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? name;
  String? employeeCode;
  String? notifyMobile;
  String? notifyEmail;
  String? image;
  String? identifierNo;
  String? identifierType;
  String? bankIBAN;
  String? bankName;
  String? religion;
  String? title;
  String? employmentType;

  Data(
      {this.name,
      this.employeeCode,
      this.notifyMobile,
      this.notifyEmail,
      this.image,
      this.identifierNo,
      this.identifierType,
      this.bankIBAN,
      this.bankName,
      this.religion,
      this.title,
      this.employmentType});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    employeeCode = json['employee_code'];
    notifyMobile = json['notify_mobile'];
    notifyEmail = json['notify_email'];
    image = json['image'];
    identifierNo = json['identifier_no'];
    identifierType = json['identifier_type'];
    bankIBAN = json['bank_IBAN'];
    bankName = json['bank_name'];
    religion = json['religion'];
    title = json['title'];
    employmentType = json['employment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['employee_code'] = this.employeeCode;
    data['notify_mobile'] = this.notifyMobile;
    data['notify_email'] = this.notifyEmail;
    data['image'] = this.image;
    data['identifier_no'] = this.identifierNo;
    data['identifier_type'] = this.identifierType;
    data['bank_IBAN'] = this.bankIBAN;
    data['bank_name'] = this.bankName;
    data['religion'] = this.religion;
    data['title'] = this.title;
    data['employment_type'] = this.employmentType;
    return data;
  }
}
