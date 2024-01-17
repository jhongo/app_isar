import 'package:app_isar/presentation/routine/routine_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
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
                context, MaterialPageRoute(builder:(context) => const CreateRoutine(),));
            }, 
          )],
      ),
      body: const Center(
         child: Text('HomeScreen'),
      ),
    );
  }
}