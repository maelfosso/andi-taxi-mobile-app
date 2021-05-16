import 'package:andi_taxi/api/response/user-code.dart';
import 'package:andi_taxi/api/response/user-token.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_config/flutter_config.dart';

part 'api.g.dart';

class APIs {
  static const String signUpClient = "/auth/signup/client";
  static const String signUpDriver = "/auth/signup/driver";
  static const String signIn = "/auth/signin";
  static const String signCode = "/auth/signcode";

  static RestClient? _restClient;

  static RestClient getRestClient() {
    if (_restClient == null) {
      _restClient = RestClient(
        Dio(
          BaseOptions(
            contentType: "application/json",
            baseUrl: FlutterConfig.get("BASE_URL")
          )
        )
      );
    }

    return _restClient!;
  }
}

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, { String baseUrl }) = _RestClient;

  @POST(APIs.signUpClient)
  Future<UserCode> SignUpClient(@Field() String name, @Field("phoneNumber") String phone);
  
  @POST(APIs.signUpDriver)
  Future<UserCode> SignUpDriver(
    @Field() String name, @Field() String phoneNumber,
    @Field() String rcIdentificationNumber, @Field() String residenceAddress, @Field() String realResidenceAddress,
    @Field() Car car
  );

  @POST(APIs.signIn)
  Future<UserCode> SignIn(@Field() String phoneNumber);

  @POST(APIs.signCode)
  Future<UserToken> SignCode(@Field() String phoneNumber, @Field() String code);
}