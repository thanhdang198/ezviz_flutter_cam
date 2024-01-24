class YsAuthenticationResponseEntity {
  YsAuthenticationDataResponseEntity? data;
  String? code;
  String? msg;

  YsAuthenticationResponseEntity({this.data, this.code, this.msg});

  YsAuthenticationResponseEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? YsAuthenticationDataResponseEntity.fromJson(json['data'])
        : null;
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    data['msg'] = msg;
    return data;
  }
}

class YsAuthenticationDataResponseEntity {
  String? accessToken;
  int? expiredTime;
  String? areaDomain;
  YsAuthenticationDataResponseEntity(
      {this.accessToken, this.areaDomain, this.expiredTime});

  factory YsAuthenticationDataResponseEntity.fromJson(Map json) {
    return YsAuthenticationDataResponseEntity(
        accessToken: json['accessToken'],
        expiredTime: json['expireTime'],
        areaDomain: json['areaDomain']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['expireTime'] = expiredTime;
    data['areaDomain'] = areaDomain;
    return data;
  }
}
