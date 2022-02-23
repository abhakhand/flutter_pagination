import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/app/app.dart';
import 'package:flutter_pagination/app/app_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}
