import 'dart:io';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/admin_dashboard.dart';
import 'package:arcadia/screens/Auction/auction_overview.dart';
import 'package:arcadia/widgets/blue_box.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddTeamForm extends StatefulWidget {
  const AddTeamForm({Key? key}) : super(key: key);

  @override
  _AddTeamFormState createState() => _AddTeamFormState();
}

class _AddTeamFormState extends State<AddTeamForm> {
  final teamNameController = new TextEditingController();
  final teamAbbreviationController = new TextEditingController();
  final teamOwnerNameController = new TextEditingController();
  final creditController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var imageUrl;
  var _image;
  var imagePicker;
  var type;

  uploadImage(String teamId) async {
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
            .child('TeamLogos/$teamId/image')
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please add a image!'),
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

  @override
  Widget build(BuildContext context) {
    int id = Provider.of<Teams>(context, listen: false).teams.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Team",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 24),
          alignment: Alignment.topCenter,
          //  height: MediaQuery.of(context).size.height,
          color: CustomColors.primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await uploadImage(id.toString());
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: teamNameController,
                        decoration: InputDecoration(
                          hintText: "Ex: Chennai Super Kings",
                          labelText: "Team Name",
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
                        controller: teamAbbreviationController,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: CustomColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Ex: CSK",
                          labelText: "Team Abbreviation",
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
                        controller: teamOwnerNameController,
                        decoration: InputDecoration(
                          hintText: "Ex: Kapil Kumar",
                          labelText: "Owner Name",
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
                        controller: creditController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: "Ex: 200",
                          labelText: "Team Credits",
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
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Save",
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
                        ),
                        onTap: () {
                          List<String> playerUid = [];
                          List<String> completedMatches = [];
                          List<String> upcomingMatches = [];

                          if (imageUrl == null) {
                            _showMyDialog();
                          } else {
                            Provider.of<Teams>(context, listen: false).addTeam(
                              Team(
                                  teamUid: id.toString(),
                                  ownerName: teamOwnerNameController.text,
                                  teamName: teamNameController.text,
                                  credits: int.parse(creditController.text),
                                  matchesDraw: 0,
                                  matchesLost: 0,
                                  matchesWon: 0,
                                  numPlayer: 0,
                                  points: 0,
                                  playerUid: playerUid,
                                  teamAbbreviation:
                                      teamAbbreviationController.text,
                                  completeMatches: completedMatches,
                                  upcomingMatches: upcomingMatches,
                                  roundDifference: 0),
                            );
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminMainPage()));
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 60.0,
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
