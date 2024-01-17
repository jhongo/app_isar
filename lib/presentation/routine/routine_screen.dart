import 'package:flutter/material.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  TextEditingController _TextEditngController = TextEditingController();

  List<String> categories = ['work','school', 'home'];
  String? categoryValue = 'work';

  @override
  void initState() {
    super.initState();

    final text = _TextEditngController.text;
    print(text);
    setState(() {
      
    });
  }



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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category'), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: DropdownButton(
                      isExpanded: true,
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
              ),

              Text('Title'),
              TextFormField(
                controller: _TextEditngController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder()
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}