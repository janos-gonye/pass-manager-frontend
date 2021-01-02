import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_manager_frontend/components/cards/profile.dart';
import 'package:pass_manager_frontend/components/forms/profile.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/services/profile.dart';

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
                    content: BlocProvider(
                        create: (context) => ProfileCubit(ProfileRepository()),
                        child: ProfileForm()),
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
                  if (state is ProfileError) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                }, builder: (BuildContext context, ProfileState state) {
                  if (state is ProfileInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoaded) {
                    return ListView.builder(
                        itemCount: state.profiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProfileCard(state.profiles[index]);
                        });
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
