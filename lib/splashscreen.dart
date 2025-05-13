// import 'dart:async';
// import 'package:empetzapp/login.dart';
// import 'package:flutter/material.dart';

// class Mysplashscreen extends StatefulWidget {
//   const Mysplashscreen({super.key});

//   @override
//   State<Mysplashscreen> createState() => _MysplashscreenState();
// }

// class _MysplashscreenState extends State<Mysplashscreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Myloginscreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent, // Important for gradient to show
//       body: Container(
//         decoration: const BoxDecoration(
//            gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 15, 0, 8),
//               Color(0xff281537),
//             ]),
//         ),
//         child: const Center(
//           child: Text(
//             'Empetz',
//             style: TextStyle(
//               fontSize: 48.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:empetzapp/login.dart';
import 'package:flutter/material.dart';

class Mysplashscreen extends StatefulWidget {
  const Mysplashscreen({super.key});

  @override
  State<Mysplashscreen> createState() => _MysplashscreenState();
}

class _MysplashscreenState extends State<Mysplashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Myloginscreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Empetz',
          style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
