// import 'package:flutter/material.dart';

// class Mynoticationscreen extends StatefulWidget {
//   const Mynoticationscreen({super.key});

//   @override
//   State<Mynoticationscreen> createState() => _MynoticationscreenState();
// }

// class _MynoticationscreenState extends State<Mynoticationscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 15, 0, 8),
//               Color(0xff281537),
//             ]),
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           'NOTIFICATIONS',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(color: Colors.white, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 tileColor: Colors.brown[100],
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage('assets/raman1.jpg'),
//                   radius: 20,
//                 ),
//                 trailing: Text("12:30"),
//                 title: Text('abhay'),
//                 subtitle: Text('daa'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(color: Colors.black, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 tileColor: Colors.blueGrey,
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 20,
//                 ),
//                 trailing: Text("11:45"),
//                 title: Text('Adhil'),
//                 subtitle: Text('Hi'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(color: Colors.white, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 tileColor: Colors.blueGrey[100],
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 20,
//                 ),
//                 trailing: Text("1:55"),
//                 title: Text('ansaf'),
//                 subtitle: Text('hello'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(color: Colors.white, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 tileColor: Colors.blueGrey[100],
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 20,
//                 ),
//                 trailing: Text("4:45"),
//                 title: Text('anu'),
//                 subtitle: Text('is it available? '),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(color: Colors.white, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 tileColor: Colors.brown[100],
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 20,
//                 ),
//                 trailing: Text("3:45"),
//                 title: Text('nazi'),
//                 subtitle: Text('still?'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
