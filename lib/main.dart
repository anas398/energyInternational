import 'package:energy_international/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/taskbloc.dart';
import 'bloc/taskevent.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      home: BlocProvider(
        create: (_) => TaskBloc()..add(FetchTasks()),
        child:  TaskScreen(),
      ),
    );
  }
}
