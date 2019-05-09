import 'package:flutter/material.dart';
import 'package:josa/josa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Josa Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Josa Demo'),
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
  String _str = '';
  JosaType _type = JosaType.type1;
  Josa _josa = Josa(JosaGroup.of(JosaType.type1), true);

  DropdownButton _buildJosaDropdownButton() {
    return DropdownButton<JosaType>(
      items: JosaType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(
            JosaGroup.of(type).toString(),
          ),
        );
      }).toList(),
      onChanged: (type) {
        setState(() {
          _type = type;
          _josa = Josa(JosaGroup.of(type), true);
        });
      },
      value: _type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                setState(() {
                  _str = text;
                });
              },
            ),
            Text(
              _josa.of(_str),
            ),
            _buildJosaDropdownButton(),
          ],
        ),
      ),
    );
  }
}
