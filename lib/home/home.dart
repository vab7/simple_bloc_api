import 'package:blocapi/home/bloc/home_bloc.dart';
import 'package:blocapi/services/bored_service.dart';
import 'package:blocapi/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('bloc'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedState) {
              return Column(
                children: [
                  Text(state.name),
                  Text(state.type),
                  Text(state.participants.toString()),
                  ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
                    child: const Text('next load'),
                  )
                ],
              );
            }
            if (state is NoInternetState) {
              return const Text('no connection internet');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
