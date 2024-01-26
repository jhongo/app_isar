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

  @override
  void initState() {
    super.initState();
    _readRountine();
    print('Welcome Init State');
  }

  @override
  void dispose() {
    _readRountine();
    print('Bye Home Screen');
    super.dispose();

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
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder:(context) =>  CreateRoutine(isarIns: widget.isarIns,),));
            }, 
          )],
      ),
      body:SingleChildScrollView(
        child: Column(
          
          children: List.generate(
            routines!.length, 
            (index) {
              return Card(
              child: ListTile(
                minVerticalPadding: 20,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(routines![index].title ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    RichText(text:  TextSpan(
                      style:const TextStyle(color: Colors.black),
                      children: [
                        const WidgetSpan(child: Icon(Icons.schedule)),
                        TextSpan(text: routines![index].startTime ?? ''),
                      ])),

                    RichText(text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(child: Icon(Icons.calendar_month)),
                        TextSpan(text: routines![index].day ?? ''),
                      ])),
                  ],
                ),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            );
            }
            )
        )
      )
    );
  }

  _readRountine() async {
    final routineCollection = widget.isarIns.routines;
    final getRoutine = await routineCollection.where().findAll();
    setState(() {
      routines = getRoutine;
    });

  }
}