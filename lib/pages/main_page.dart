
import 'package:example_project_mobile/controllers/main_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainPageController c = Get.put(MainPageController());

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;

    // Можно и здесь:
    // c.load();
  }

  void _onDaySelected (selectedDay, focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

      });

    }
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      c.load();
    }
  }

  Widget content(){
    return Column(
      children: [
        Container(
          child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 10, 16),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: content(),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,

        onPressed: (){
          Navigator.pushNamed(context, '/schedule', arguments: _selectedDay);
        },
        child: const Icon(
          Icons.biotech,
          color: Colors.white,
        ),
      ),

    );
  }
}
