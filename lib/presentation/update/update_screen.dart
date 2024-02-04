import 'package:app_isar/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_isar/collections/category.dart';
import 'package:app_isar/collections/routine.dart';
import 'package:isar/isar.dart';


class UpdateScreen extends StatefulWidget {
  final Isar isar;
  final Routine routine;
  const UpdateScreen({super.key, required this.isar, required this.routine});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {


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
    _setRoutineInfo();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Routine'),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(isarIns: widget.isar,),));
          }, 
          icon: const Icon(Icons.arrow_back_ios_new))
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Category'), 
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
                              title: const Text('Add Category'),
                              content: TextField(
                                controller: _categoryController,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, 
                                  child: const Text('Cancel')),
                                TextButton(
                                  onPressed: () {
                                    if (_categoryController.text.isNotEmpty) {
                                    _addCategory(widget.isar);
                                    }
                                  }, 
                                  child: const Text('Save'))
                              ],
                            );
                          });
                      }, 
                      icon: const Icon(Icons.add))
                ],
              ),

              const Text('Title'),
              TextFormField(
                controller: _titleEditngController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Start Time'),
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

              const SizedBox(height: 20,),
              const Text('Day'),
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
                    
                    });
                  }, 
                  child: const Text('UPDATE')
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

  _addCategory(Isar isar) async {
    final categories = isar.categorys;

    final newCategory = Category()
    ..name = _categoryController.text; 

    await isar.writeTxn(() async {
      await categories.put(newCategory);

    });
    _categoryController.clear();
    _readCategory();
  }

  _readCategory() async{
    final categoryCollection = widget.isar.categorys;
    final getAllCategory = await categoryCollection.where().findAll();
    setState(() {
      categoryValue = null;
      categories = getAllCategory;
    });
    
  }

  _setRoutineInfo() async{
    await _readCategory();
    _titleEditngController.text = widget.routine.title ?? '';
    _timeController.text = widget.routine.startTime ?? '';
    dayValue = widget.routine.day ?? '';
  }


}