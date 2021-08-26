// import 'package:arcadia/constants/app_theme.dart';
// import 'package:arcadia/provider/team.dart';
// import 'package:arcadia/provider/teams.dart';
// import 'package:arcadia/widgets/blue_box.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AddTeamForm extends StatefulWidget {
//   const AddTeamForm({Key? key}) : super(key: key);

//   @override
//   _AddTeamFormState createState() => _AddTeamFormState();
// }

// class _AddTeamFormState extends State<AddTeamForm> {
//   final teamNameController = new TextEditingController();
//   final teamAbbreviationController = new TextEditingController();
//   final teamOwnerNameController = new TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Add Team",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(top: 24),
//           alignment: Alignment.topCenter,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.white,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 12,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 16.0, horizontal: 32.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: teamNameController,
//                         decoration: InputDecoration(
//                           hintText: "Ex: Chennai Super Kings",
//                           labelText: "Team Name",
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Cannot be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 40.0,
//                       ),
//                       TextFormField(
//                         cursorColor: CustomColors.primaryColor,
//                         controller: teamAbbreviationController,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                           color: CustomColors.primaryColor,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Ex: CSK",
//                           labelText: "Team Abbreviation",
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Cannot be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 40.0,
//                       ),
//                       TextFormField(
//                         controller: teamOwnerNameController,
//                         decoration: InputDecoration(
//                           hintText: "Ex: Kapil Kumar",
//                           labelText: "Owner Name",
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Cannot be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 60.0,
//                       ),
//                       GestureDetector(
//                         child: blueButton(
//                             context: context,
//                             label: "Save",
//                             buttonWidth: MediaQuery.of(context).size.width / 2),
//                         onTap: () {
//                           int id =
//                               Provider.of<Teams>(context, listen: false)
//                                   .teams
//                                   .length;
//                           Provider.of<Teams>(context, listen: false)
//                               .addTeam(
//                             Team(
//                               teamUid: id.toString(),
//                               ownerName: teamOwnerNameController.text,
//                               teamName: teamNameController.text,

//                             ),
//                           );
//                           if (_formKey.currentState!.validate()) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AdminDashboard()));
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
