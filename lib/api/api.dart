import 'package:andi_taxi/api/response/user-code.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

class APIs {
  static const String signUp = "/auth/signup";
  static const String signIn = "/auth/signin";
  static const String signCode = "/auth/signcode";
}

@RestApi(baseUrl: "http://192.168.8.101:3000/api")
abstract class RestClient {
  factory RestClient(Dio dio, { String baseUrl }) = _RestClient;

  @POST(APIs.signUp)
  Future<UserCode> SignUp();

  @POST(APIs.signIn)
  Future<UserCode> SignIn();

  @POST(APIs.signCode)
  Future<UserCode> SignCode();
}