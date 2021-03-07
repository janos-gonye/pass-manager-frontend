import 'package:flutter/material.dart';

class MasterPassForm extends StatefulWidget {
  final Function callAfterValdiation;
  MasterPassForm({@required this.callAfterValdiation, Key key})
      : super(key: key);

  @override
  _MasterPassFormState createState() => _MasterPassFormState();
}

class _MasterPassFormState extends State<MasterPassForm> {
  final _formKey = GlobalKey<FormState>();
  final _masterPassController = TextEditingController();
  bool _buttonEnabled = true;

  @override
  void dispose() {
    _masterPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Unlock your profiles',
              hintText: 'Your master password',
            ),
            controller: _masterPassController,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your master password';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text("Unlock"),
            onPressed: !_buttonEnabled
                ? null
                : () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => _buttonEnabled = false);
                      await widget
                          .callAfterValdiation(_masterPassController.text);
                      setState(() => _buttonEnabled = true);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
