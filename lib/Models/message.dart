import 'package:flutter/material.dart';

@immutable
class Message {
  final String title;
  final String body;
  final String message;

  Message({
    @required this.title, 
    @required this.body,
    @required this.message
  });

  static map(Widget Function(Message notification) buildNotification) {}
}