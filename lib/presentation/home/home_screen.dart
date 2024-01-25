import 'package:app_isar/collections/routine.dart';
import 'package:app_isar/presentation/routine/routine_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  final Isar isarIns;
  const HomeScreen({Key? key, required this.isarIns}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Routine>? routines;

  getRoutines() async{
    routines = await widget.isarIns.routines.where().findAll();
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
    getRoutines();
    });
  }

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
                context, MaterialPageRoute(builder:(context) =>  CreateRoutine(isarIns: widget.isarIns,),));
            }, 
          )],
      ),
      body:SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: routines?.length,
          itemBuilder:(context, index) {            
            return Card(
              child: ListTile(
                title: Text(routines?[index].title ?? 'No title'),
                subtitle: Text(routines?[index].day ?? 'No day'),
                trailing: Text(routines?[index].startTime ?? 'No time'),
              ));
          },          
          )
      ),
    );
  }
}