import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/pages/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (context) => LoginPage(),
  },
));
