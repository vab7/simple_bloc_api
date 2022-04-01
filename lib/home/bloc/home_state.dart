part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends HomeState {
  final String name;
  final String type;
  final int participants;

  const LoadedState(
    this.name,
    this.type,
    this.participants,
  );

  @override
  List<Object?> get props => [];
}

class NoInternetState extends HomeState {
  @override
  List<Object?> get props => [];
}
