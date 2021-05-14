import 'dart:async';

import 'package:andi_taxi/api/api.dart';
import 'package:andi_taxi/api/response/user-code.dart';
import 'package:andi_taxi/api/response/user-token.dart';
import 'package:andi_taxi/cache/cache.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/ui/sign_code.dart';
import 'package:meta/meta.dart';

class SignUpFailure implements Exception {}

class SignInFailure implements Exception {}

class SignCodeFailure implements Exception {}

class SignOutFailure implements Exception {}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({
    CacheClient? cache,
    RestClient? api
  }) :  _cache = cache ?? CacheClient(),
        _api = api ?? APIs.getRestClient() ;

  final CacheClient _cache;
  final RestClient _api;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @visibleForTesting
  static const tokenCacheKey = '__token_cache_key__';
  
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  User get user {
    return User.empty;
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<UserCode> signUpCustomer({ required String name, required String phone }) async {
    UserCode userCode;
    print('API signUpCustomer: $name - $phone');
    try {
      userCode = await _api.SignUp(name, phone);
    } on Exception catch (e) {
      print('API Sign up throw execption');
      print(e);
      throw SignUpFailure();
    }

    return userCode;
  }

  Future<UserCode> signIn({ required String phone }) async {
    UserCode userCode;

    try {
      userCode = await _api.SignIn(phone);
      _controller.add(AuthenticationStatus.authenticated);
    } on Exception {
      throw SignInFailure();
    }

    return userCode;
  }

  Future<UserToken> signCode({ required String phone, required String code }) async {
    UserToken userToken;

    try {
      userToken = await _api.SignCode(phone, code);
      _cache.write<User>(key: userCacheKey, value: userToken.user);
      _cache.write<String>(key: tokenCacheKey, value: userToken.token);
      _controller.add(AuthenticationStatus.authenticated);
    } on Exception {
      throw SignCodeFailure();
    }

    return userToken;
  }

  Future<void> signOut() async {
    try {
      _controller.add(AuthenticationStatus.unauthenticated);
    } on Exception {
      throw SignOutFailure();
    }
  }

  void dispose() {
    _controller.close();
  }


}