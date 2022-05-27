import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/task_model.dart';
import '../screens/timer_page.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({Key key, this.task}) : super(key: key);

  final Task task;
  final BorderRadius _borderRadius = BorderRadius.circular(8.0);

  /// When called start timer Screen
  void _startTimerPage(BuildContext context, Task task) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (_) => TimerPage(task: task),
      ),
    );
  }

  String _formatDuration() {
    return '${task.hours.toString().padLeft(2, '0')}:'
        '${task.minutes.toString().padLeft(2, '0')}:'
        '${task.seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () => _startTimerPage(context, task),
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 26, bottom: 26, right: 8),
          child: Row(
            children: <Widget>[

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12.0),
                        width: 15.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                            color: task.color,
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                      Text(
                        task.title.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Duration: ${_formatDuration()}',
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.navigate_next,
                color: task.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
