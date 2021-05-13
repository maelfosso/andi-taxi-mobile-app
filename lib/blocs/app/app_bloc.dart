import 'dart:async';

import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({ required AuthenticationRepository authenticationRepository })
    : _authenticationRepository = authenticationRepository,
      super(
        authenticationRepository.currentUser.isNotEmpty
          ? AppState.authenticated(authenticationRepository.currentUser)
          : const AppState.unauthenticated()
      ) {
    // _userSubscription = _authenticationRepository.user.listen
  }

  final AuthenticationRepository _authenticationRepository;
  // late final StreamSubscription<User> _userSubscription;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AppSignOutRequested) {
      unawaited(_authenticationRepository.signOut());
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isNotEmpty
      ? AppState.authenticated(event.user)
      : const AppState.unauthenticated()
    ;
  }

  @override
  Future<void> close() {
    // _userSubscription.cancel();
    return super.close();
  }
}
