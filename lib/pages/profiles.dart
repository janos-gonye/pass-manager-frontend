import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_manager_frontend/components/cards/profile.dart';
import 'package:pass_manager_frontend/components/forms/profile.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, String> _pageArgs;

  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfiles();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(_pageArgs["message"]),
              duration: Duration(seconds: 2),
            )));
  }

  void addProfile(Profile profile) {
    BlocProvider.of<ProfileCubit>(context).addProfile(profile);
  }

  @override
  Widget build(BuildContext context) {
    _pageArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Scrollbar(
                  child: SingleChildScrollView(
                      child: AlertDialog(
                    title: Text('Add new account'),
                    content: ProfileForm(callAfterSave: (Profile profile) {
                      addProfile(profile);
                    }),
                  )),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Your\nAccounts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey[800]),
              Expanded(
                child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                  String message = "";
                  if (state is ProfileError) {
                    message = state.message;
                  } else if (state is ProfileAdded) {
                    message = "Account successfully created.";
                  } else if (state is ProfileEdited) {
                    message = "Account successfully edited.";
                  } else if (state is ProfileDeleted) {
                    message = "Account successfully deleted.";
                  }
                  if (message.isNotEmpty)
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(message),
                      duration: Duration(seconds: 2),
                    ));
                }, builder: (BuildContext context, dynamic state) {
                  if (state is ProfileInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProfileInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProfileSuccess) {
                    return ListView.builder(
                        itemCount: state.profiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProfileCard(
                              profile: state.profiles[index],
                              deleteCallback: (Profile profile) {
                                BlocProvider.of<ProfileCubit>(context)
                                    .deleteProfile(profile);
                              });
                        });
                  } else {
                    return Center(
                        child: Column(children: [
                      SizedBox(height: 50),
                      Icon(Icons.error),
                      Text("Error occured, refresh"),
                      FlatButton(
                          child: Icon(Icons.refresh),
                          onPressed: () {
                            BlocProvider.of<ProfileCubit>(context)
                                .getProfiles();
                          })
                    ]));
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
