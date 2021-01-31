import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Misha is gay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _ratio;
  int pp;
  double height;
  void _changeHeight(double h){
      height = h;
  }
  void _changePP(int p){
      pp = p;
  }
  void _calcRatio() {
    setState(() {
      _ratio =  100 * pp / height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[TextField(
              onChanged: (pp){
                _changePP(int.parse(pp));
              },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.tealAccent[400],
            ),
              decoration: InputDecoration(
                border: InputBorder.none,
                  labelText: 'Your gorgeous cock(cm)',
                    hintText: '4',
                    hintStyle: TextStyle(
                      color: Colors.amberAccent[400]
                  )
              ),
            ),
            SizedBox(height: 20, width: 20),
            TextField(
              onChanged: (height){
                _changeHeight(double.parse(height));
                _calcRatio();
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.tealAccent[400],
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                labelText: 'Your marvelous height(cm)',
                  hintText: '168',
                  hintStyle: TextStyle(
                      color: Colors.amberAccent[400]
                  )
              ),
            ),
            SizedBox(height: 60, width: 120),
            Text(
              'Your height to cock ratio is',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.redAccent[700],
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$_ratio %',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Colors.redAccent[700],
              ),
            ),
            SizedBox(height: 50),
            Image.asset('assets/images/floppa.jpeg'),
          ],
        ),
      ),
    );
  }
}
