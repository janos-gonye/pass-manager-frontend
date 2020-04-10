import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (context) => HomePage(),
  },
));
