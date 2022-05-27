import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/task_model.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key key}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController _titleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const int max_hours = 24;
  static const int max_minutes = 60;
  static const int max_seconds = 60;
  static const int _maxTitleLength = 30;

  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;

  Color getRandomColor() {
    Random r = Random();
    var colorsList = Colors.primaries;

    return colorsList.elementAt(r.nextInt(colorsList.length -1));
  }

 void _saveTaskAndClose() {
    String title = _titleController.text;

    if (_formKey.currentState.validate() != false) {
      var color = getRandomColor();
      var task =  Task(
        color: color,
        title: title,
        hours: _selectedHour,
        minutes: _selectedMinute,
        seconds: _selectedSecond
      );

      Navigator.of(context).pop(task);
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child:  TextFormField(
                  maxLength: _maxTitleLength,
                  maxLengthEnforced: true,
                  controller: _titleController,
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                  validator: (String val) {
                    if (val.trim().isEmpty) return 'Task title is required.';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                      counterText: _maxTitleLength.toString(),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8,left: 4),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Duration',
                      maxLines: 1, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            key: const ObjectKey('hours'),
                            height: 110,
                            child: _Selector<int>(
                              items: List.generate(max_hours, (i) => i),
                              itemBuilder: (i) => '$i hours',
                              onSelectedItemChanged: (index) {
                                _selectedHour = (index as int);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            key: const ObjectKey('minutes'),
                            height: 110,
                            child: _Selector<int>(
                              items: List.generate(max_minutes, (i) => i),
                              itemBuilder: (i) => "$i min",
                              onSelectedItemChanged: (index) {
                                _selectedMinute = (index as int);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            key: const ObjectKey('seconds'),
                            height: 110,
                            child: _Selector<int>(
                              items: List.generate(max_seconds, (i) => i),
                              itemBuilder: (i) => "$i sec",
                              onSelectedItemChanged: (index) {
                                _selectedSecond = (index as int);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: _saveTaskAndClose,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 50,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Save'.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Selector<T> extends StatefulWidget {
  final List<T> items;
  final String Function(dynamic) itemBuilder;
  final Function(dynamic) onSelectedItemChanged;

  const _Selector({
    Key key,
    @required this.items,
    @required this.itemBuilder,
    @required this.onSelectedItemChanged,
  })  : assert(itemBuilder != null),
        assert(items != null),
        assert(onSelectedItemChanged != null),
        super(key: key);

  @override
  _SelectorState<T> createState() => _SelectorState<T>();
}

class _SelectorState<T> extends State<_Selector> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      itemExtent: 60,
      childCount: widget.items.length,
      backgroundColor: Colors.transparent,
      itemBuilder: (context, index) {
        bool isSelected = (_currentIndex == index);
        final item = widget.items.elementAt(index);

        return Center(
          child: Text(
            widget.itemBuilder(item),
            style: TextStyle(
                fontSize: 14,
                color: isSelected ?  Theme.of(context).colorScheme.secondary : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        );
      },
      onSelectedItemChanged: (i) {
        setState(() {
          _currentIndex = i;
          widget.onSelectedItemChanged( widget.items.elementAt(i));
        });
      },
    );
  }
}
