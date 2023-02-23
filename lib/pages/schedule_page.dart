import 'package:example_project_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../models/model.dart';

// List of items in our dropdown menu
const List<String> items = <String>['Каждую неделю',
  'Раз в две недели',
  'Раз в три недели',
  'Раз в четыре недели',];



class Schedudle extends StatefulWidget {
  const Schedudle({Key? key}) : super(key: key);

  @override
  State<Schedudle> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedudle> {

  DateFormat dateFormat = DateFormat('dd MM yy');
  DateFormat timeFormat = DateFormat.Hm();

  late String _userSchedule;
  late DateTime _userTimeSchedule =  DateTime.now();
  List<Event> scheduleList = objectbox.eventBox.getAll();
  late DateTime _selectedDay;

  String _period = items.first;
/*
  EventCard Function(BuildContext, int) _itemBuilder(List<Event> events){
    return (BuildContext contexnt, int index) => EventCard(event: events[index]);
  }*/

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedDay = (ModalRoute.of(context)?.settings.arguments as DateTime?)!;
   // if (objectbox.getScheduleDayId(_selectedDay).isEqual(null)){
    //final initDay = ScheduleDay(date: _selectedDay);

   // objectbox.scheduleDayBox.put(initDay);
  //  }

  }

  Widget scheduleTable(){
    return StreamBuilder<List<Event>>(
      stream: objectbox.getAllDateEvents(_selectedDay),
      builder: (context, snapshot){
        if (snapshot.data?.isNotEmpty ?? false){
          return
            ListView.builder(
                itemCount:  snapshot.hasData ? snapshot.data!.length : 0,
                itemBuilder: (BuildContext context, int index){
                  return Dismissible(
                    key:  Key(snapshot.data![index].name),
                    child: Card(
                      child: ListTile(
                        title: Text('${timeFormat.format(snapshot.data![index].time)} ${snapshot.data![index].name}'  ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: Colors.deepOrangeAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              objectbox.eventBox.remove(snapshot.data![index].id);
                            });
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                      setState(() {
                        // eventBox.remove(event.id);
                        objectbox.eventBox.remove(snapshot.data![index].id);
                      });
                    },
                  );
                }
            );
        } else {
          return const Center(
              child: Text(
                  'Добавьте расписание',
                  style: TextStyle(color: Colors.white)));
        }
      },
    );

  }

  Widget displayTimePicker() {
    return TimePickerSpinner(
      normalTextStyle: const TextStyle(
          fontSize: 24,
          color: Colors.deepOrange
      ),
      highlightedTextStyle: const TextStyle(
          fontSize: 24,
          color: Colors.yellow
      ),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      time: DateTime.now(),
      onTimeChange: (time) {
        setState(() {
          _userTimeSchedule = time;
        });
      },
    );
  }

  Widget alertDialog(){

    return AlertDialog(
      title: const Text('Добавить предмет'),
      content: SingleChildScrollView(
        child: ListBody(
            children: <Widget>[
              TextField(onChanged: (value){
                _userSchedule = value;
              },
              ),

              DropdownButton<String>(
                value: _period,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),

                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _period = value!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              displayTimePicker(),
            ]
        ),
      ),
      actions: [

        ElevatedButton(onPressed: () {
          setState(() {
           // final scheduleDay = ScheduleDay(date: _selectedDay);
           // objectbox.scheduleDayBox.put(scheduleDay);

            objectbox.addEvent(_userTimeSchedule, _userSchedule, items.indexOf(_period), _selectedDay);
            //final event = Event(time: _userTimeSchedule, name: _userSchedule, period: items.indexOf(_period));
            //scheduleList.add(event);


            /*
            event.scheduleDay.target = scheduleDay;
            objectbox.eventBox.put(event);*/
          });
          Navigator.of(context).pop();
        }, child: const Text('Добавить'),)
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Уроки на ${dateFormat.format(_selectedDay)}' ),
        centerTitle: true,
      ),
      body: scheduleTable(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,

        onPressed: (){
          showDialog(context: context, builder: (context){
            return alertDialog();
          },);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
