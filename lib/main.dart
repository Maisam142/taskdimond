import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskdimond/home_screen/home_screen.dart';
import 'package:taskdimond/home_screen/home_screen_view_model.dart';
import 'domain/use_cases/fetch_movie_use_case.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies("Dev");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeScreenViewModel(getIt<FetchMovieUseCase>())),

  ], child: MyApp()));
}



class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomePage(),

      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Builder(
            builder: (context) {
              return MaterialApp.router(
                routerDelegate: routerDelegate,
                routeInformationParser: BeamerParser(),
                debugShowCheckedModeBanner: false,
              );},
          );
        }
    );
  }
}
