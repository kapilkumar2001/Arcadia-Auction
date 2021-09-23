import 'dart:io';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/weapons.dart';
import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/screens/Player/PlayerScreens/player_dashboard.dart';
import 'package:arcadia/screens/onboarding/signin_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


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

  Weapons? primaryWeapons = Weapons.AWP;
  Weapons? secondadryWeapons = Weapons.USP;

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
          color: CustomColors.primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
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
              SizedBox(
                height: 40,
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
                          hintText: "Enter Your Name",
                          labelText: "Your Name",
                          filled: true,
                          fillColor: CustomColors.firebaseGrey,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
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
                          filled: true,
                          fillColor: CustomColors.firebaseGrey,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
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
                          filled: true,
                          fillColor: CustomColors.firebaseGrey,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
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
                        keyboardType: TextInputType.numberWithOptions(),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Ex:-1520",
                          labelText: "Game Hours",
                          filled: true,
                          fillColor: CustomColors.firebaseGrey,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Primary Weapon:",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(width: 20,),
                          DropdownButton<Weapons>(
                            // menuMaxHeight: MediaQuery.of(context).size.height,
                            iconEnabledColor: Colors.blueAccent,
                            iconDisabledColor: Colors.blueAccent,

                            underline: Container(
                                // child: Text("Primary Weapons"),
                                color: Colors.transparent),
                            value: primaryWeapons,
                            items: Weapons.values.map((Weapons value) {
                              return DropdownMenuItem<Weapons>(
                                value: value,
                                child: Text(
                                  value.toString().split('.').last,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blueAccent),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                // print('value is : $value');
                                primaryWeapons = value!;
                              });
                            },
                            // hint: Text(_playerStatus.toString().split('.').last),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Secondary Weapon:",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<Weapons>(
                            iconEnabledColor: Colors.blueAccent,
                            iconDisabledColor: Colors.blueAccent,
                            underline: Container(color: Colors.transparent),
                            value: secondadryWeapons,
                            // menuMaxHeight:
                            //     MediaQuery.of(context).size.height / 2,
                            items: Weapons.values.map((Weapons value) {
                              return DropdownMenuItem<Weapons>(
                                value: value,
                                child: Text(
                                  value.toString().split('.').last,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blueAccent),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                // print('value is : $value');
                                secondadryWeapons = value!;
                              });
                            },
                            // hint: Text(_playerStatus.toString().split('.').last),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: streamURLcontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              "https://steamcommunity.com/profiles/76561199007256891/",
                          labelText: "Steam URL",
                          filled: true,
                          fillColor: CustomColors.firebaseGrey,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
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
                                            // 'Weapons.' +
                                            primaryWeapons.toString(),
                                      ),
                                      secondaryWeapon:
                                          Weapons.values.firstWhere(
                                        (e) =>
                                            e.toString() ==
                                            // 'Weapons.' +
                                            secondadryWeapons.toString(),
                                      ),
                                      hoursPlayed:
                                          int.parse(gameHRScontroller.text),
                                      steamUrl: streamURLcontroller.text));
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PlayerDashBoard();
                                }), (route) => false);
                              }
                            }
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      SizedBox(height: 20),
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
