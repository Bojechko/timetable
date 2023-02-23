
import 'package:example_project_mobile/pages/main_page.dart';
import 'package:flutter/material.dart';

class NavRail extends StatefulWidget {
  const NavRail({super.key});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Row(
          children: <Widget>[
          NavigationRail(

            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;

              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_today),
                  selectedIcon: Icon(Icons.calendar_month),
                  label: Text('Расписание'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  selectedIcon: Icon(Icons.add_box),
                  label: Text('Добавить'),


                ),

              ],
            ),
            Expanded(child: buildPages()),
          ],
        ),

    );

    }
   Widget buildPages(){
      switch (_selectedIndex){
        case 0:
          return MainPage();
        //case 1:
         // return AddLesson();
        default:
          return const MainPage();}

    }
}
