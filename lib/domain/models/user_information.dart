import 'package:http/io_client.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

class UserInformation {
  final Icon icon;
  final String description;

  const UserInformation({required this.icon, required this.description});
}
