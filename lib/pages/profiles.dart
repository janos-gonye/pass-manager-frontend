import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/components/buttons/logout.dart';
import 'package:pass_manager_frontend/components/forms/change_master_pass_form.dart';
import 'package:pass_manager_frontend/components/forms/profile.dart';
import 'package:pass_manager_frontend/components/lists/profile.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileList _profileList;
  Map<String, String> _pageArgs;

  void initState() {
    super.initState();
    _profileList = ProfileList(onDeleteProfile: (Profile profile) {
      removeProfile(profile);
    }, onEditProfile: (Profile profile) {
      editProfile(profile);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageArgs = ModalRoute.of(context).settings.arguments;
      if (_pageArgs != null && _pageArgs.containsKey("message"))
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(_pageArgs["message"]),
          duration: Duration(seconds: 2),
        ));
      BlocProvider.of<ProfileCubit>(context).getProfiles();
    });
  }

  void addProfile(Profile profile) {
    BlocProvider.of<ProfileCubit>(context).addProfile(profile);
  }

  void editProfile(Profile profile) {
    BlocProvider.of<ProfileCubit>(context).editProfile(profile);
  }

  void removeProfile(Profile profile) {
    BlocProvider.of<ProfileCubit>(context).deleteProfile(profile);
  }

  void reEncryptProfiles(String newMasterPass) {
    BlocProvider.of<ProfileCubit>(context).reEncryptProfiles(newMasterPass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: Stack(children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: LogoutButton(),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: FloatingActionButton(
                heroTag: null,
                child: Icon(FontAwesomeIcons.key),
                backgroundColor: Colors.grey[800],
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Scrollbar(
                            child: SingleChildScrollView(
                          child: AlertDialog(
                              title: Text('Change master password'),
                              content: ChangeMasterPassForm(
                                  changeCallback: (String newMasterPass) {
                                reEncryptProfiles(newMasterPass);
                              })),
                        ));
                      });
                },
              ),
            )),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: null,
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
        )
      ]),
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
              BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    String message = "";
                    if (state is ProfileError) {
                      message = state.message;
                    } else if (state is ProfileAdded) {
                      message = "Account successfully created.";
                      _profileList.addProfile(state.profile);
                    } else if (state is ProfileLoaded) {
                      _profileList.listProfiles(state.profiles);
                    } else if (state is ProfileEdited) {
                      message = "Account successfully edited.";
                      _profileList.editProfile(state.profile);
                    } else if (state is ProfileDeleted) {
                      message = "Account successfully deleted.";
                      _profileList.removeProfile(state.profile);
                    } else if (state is ProfileReEncrypted) {
                      message = "Accounts successfuly encrypted " +
                          "with the new master password.";
                    }
                    if (message.isNotEmpty)
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(message),
                        duration: Duration(seconds: 2),
                      ));
                  },
                  child: SizedBox(height: 0)),
              Expanded(child: _profileList),
              SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
