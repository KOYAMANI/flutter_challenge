import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/views/bloc/blocs.dart';
import 'package:flutter_challenge/views/screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<BottomNavBarBloc>(
        create: (context) => BottomNavBarBloc()
          ..add(
            const AppStarted(),
          ),
        child: const NavigationScreen(),
      ),
    );
  }
}
