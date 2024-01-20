import 'package:app_isar/collections/category.dart';
import 'package:app_isar/collections/routine.dart';
import 'package:app_isar/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isarIns = await Isar.open(
    [CategorySchema, RoutineSchema], 
    directory: dir.path);

  runApp(MyApp(isarIns: isarIns,));
}

class MyApp extends StatelessWidget {
  final Isar isarIns;
  const MyApp({super.key, required this.isarIns});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen(isarIns: isarIns),
      theme: ThemeData(
       useMaterial3: true
      )
    );
  }
}