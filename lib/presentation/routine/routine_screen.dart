import 'package:app_isar/collections/category.dart';
import 'package:app_isar/collections/routine.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class CreateRoutine extends StatefulWidget {
  final Isar isarIns;
  const CreateRoutine({super.key, required this.isarIns});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  final TextEditingController _titleEditngController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();


  List<Category>? categories;
  List<String> days = ['monday','tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];

  String? dayValue = 'monday';
  Category? categoryValue;

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _readCategory();
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
                      items: categories?.map<DropdownMenuItem<Category>>((Category category){
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Text('${category.name}'),
                        );
                      }).toList(),
                      onChanged: (Category? value) {
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
                                    if (_categoryController.text.isNotEmpty) {
                                    _addCategory(widget.isarIns);
                                    }
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
                  onPressed: (){
                    setState(() {
                    addRoutine();
                    });
                  }, 
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

  _addCategory(Isar isarIns) async {
    final categories = isarIns.categorys;

    final newCategory = Category()
    ..name = _categoryController.text; 

    await isarIns.writeTxn(() async {
      await categories.put(newCategory);

    });
    _categoryController.clear();
    _readCategory();
  }

  _readCategory() async{
    final categoryCollection = widget.isarIns.categorys;
    final getAllCategory = await categoryCollection.where().findAll();
    setState(() {
      categoryValue = null;
      categories = getAllCategory;
    });
    
  }

  Future<void> addRoutine() async{
    final routineCollection = widget.isarIns.routines;
    final newRoutine = Routine()
        ..title = _titleEditngController.text
        ..startTime = _timeController.text
        ..day = dayValue
        ..category.value = categoryValue;
    
    await widget.isarIns.writeTxn(() async{
      await routineCollection.put(newRoutine);
    });
    _titleEditngController.clear();
    _timeController.clear();
    dayValue = 'monday';
    categoryValue = categories?.first;

    print('Routine saved successfully');

  }
}



