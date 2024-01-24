import 'package:dio/dio.dart';
import 'package:ys_play/src/entity/ys_authentication_entity.dart';

class YsAuthentication {
  static const String userAuth =
      "https://open.ezvizlife.com/api/lapp/token/get";

  /// 开始云台控制
  static Future<YsAuthenticationResponseEntity> getAccessToken({
    required String appKey,
    required String appSecret,
    int? speed,
  }) async {
    FormData formData = FormData.fromMap({
      "appKey": appKey,
      "appSecret": appSecret,
    });

    try {
      Response response = await Dio().post(userAuth, data: formData);
      if (response.statusCode == 200) {
        YsAuthenticationResponseEntity responseData =
            YsAuthenticationResponseEntity.fromJson(response.data);
        return responseData;
      } else {
        return YsAuthenticationResponseEntity.fromJson({
          "code": response.statusCode,
          "msg": response.statusMessage,
        });
      }
    } catch (e) {
      throw ("Request error:${e.toString()}");
    }
  }
}
