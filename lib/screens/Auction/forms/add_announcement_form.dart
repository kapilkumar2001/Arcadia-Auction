import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/announcement.dart';
import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/screens/Auction/auction_overview.dart';
import 'package:arcadia/widgets/blue_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAnnouncementForm extends StatefulWidget {
  const AddAnnouncementForm({Key? key}) : super(key: key);

  @override
  _AddAnnouncementFormState createState() => _AddAnnouncementFormState();
}

class _AddAnnouncementFormState extends State<AddAnnouncementForm> {
  final titleController = new TextEditingController();
  final subtitleController = new TextEditingController();
  final descriptionController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Announcement",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 24),
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height,
          color: CustomColors.primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: CustomColors.secondaryColor,
                        controller: titleController,
                        autocorrect: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: CustomColors.secondaryColor,
                        ),
                        decoration: InputDecoration(
                          // focusColor: CustomColors.firebaseGrey,
                          // hoverColor: CustomColors.firebaseGrey,
                          hintText: "Ex: Match Recheduling",
                          labelText: "Title",
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
                        cursorColor: CustomColors.secondaryColor,
                        controller: subtitleController,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: CustomColors.secondaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Ex: Match 5 is Rescheduled",
                          labelText: "Subtitle",
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
                        cursorColor: CustomColors.secondaryColor,
                        controller: descriptionController,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: CustomColors.secondaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Description",
                          labelText: "Description",
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
                            int id = Provider.of<Announcements>(context,
                                    listen: false)
                                .announcement
                                .length;
                            Provider.of<Announcements>(context, listen: false)
                                .addAnncoument(
                              Announcement(
                                  title: titleController.text,
                                  subtitle: subtitleController.text,
                                  desc: descriptionController.text,
                                  createddateTime: DateTime.now(),
                                  id: id.toString()),
                            );
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminMainPage()));
                            }
                          },
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
                          )),
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
