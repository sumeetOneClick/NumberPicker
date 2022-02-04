import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'String'),
            ],
          ),
          title: Text('String picker example'),
        ),
        body: TabBarView(
          children: [
            _IntegerExample(),
          ],
        ),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _index = 0;
  List<String> _values = ['AM', 'PM', 'CM'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Default', style: Theme.of(context).textTheme.headline6),
        StringPicker(
          value: _index,
          values: _values,
          haptics: true,
          onChanged: (value) => setState(() => _index = _values.indexOf(value)),
        ),
        SizedBox(height: 32),
        Divider(color: Colors.grey, height: 32),
        SizedBox(height: 16),
        Text('Horizontal', style: Theme.of(context).textTheme.headline6),
        StringPicker(
          value: _index,
          values: _values,
          itemHeight: 100,
          axis: Axis.horizontal,
          onChanged: (value) => setState(() => _index = _values.indexOf(value)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
