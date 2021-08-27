import 'dart:io';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/weapons.dart';
import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/screens/Player/PlayerScreens/player_dashboard.dart';
import 'package:arcadia/screens/signin_screen.dart';
import 'package:arcadia/widgets/blue_box.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../signin_screen.dart';

class PlayerForm extends StatefulWidget {
  @override
  _PlayerFormState createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  var imageUrl;
  var uid = Auth.uid;
  var _image;
  var imagePicker;
  var type;
  final namecontroller = new TextEditingController();
  final studentIDcontroller = new TextEditingController();
  final iGNcontroller = new TextEditingController();
  final primaryWcontroller = new TextEditingController();
  final secondaryWcontroller = new TextEditingController();
  final streamURLcontroller = new TextEditingController();
  final gameHRScontroller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Compulsary!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please add a images!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    // PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      // image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      // var file = File(image.path);
      var image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      setState(() {
        _image = File(image!.path);
      });
      if (_image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('PlayerProfileImages/$uid/image')
            .putFile(_image);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        title: Text(
          "Player Details Form",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 24),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              // Container(
              //     margin: EdgeInsets.all(15),
              //     padding: EdgeInsets.all(15),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(15),
              //       ),
              //       border: Border.all(color: Colors.white),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black12,
              //           offset: Offset(2, 2),
              //           spreadRadius: 2,
              //           blurRadius: 1,
              //         ),
              //       ],
              //     ),
              //     child: (imageUrl != null)
              //         ? Image.network(imageUrl)
              //         : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              // SizedBox(
              //   height: 20.0,
              // ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await uploadImage();
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.red[200]),
                    child: _image != null
                        ? Image.file(
                            _image,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(color: Colors.red[200]),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          hintText: "Ex:- Mani",
                          labelText: "Your Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        cursorColor: CustomColors.primaryColor,
                        controller: studentIDcontroller,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: CustomColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Ex:-20195513",
                          labelText: "Student ID",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: iGNcontroller,
                        decoration: InputDecoration(
                          hintText: "Ex:- MadMani",
                          labelText: "IGN(In Game Name)",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: gameHRScontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Ex:-1520",
                          labelText: "Game Hours",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          } else if (value.length < 0) {
                            return "Gaming Hours can not be 0";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: primaryWcontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Ex:- AWP",
                          labelText: "Primary Weapons",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: secondaryWcontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Ex:- Deagle",
                          labelText: "Secondary Weapons",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      TextFormField(
                        controller: streamURLcontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              "https://steamcommunity.com/profiles/76561199007256891/",
                          labelText: "Steam URL",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (imageUrl == null) {
                              _showMyDialog();
                            } else {
                              Provider.of<Players>(context, listen: false)
                                  .addplayerSetup(Player(
                                      studentID: studentIDcontroller.text,
                                      inGameName: iGNcontroller.text,
                                      name: namecontroller.text,
                                      primaryWeapon: Weapons.values.firstWhere(
                                        (e) =>
                                            e.toString() ==
                                            'Weapons.' +
                                                primaryWcontroller.text
                                                    .toUpperCase(),
                                      ),
                                      secondaryWeapon:
                                          Weapons.values.firstWhere(
                                        (e) =>
                                            e.toString() ==
                                            'Weapons.' +
                                                secondaryWcontroller.text
                                                    .toUpperCase(),
                                      ),
                                      hoursPlayed:
                                          int.parse(gameHRScontroller.text),
                                      steamUrl: streamURLcontroller.text));
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlayerDashBoard()));
                              }
                            }
                          },
                          child: blueButton(
                              context: context,
                              label: "Apply",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2)),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await Provider.of<Auth>(context, listen: false)
                              .signOut();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return SignInScreen();
                          }), (route) => false);
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}