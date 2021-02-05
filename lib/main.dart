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
              //make a second window for settings
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
                fontWeight: FontWeight.w400,
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
            builders: CalendarBuilders(
              dayBuilder: (context, date, _) {
                return Container(
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                );
              },
              weekendDayBuilder: (context, date, _) {
                return Container(
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: _mainColorTheme,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                );
              },
              todayDayBuilder: (context, date, _) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _bgColor,
                    border: Border.all(
                      color: _accentColor,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                );
              },
              //TODO: Fix inability to add more than 1 notes to a day.
              //TODO: Size of days circles without notes attached to them. Misalignment of text
              selectedDayBuilder: (context, date, _) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _mainColorTheme,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: _bgColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                );
              },
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];
                if (events.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
                if (holidays.isNotEmpty) {
                  children.add(
                    Positioned(
                      left: 1,
                      top: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
                return children;
              },
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

  void _addEvent(DateTime _dateTime) {
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
            if (_selectedDay == null) {
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

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? _accentColor
            : _calendarController.isToday(date)
                ? _mainColorTheme
                : _mainColorTheme,
      ),
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            color: _bgColor,
          ),
        ),
      ),
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
