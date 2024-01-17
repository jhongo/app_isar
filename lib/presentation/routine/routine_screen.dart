import 'package:flutter/material.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  List<String> categories = ['work','school', 'home'];
  String? categoryValue = 'work';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Routine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('Category'), 
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: DropdownButton(
                      dropdownColor: Colors.indigo.shade50,
                      value: categoryValue,
                      items: categories.map((String category){
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                        categoryValue = value ;
                        });
                      }),
                  ),
                    IconButton(
                      onPressed:(){}, 
                      icon: const Icon(Icons.add))
                ],
              )
        
            ],
          ),
        ),
      ),
    );
  }
}