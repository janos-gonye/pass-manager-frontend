import 'package:flutter/material.dart';

class ProfilesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.grey[800],
      ),
      body: Center(child: Text("Profiles page")),
    );
  }
}
