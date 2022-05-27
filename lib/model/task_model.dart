import 'package:flutter/material.dart';

class Task{
   int id;
   Color color;
   String title;
   int hours, minutes, seconds;

  Task({
    this.id = 0,
    this.color,
    this.title,
    this.hours,
    this.minutes,
    this.seconds
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
      id: json['id'],
      color: Color(json['color']),
      title: json['title'],
      hours: json['hours'],
      minutes: json['minutes'],
      seconds: json['seconds']
  );
}