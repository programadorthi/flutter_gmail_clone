import 'package:flutter/painting.dart';

class MailModel {
  final String firstLetter;
  final Color color;

  const MailModel({
    this.firstLetter,
    this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailModel &&
          runtimeType == other.runtimeType &&
          firstLetter == other.firstLetter &&
          color == other.color;

  @override
  int get hashCode => firstLetter.hashCode ^ color.hashCode;
}
