import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2021, 12, 31): ['New Year\'s Day'],
};
Color _mainColorTheme = Colors.pink[900];
Color _accentColor = Colors.cyan[800];
Color _bgColor = Colors.grey[50];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: _mainColorTheme,
        accentColor: _accentColor,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController;
  List _selectedEvents;
  Map<DateTime, List> _events;
  String _note;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    _calendarController = CalendarController();
    _events = {
      DateTime(2021, 12, 31): [
        'Have fun - its NEW YEAR!!!',
      ],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _mainColorTheme,
        title: Text('Learning App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: _bgColor,
            onPressed: () {
              print('Setting clicked');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            events: _events,
            holidays: _holidays,
            initialCalendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: _mainColorTheme,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonDecoration: BoxDecoration(
                color: _bgColor,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset.fromDirection(20.0, 2.0),
                  ),
                ],
                border: Border.all(
                  color: _accentColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: _accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            calendarStyle: CalendarStyle(
              weekdayStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
              weekendStyle: TextStyle(
                color: _mainColorTheme,
                fontWeight: FontWeight.w600,
                fontSize: 17.0,
              ),
              todayColor: _accentColor.withOpacity(0.5),
              selectedColor: _mainColorTheme,
            ),
            calendarController: _calendarController,
            onDaySelected: _onDaySelected,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _mainColorTheme,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: _buildEventList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAlertDialog(context);
        },
        backgroundColor: _mainColorTheme,
      ),
    );
  }

  void _addEvent(DateTime _dateTime){
    _events.putIfAbsent(_dateTime, () => [_note]);
  }

  void _showAlertDialog(BuildContext context) {
    AlertDialog _alertDialog = AlertDialog(
      title: Text('Add a note'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Note',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: _mainColorTheme,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            onChanged: (value) {
              _note = value;
            },
            decoration: InputDecoration(
              hintText: 'Feed my cat',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            primary: _mainColorTheme,
            elevation: 3.0,
          ),
          onPressed: () {
            if(_selectedDay == null){
              _selectedDay = DateTime.now();
            }
            _addEvent(_selectedDay);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            'Add note',
            style: TextStyle(
              color: _bgColor,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => _alertDialog,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((e) => Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: _mainColorTheme,
                  width: 2.0,
                ),
              ),
              child: ListTile(
                  title: Text(
                e.toString(),
              ))))
          .toList(),
    );
  }
}
