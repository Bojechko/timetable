import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:example_project_mobile/objectbox.g.dart';
import 'package:intl/intl.dart';

import '../models/model.dart';


var onlyDate = DateFormat('dd-MM-yyyy');

class ObjectBox {

  late final Store store;
  late final Box<Event> eventBox;

  ObjectBox._create(this.store) {
    eventBox = Box<Event>(store);
  //  scheduleDayBox = Box<ScheduleDay>(store);

    if(eventBox.isEmpty()){
      _putDemoData();
    }
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }

  void _putDemoData() {
  //  ScheduleDay scheduleDay1 = ScheduleDay(date: DateTime.now());
    Event event1 = Event(time: DateTime.now(), name: "Flutter", period: 1, day: onlyDate.format(DateTime.now()));

    eventBox.put(event1);

   // scheduleDay1.events.add(event1);

    //scheduleDayBox.put(scheduleDay1);
  }

  void addEvent(DateTime time, String name, int period, DateTime date){
    Event newEvent = Event(time: time, name: name, period: period, day: onlyDate.format(date));

  //  scheduleDay.events.add(newEvent);
   // newEvent.scheduleDay.target = scheduleDay;

    eventBox.put(newEvent);

    debugPrint(
      "Added event: ${newEvent.name} assigned to ${newEvent.day}"
    );

  }


  Stream<List<Event>> getAllDateEvents(DateTime currentDate){
    final builder = eventBox.query(Event_.day.equals(onlyDate.format(currentDate)))
        ..order((Event_.id), flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

 

  Stream<List<Event>> getEvents(){
    final builder = eventBox.query()..order((Event_.time), flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }


}