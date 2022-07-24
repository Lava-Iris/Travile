import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travile/models/profile.dart';
import 'package:travile/models/user.dart';
import 'package:travile/services/following_database.dart';
import 'package:travile/services/profiles_database.dart';

class ProfileHeader extends StatefulWidget {
  final MyUser? user;
  final MyUser? accessingUser;
  const ProfileHeader({Key? key, required this.user, required this.accessingUser}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();



  Column buildCountColumn(String label, int count) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 22.0, 
            fontWeight: FontWeight.bold, 
            color: Colors.white),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Profile>.value(
        value: ProfilesDatabaseService().profile(widget.user!.uid),
        initialData: Profile(uid: "ABC", username: 'd', ),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: buildHeader(context),
            );
        }
      );
  }

  Widget buildHeader(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return Container (
      height: MediaQuery.of(context).size.height*0.25, 
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: [
                  Stack(children: [
                    CircleAvatar(
                    radius: 40.0,
                    backgroundImage: _imageFile == null
                        ? const AssetImage(
                                'lib/shared/logo.png')
                            as ImageProvider
                        : FileImage(File(_imageFile!.path)),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.teal,
                        size: 20.0,
                      ),
                    ),
                  ),
                  ],),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      profile.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, 
                        fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30,),
                    Column(
                      children:[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCountColumn("Posts", profile.posts),
                            buildCountColumn("Followers", profile.followers),
                            buildCountColumn("Following", profile.following)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(profile.bio,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400)
                        ),
                      ],
                    )
                    
                  ],
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
  
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ]),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }
}