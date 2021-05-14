import 'package:andi_taxi/api/response/user-code.dart';
import 'package:andi_taxi/api/response/user-token.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

class APIs {
  static const String signUp = "/auth/signup";
  static const String signIn = "/auth/signin";
  static const String signCode = "/auth/signcode";

  static RestClient? _restClient;

  static RestClient getRestClient() {
    if (_restClient == null) {
      _restClient = RestClient(
        Dio(BaseOptions(contentType: "application/json"))
      );
    }

    return _restClient!;
  }
}

@RestApi(baseUrl: "http://192.168.8.100:3000/api")
abstract class RestClient {
  factory RestClient(Dio dio, { String baseUrl }) = _RestClient;

  @POST(APIs.signUp)
  Future<UserCode> SignUp(@Field() String name, @Field("phoneNumber") String phone);

  @POST(APIs.signIn)
  Future<UserCode> SignIn(@Field() String phoneNumber);

  @POST(APIs.signCode)
  Future<UserToken> SignCode(@Field() String phoneNumber, @Field() String code);
}