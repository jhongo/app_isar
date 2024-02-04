import 'package:app_isar/collections/routine.dart';
import 'package:app_isar/presentation/routine/routine_screen.dart';
import 'package:app_isar/presentation/update/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  final Isar isarIns;
  // final Routine? routine;
  const HomeScreen({Key? key, required this.isarIns}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Routine>? routines;

  // _routePage(Isar isarIns){
  //   Navigator.of(context).push(
  //     PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
  //       return FadeTransition(opacity: animation, child: UpdateScreen(isar: widget.isarIns,));
  //     } )
  //   );

  // }

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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateRoutine(isarIns: widget.isarIns);
              },));
            }, 
          )],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: _buildWidgets(),
        )
      )
    );
  }

  List<Widget> _buildWidgets(){
    
    List<Widget> list = [];
    for(int i = 0;  i < routines!.length; i++){
      list.add(
        Card(
          child: ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateScreen(isar: widget.isarIns, routine: routines![i]);
              },));
            },
            minVerticalPadding: 20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(routines![i].title ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                RichText(text:  TextSpan(
                  style:const TextStyle(color: Colors.black),
                  children: [
                    const WidgetSpan(child: Icon(Icons.schedule)),
                    TextSpan(text: routines![i].startTime ?? ''),
                  ])),

                RichText(text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const WidgetSpan(child: Icon(Icons.calendar_month)),
                    TextSpan(text: routines![i].day ?? ''),
                  ])),
                  const SizedBox(height: 10,),
              ],
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        )
      );
    }
    return list;
  }



  _readRountine() async {
    final routineCollection = widget.isarIns.routines;
    final getRoutine = await routineCollection.where().findAll();
    setState(() {
      routines = getRoutine;
    });

  }
}