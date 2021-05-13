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

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    RestClient? api
  }) :  _cache = cache ?? CacheClient(),
        _api = api ?? APIs.getRestClient() ;

  final CacheClient _cache;
  final RestClient _api;


  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';
  
  // Stream<User>
  User get user {
    return User.empty;
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<UserCode> signUpCustomer({ required String name, required String phone }) async {
    UserCode userCode;

    try {
      userCode = await _api.SignUp(name, phone);
    } on Exception {
      throw SignUpFailure();
    }

    return userCode;
  }

  Future<UserCode> signIn({ required String phone }) async {
    UserCode userCode;

    try {
      userCode = await _api.SignIn(phone);
    } on Exception {
      throw SignInFailure();
    }

    return userCode;
  }

  Future<UserToken> signCode({ required String phone, required String code }) async {
    UserToken userToken;

    try {
      userToken = await _api.SignCode(phone, code);
    } on Exception {
      throw SignCodeFailure();
    }

    return userToken;
  }

  Future<void> signOut() async {
    try {
      
    } on Exception {
      throw SignOutFailure();
    }
  }


}