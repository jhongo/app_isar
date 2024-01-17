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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen(),
      theme: ThemeData(
       useMaterial3: true
      )
    );
  }
}