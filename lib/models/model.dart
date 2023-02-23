import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';

var onlyDate = DateFormat('dd-MM-yyyy');
@Entity()
class Event {
  @Id()
  int id;

  @Property(type: PropertyType.date)
  DateTime time;
  String name;
  int period;
  String day;

  Event({
    this.id =0,
    required this.time,
    required this.name,
    required this.period,
    required this.day,

  });

}
