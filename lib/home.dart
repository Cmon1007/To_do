import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Tab_bar/second.dart';
import 'Tab_bar/third.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

   late TabController _tcontrol;
  @override
  void initState() {
    _tcontrol= TabController(length: 3, vsync: this);
    super.initState();
  }

  List<String> todos=[];
  final controller=TextEditingController();
   
    String text="";
    DateTime _dateTime=DateTime.now();
   
   Future<void> _selectDate(BuildContext context)async {
    final DateTime? selectDat= await showDatePicker(context: context,
     initialDate: _dateTime,
      firstDate: DateTime(2000), 
      lastDate: DateTime(2025)
      );
      if(selectDat!=null){
        setState(() {
          
          _dateTime=selectDat;
        });
      }
   }
   
    
    TimeOfDay _timeOfDay=const TimeOfDay(hour: 8, minute: 30);
  Future<void>_selectTime(BuildContext context) async{
    final TimeOfDay? selectTim=await showTimePicker(context: context,
     initialTime: TimeOfDay.now()
     );
     if(selectTim!=null)
     {
      setState(() {
        _timeOfDay=selectTim;
      });
     }
    
  }
  
  String priority="high";
  //  message(String text)
  // {
  //  text="empty";
  // }
 
  @override
  Widget build(BuildContext context) {
    String formatdate=DateFormat.yMMMd().format(_dateTime);
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: const  Text("To DO"),
              leading: IconButton(onPressed: (){},
               icon: const Icon(Icons.arrow_back)),
              
            ),
            backgroundColor: const Color.fromARGB(255, 249, 249, 249),
            floatingActionButton: FloatingActionButton(onPressed: (){
              showDialog(        //showin add dialog
                
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  title:  const Text("Add To Do",textAlign: TextAlign.center,),
                  actions: [
                    TextField(
                      
                      controller: controller,
                      
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1,color: Colors.black,),
                 
                      ),
                      hintText: "Type Your To Do List Here",
                    ),

                    //validation not working
                    // onChanged: (value) {
                    //   if(value.isEmpty)
                    //   {
                    //     return message(text);
                    //   }
                    // },
    
                    ),
                    const SizedBox(height: 10,),
                    //Radio button for priority
                    Column(
                      children: [
                        RadioListTile(
                          title: const Text("High Priority"),
                          value: "high",
                         groupValue: priority,
                          onChanged:(value) {
                            setState(() {
                              priority=value.toString();
                            });
                          },
                          ),
                            RadioListTile(
                              title: const Text("Medium Priority"),
                          value: "medium",
                         groupValue: priority,
                          onChanged:(value) {
                            setState(() {
                              priority=value.toString();
                            });
                          },
                          ),
                            RadioListTile(
                              title: const Text("Low Priority"),
                          value: "other",
                         groupValue: priority,
                          onChanged:(value) {
                            setState(() {
                              priority=value.toString();
                              
                            });
                          },
                          )
                      ],
                    ),
                  // date picker
                    Row(
                      children: [
                        Column(
                          children: [
                           Text("Date: $formatdate"),
                           IconButton(onPressed: (){
                            _selectDate(context);
                           },
                            icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                        const Spacer(),
                        //time picker
                        Column(
                          children: [
                            Text("Time: ${_timeOfDay.format(context).toString()}"),
                            IconButton(onPressed: (){
                              _selectTime(context);
                              setState(() {
                                todos.add(controller.text);
                              });
                            },
                             icon: const Icon(Icons.timer))
                          ],
                        )
                      ],
    
                    ),
                   //adding elevated button
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                             setState(() {
                          todos.add(controller.text);       //add input text to list tile
                          controller.clear();
                        });
                        
                        Navigator.of(context).pop();
                      },
                       child: const Text("Add To Do")),
                    )
                  
                  ],
                ),
                
                
                 );
            },
            backgroundColor: const Color.fromARGB(255, 15, 15, 15),
            child: const Icon(Icons.add,color:Color.fromARGB(255, 252, 250, 250),),),
        
            body: Column(
                children: [
                  Container(
                    
              decoration: const BoxDecoration(color: Color.fromARGB(255, 98, 67, 129)),
                    child: const TabBar(tabs: [
                      Tab(
                        icon:  Icon(Icons.my_library_add,color: Colors.white,),
                        text: "My To Dos",
                        
                      ),
                      Tab(icon:  Icon(Icons.timer,color: Colors.white,),
                      text: "In-Progress",
                      ),
                      Tab(
                        icon: Icon(Icons.check_box,color: Colors.white,),
                      text: "Completed",
                      )
                    ]),
                    
                  ),
                   Expanded(child:
                   TabBarView(children: [

                    // first tab bar item display
                   Container(
                    decoration: const BoxDecoration(color: Color.fromARGB(255, 70, 26, 94)),
                    child: 
                    ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.white)
                
              )),
              child: ListTile(
              
                title: Text(todos[index],style: const TextStyle(color: Colors.white),),
                trailing: 
                 SizedBox(                                  // to add same edit and delete icon for every list 
                  width: 80,
                   child: Row(
                      children: [
                        Expanded(
                          child: 
                        IconButton(onPressed: (){
                          showDialog(context: context,
                           builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            actions: [
                               TextField(
                                decoration: const InputDecoration(
                                  hintText: "Edit here",
                                
                                ),
                                onChanged: (value) {                                    
                                  setState(() {
                                    text=value;
                                  });
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                      onPressed: (){
                                          setState(() {
                                            todos[index]=text;
                                          });
                                          Navigator.of(context).pop();
                                      }, 
                                    child: const Text("EDIT")),
                                ],
                              )
                             
                            ],
                           ),);
                        },
                         icon: const Icon(Icons.edit,color: Colors.grey,))),

                        Expanded(child: IconButton(onPressed: (){
                        setState(() {
                          todos.removeAt(index);
                        });
                      },
                       icon: const Icon(Icons.delete,color: Colors.red,)),),
                        
                      ]
                    ),
                 ),
                
                ),
              ),
            );
        }
      ),
                    
                   ),
                   //second tab bar item display
                   const secondTab(),
                   // third tab bar item display
                   const thirdTab(),
                   
                   ]
                   
                   
                   ),
                   ),
                   
                ],
                
              ),
              

            ),
            
        ),
      );
 
  }
  
  
  }
 

