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
    CacheClient? cache
  }) : _cache = cache ?? CacheClient() ;

  final CacheClient _cache;


  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';
  
  Stream<User> get user {
    return 
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<void> signUpCustomer({ required String name, required String phone }) async {
    try {
      
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> signIn({ required String phone }) async {
    try {

    } on Exception {
      throw SignInFailure();
    }
  }

  Future<void> signCode({ required String phone, required String code }) async {
    try {

    } on Exception {
      throw SignCodeFailure();
    }
  }

  Future<void> signOut() async {
    try {

    } on Exception {
      throw SignOutFailure();
    }
  }


}