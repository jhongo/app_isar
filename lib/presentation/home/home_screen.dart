import 'package:app_isar/presentation/routine/routine_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatelessWidget {
  final Isar isarIns;
  const HomeScreen({Key? key, required this.isarIns}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(builder:(context) =>  CreateRoutine(isarIns: isarIns,),));
            }, 
          )],
      ),
      body: const Center(
         child: Text('HomeScreen'),
      ),
    );
  }
}