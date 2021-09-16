import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/domain/repositories/app_theme.dart';
import 'package:flutter_challenge/views/bloc/blocs.dart';
import 'package:flutter_challenge/views/screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.customTheme,
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
