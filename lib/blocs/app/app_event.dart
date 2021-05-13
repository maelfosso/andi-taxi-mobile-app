part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppSignOutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object?> get props => [];
}

