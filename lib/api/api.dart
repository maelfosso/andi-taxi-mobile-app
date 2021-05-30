import 'dart:io';

import 'package:andi_taxi/api/response/user-code.dart';
import 'package:andi_taxi/api/response/user-token.dart';
import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/models/payment-methods-used.dart';
import 'package:andi_taxi/models/user_position.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api.g.dart';

dynamic requestInterceptor(RequestOptions options) async {
  print('[REQUEST INTERCEPTOR]');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(AuthenticationRepository.tokenCacheKey) ?? '';
  print('TOKEN EXTRACTED : $token');
  // options.headers.addAll({"Authorization": "Bearer $token"});
  options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
  print('AFTER HEADERS ... ${options.headers}');

	return options;
}

class APIs {
  static const String signUpClient = "/auth/signup/client";
  static const String signUpDriver = "/auth/signup/driver";
  static const String signIn = "/auth/signin";
  static const String signCode = "/auth/signcode";

  static const String lastLocations = "/booking/last-locations";
  static const String taxiAround = "/booking/taxi-around";
  static const String calculateCostTime = "/booking/cost-time";
  static const String paymentMethods = "/booking/payment-methods-used";

  static RestClient? _restClient;

  static RestClient getRestClient() {
    if (_restClient == null) {
      Dio dio = Dio(
        BaseOptions(
          contentType: "application/json",
          baseUrl: FlutterConfig.get("BASE_URL")
        )
      );
      dio.interceptors.clear();
      dio.interceptors.add(AuthorizationInterceptor());
      
      _restClient = RestClient(dio);
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

  @GET(APIs.lastLocations)
  Future<List<UserPosition>> GetLastLocations();

  @POST(APIs.taxiAround)
  Future<List<Car>> GetTaxiAround(@Field("position") UserPosition position);

  @POST(APIs.calculateCostTime)
  Future<List<double>> CalculateCostTime(
    @Field("from") UserPosition from,
    @Field("to") UserPosition to,
    @Field("distance") double distance,
  );

  @GET(APIs.paymentMethods)
  Future<List<PaymentMethodUsed>> GetPaymentMethodsUsed();

}

class AuthorizationInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print("--> ${options.method} ${options.path}");
    print("Content type: ${options.contentType}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(AuthenticationRepository.tokenCacheKey) ?? '';
    print('TOKEN EXTRACTED : $token');
    // options.headers.addAll({"Authorization": "Bearer $token"});
    options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    print('AFTER HEADERS ... ${options.headers}');
    print("<-- END HTTP");
    // return options; // super.onRequest(options);
    super.onRequest(options, handler);
  }
  
  // @override
  // Future<dynamic> onRequest(RequestOptions options) {
  //   print("--> ${options.method} ${options.path}");
  //   print("Content type: ${options.contentType}");
  //   print("<-- END HTTP");
  //   return options; // super.onRequest(options);
  // }

  // @override
  // Future onResponse(Response response) {
  //   print(
  //       "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
  //   String responseAsString = response.data.toString();
  //   if (responseAsString.length > _maxCharactersPerLine) {
  //     int iterations =
  //     (responseAsString.length / _maxCharactersPerLine).floor();
  //     for (int i = 0; i <= iterations; i++) {
  //       int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
  //       if (endingIndex > responseAsString.length) {
  //         endingIndex = responseAsString.length;
  //       }
  //       print(responseAsString.substring(
  //           i * _maxCharactersPerLine, endingIndex));
  //     }
  //   } else {
  //     print(response.data);
  //   }
  //   print("<-- END HTTP");

  //   return super.onResponse(response);
  // }

  // @override
  // Future onError(DioError err) {
  //   print("<-- Error -->");
  //   print(err.error);
  //   print(err.message);
  //   return super.onError(err);
  // }

}