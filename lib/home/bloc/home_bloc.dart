import 'package:blocapi/services/bored_service.dart';
import 'package:blocapi/services/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;

  HomeBloc(
    this._boredService,
    this._connectivityService,
  ) : super(LoadingState()) {
    _connectivityService.connectivityStream.stream.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          add(LoadApiEvent());
        } else {
          add(NoInternetEvent());
        }
      },
    );

    on<LoadApiEvent>(
      (event, emit) async {
        emit(LoadingState());
        final activity = await _boredService.getBoredActivity();
        emit(
          LoadedState(
            activity.activity,
            activity.type,
            activity.participants,
          ),
        );
      },
    );

    on<NoInternetEvent>(
      (event, emit) {
        emit(NoInternetState());
      },
    );
  }
}
