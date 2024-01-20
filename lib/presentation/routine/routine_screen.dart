import 'package:flutter/material.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  final TextEditingController _titleEditngController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();


  List<String> categories = ['work','school', 'home'];
  List<String> days = ['monday','tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];

  String? dayValue = 'monday';
  String? categoryValue = 'work';

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
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
                      onPressed:(){
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Add Category'),
                              content: TextField(
                                controller: _categoryController,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, 
                                  child: Text('Cancel')),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, 
                                  child: Text('Save'))
                              ],
                            );
                          });
                      }, 
                      icon: const Icon(Icons.add))
                ],
              ),

              Text('Title'),
              TextFormField(
                controller: _titleEditngController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              Text('Start Time'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _timeController,
                      enabled: false,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      _selectedTime(context);
                    }, 
                    icon: const Icon(Icons.timer))
                ],
              ),

              SizedBox(height: 20,),
              Text('Day'),
              DropdownButton(
                isExpanded: true,
                value: dayValue,
                items: days.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )).toList() , 
                onChanged:(value) {
                  setState(() {
                  dayValue = value;
                  });
                },
                ),

            Align(
              alignment: Alignment.center,
                child: FilledButton(
                  onPressed: (){}, 
                  child: Text('SAVE')
                  ),
              )  
        
            ],
          ),
        ),
      ),
    );
  }

  _selectedTime(BuildContext context) async {
  final TimeOfDay? timeofDay = await showTimePicker(
    context: context, 
    initialTime: selectedTime,
    initialEntryMode: TimePickerEntryMode.dial
    );

  if(timeofDay != null && timeofDay != selectedTime) {
    selectedTime = timeofDay;
    setState(() {
      _timeController.text = "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}";
    });
  }
}
}



