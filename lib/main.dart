import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await locaiton service to be enabled
  await Permission.locationWhenInUse.serviceStatus.isEnabled;
  runApp(const ProviderScope(child: App()));
}
