import 'package:base_bloc_study/app.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'counter_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const CounterApp()),
    blocObserver: CounterObserver(),
  );
}
