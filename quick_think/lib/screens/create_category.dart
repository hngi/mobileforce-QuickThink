// import 'package:flutter/material.dart';


// import 'package:quickthink/utils/responsiveness.dart';



// class CreateCategory extends StatefulWidget {
//   static const routeName = 'create_category';
//   @override
//   _CreateCategoryState createState() => _CreateCategoryState();
// }

// class _CreateCategoryState extends State<CreateCategory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.only(
//             left: SizeConfig().xMargin(context, 5.0),
//             right: SizeConfig().xMargin(context, 5.0),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 SizedBox(
//                   height: SizeConfig().yMargin(context, 10),
//                 ),
//                 _prompt(),
//                 _form(),
//                 _loginBtn(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _prompt() {
//     return Text(
//       'Create category',
//       style: TextStyle(
//         fontFamily: 'Poppins',
//         color: Colors.white,
//         fontWeight: FontWeight.w600,
//         fontSize: SizeConfig().textSize(context, 3.7),
//       ),
//     );
//   }

//   Widget _form() {
//     return Form(
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: SizeConfig().yMargin(context, 3.0),
//           ),
//           _promptCategory(),
//           SizedBox(
//             height: SizeConfig().yMargin(context, 1),
//           ),
//           _category(),
//           SizedBox(
//             height: SizeConfig().yMargin(context, 7),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _category() {
//     return TextFormField(
//       style: TextStyle(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w400,
//           fontSize: SizeConfig().textSize(context, 3),
//           color: Colors.white),
//       onChanged: (val) {},
//       validator: (val) {
//         // if (val.length == 0) {
//         //   return 'Username Should Not Be Empty';
//         // }
//         // if (val.length <= 2) {
//         //   return 'should be 3 or more characters';
//         // }
//         // if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(val)) {
//         //   return "can only include _ or -";
//         // }
//         // return null;
//       },
//       // onSaved: (val) => username.text = val,
//       decoration: InputDecoration(
//         hintText: 'Type category here',
//         hintStyle: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w400,
//             fontSize: SizeConfig().textSize(context, 2),
//             color: Colors.white),
//         contentPadding: EdgeInsets.fromLTRB(14.0, 12.0, 0.0, 12.0),
//         fillColor: Color.fromRGBO(87, 78, 118, 1),
//         filled: true,
//         focusedBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Color.fromRGBO(24, 197, 217, 1), width: 1.0),
//             borderRadius: BorderRadius.circular(5.0)),
//       ),
//     );
//   }

//   Widget _loginBtn() {
//     return RaisedButton(
//       padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
//       onPressed: () {
//         //onPressed();
//         Navigator.pushNamed(context, CreateQuestion.routeName);
//       },
//       textColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(5), topRight: Radius.circular(5)),
//       ),
//       color: Color.fromRGBO(24, 197, 217, 1),
//       highlightColor: Color.fromRGBO(24, 197, 217, 1),
//       child: Text('Save',
//           style: TextStyle(
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.w700,
//               fontSize: 16.0,
//               color: Colors.white)),
//     );
//   }

//   Widget _promptCategory() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Category',
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: SizeConfig().textSize(context, 2.2),
//           ),
//         ),
//       ],
//     );
//   }
// }
