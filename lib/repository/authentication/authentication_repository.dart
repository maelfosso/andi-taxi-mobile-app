import 'dart:async';
import 'dart:convert';

import 'package:andi_taxi/api/api.dart';
import 'package:andi_taxi/api/response/user-code.dart';
import 'package:andi_taxi/api/response/user-token.dart';
import 'package:andi_taxi/blocs/authentication/authentication_bloc.dart';
import 'package:andi_taxi/cache/cache.dart';
import 'package:andi_taxi/models/car.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/ui/sign_code.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpFailure implements Exception {}

class SignInFailure implements Exception {}

class SignCodeFailure implements Exception {}

class SignOutFailure implements Exception {}

enum AuthenticationStatus { unknown, known, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({
    CacheClient? cache,
    RestClient? api
  }) :  _cache = cache ?? CacheClient(),
        _api = api ?? APIs.getRestClient() ;

  final CacheClient _cache;
  final RestClient _api;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @visibleForTesting
  static const tokenCacheKey = '__token_cache_key__';

  @visibleForTesting
  static const userCodeCacheKey = '__user_code_cache_key__';
  
  Stream<AuthenticationStatus> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.authenticated; // instead of unauthenticated
    yield* _controller.stream;
  }

  User get user {
    return User.empty;
  }

  Future<User> get currentUser async {
    final SharedPreferences prefs = await _prefs;
    final s = prefs.getString(userCacheKey);
    
    return s == null ? User.empty : User.fromJson(json.decode(s)); // _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<UserCode> get currentKnowUser async {
    final SharedPreferences prefs = await _prefs;
    final s = prefs.getString(userCodeCacheKey);
    return s == null ? UserCode.empty : UserCode.fromJson(json.decode(s)); // return _cache.read<UserCode>(key: userCodeCacheKey)!;
  }

  Future<String> get token async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(tokenCacheKey)!;
  }

  Future<UserCode> signUpClient({ required String name, required String phone }) async {
    final SharedPreferences prefs = await _prefs;

    UserCode userCode;
    print('API signUpCustomer: $name - $phone');
    try {
      userCode = await _api.SignUpClient(name, phone);
      // _cache.write<UserCode>(key: userCodeCacheKey, value: userCode);
      prefs.setString(userCodeCacheKey, json.encode(userCode));

      _controller.add(AuthenticationStatus.known);
    } on Exception catch (e) {
      print('API Sign up throw execption');
      print(e);
      throw SignUpFailure();
    }

    return userCode;
  }

  Future<UserCode> signUpDriver({ 
    required String name, required String phone,
    required String rcIdentificationNumber, required String residenceAddress, required String realResidenceAddress,
    required Car car
  }) async {
    final SharedPreferences prefs = await _prefs;
    
    UserCode userCode;
    print('API signUpCustomer: $name - $phone');
    try {
      userCode = await _api.SignUpDriver(
        name, phone,
        rcIdentificationNumber, residenceAddress, realResidenceAddress,
        car
      );
      // _cache.write<UserCode>(key: userCodeCacheKey, value: userCode);
      prefs.setString(userCodeCacheKey, json.encode(userCode));
      
      _controller.add(AuthenticationStatus.known);
    } on Exception catch (e) {
      print('API Sign up throw execption');
      print(e);
      throw SignUpFailure();
    }

    return userCode;
  }

  Future<UserCode> signIn({ required String phoneNumber }) async {
    final SharedPreferences prefs = await _prefs;

    UserCode userCode;

    try {
      userCode = await _api.SignIn(phoneNumber);
      //_cache.write<UserCode>(key: userCodeCacheKey, value: userCode);
      prefs.setString(userCodeCacheKey, json.encode(userCode));
      
      _controller.add(AuthenticationStatus.known);
    } on Exception {
      throw SignInFailure();
    }

    return userCode;
  }

  Future<UserToken> signCode({ required String phoneNumber, required String code }) async {
    final SharedPreferences prefs = await _prefs;

    UserToken userToken;

    try {
      userToken = await _api.SignCode(phoneNumber, code);
      // _cache.write<User>(key: userCacheKey, value: userToken.user);
      // _cache.write<String>(key: tokenCacheKey, value: userToken.token);
      prefs.setString(userCacheKey, json.encode(userToken.user));
      prefs.setString(tokenCacheKey, userToken.token);
      
      print("signCode : $userToken");
      _controller.add(AuthenticationStatus.authenticated);
    } on Exception {
      throw SignCodeFailure();
    }

    return userToken;
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await _prefs;

    try {
      prefs.remove(tokenCacheKey);
      prefs.remove(userCodeCacheKey);
      prefs.remove(userCacheKey);

      _controller.add(AuthenticationStatus.unauthenticated);
    } on Exception {
      throw SignOutFailure();
    }
  }

  void dispose() {
    _controller.close();
  }


}