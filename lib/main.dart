import 'package:dog_book/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:dog_book/services/dogs.service.dart';
import 'package:dog_book/services/auth.service.dart';

//GetIt gsl = GetIt.instance;

void main() {
  GetIt.I.registerSingleton<Dogs>(Dogs());
  GetIt.I.registerSingleton<Auth>(Auth());
  GetIt.I.get<Dogs>().loadBreedList();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
