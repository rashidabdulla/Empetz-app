// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:empetzapp/login.dart';

// class MyRegisterScreen extends StatefulWidget {
//   const MyRegisterScreen({super.key});

//   @override
//   State<MyRegisterScreen> createState() => _MyRegisterScreenState();
// }

// class _MyRegisterScreenState extends State<MyRegisterScreen> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();

//   String? nameError;
//   String? usernameError;
//   String? phoneNumberError;
//   String? emailError;
//   String? passwordError;
//   bool isChecked = false;

//   Future<void> sendData() async {
//     final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/user/registration');
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "firstName": nameController.text.trim(),
//           "userName": usernameController.text.trim(),
//           "phone": phoneNumberController.text.trim(),
//           "email": emailController.text.trim(),
//           "password": passwordController.text.trim()
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Myloginscreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to register: ${response.body}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   String? validateEmail(String? value) {
//     const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//     final regex = RegExp(pattern);
//     return value != null && !regex.hasMatch(value)
//         ? 'Enter a valid email address'
//         : null;
//   }

//   String? validatePhoneNumber(String phoneNumber) {
//     if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
//       return 'Phone number must be exactly 10 digits';
//     }
//     return null;
//   }

//   String? validatePassword(String password) {
//     if (password.length < 6) return 'Password must be at least 6 characters long';
//     if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Password must contain at least one uppercase letter';
//     if (!RegExp(r'[0-9]').hasMatch(password)) return 'Password must contain at least one number';
//     return null;
//   }

//   String? validateUsername(String username) {
//     if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(username)) {
//       return 'Username must not contain special characters or numbers';
//     }
//     if (username.trim().isEmpty) return 'Username cannot be empty';
//     return null;
//   }

//   String? validateName(String name) {
//     if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name)) {
//       return 'Name must not contain special characters or numbers';
//     }
//     if (name.trim().isEmpty) return 'Name cannot be empty';
//     return null;
//   }

//   void onRegisterPressed() {
//     setState(() {
//       nameError = validateName(nameController.text);
//       usernameError = validateUsername(usernameController.text);
//       phoneNumberError = validatePhoneNumber(phoneNumberController.text);
//       emailError = validateEmail(emailController.text);
//       passwordError = validatePassword(passwordController.text);
//     });

//     if (nameError == null &&
//         usernameError == null &&
//         phoneNumberError == null &&
//         emailError == null &&
//         passwordError == null) {
//       sendData();
//     }
//   }

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
//         title: const Text('EMPETZ',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 15, 0, 8),
//               Color(0xff281537),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               const Text('Create an account',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
//               const SizedBox(height: 30),

//               _buildTextField(
//                 controller: nameController,
//                 label: 'First Name',
//                 errorText: nameError,
//                 onChanged: (val) => setState(() => nameError = validateName(val)),
//               ),
//               const SizedBox(height: 20),

//               _buildTextField(
//                 controller: usernameController,
//                 label: 'Username',
//                 errorText: usernameError,
//                 onChanged: (val) => setState(() => usernameError = validateUsername(val)),
//               ),
//               const SizedBox(height: 20),

//               _buildTextField(
//                 controller: phoneNumberController,
//                 label: 'Phone Number',
//                 errorText: phoneNumberError,
//                 keyboardType: TextInputType.number,
//                 maxLength: 10,
//                 onChanged: (val) => setState(() => phoneNumberError = validatePhoneNumber(val)),
//               ),
//               const SizedBox(height: 20),

//               _buildTextField(
//                 controller: emailController,
//                 label: 'Email',
//                 errorText: emailError,
//                 onChanged: (val) => setState(() => emailError = validateEmail(val)),
//               ),
//               const SizedBox(height: 20),

//               _buildTextField(
//                 controller: passwordController,
//                 label: 'Password',
//                 errorText: passwordError,
//                 obscureText: true,
//                 onChanged: (val) => setState(() => passwordError = validatePassword(val)),
//               ),
//               const SizedBox(height: 30),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Keep me signed in', style: TextStyle(color: Colors.white)),
//                   Checkbox(
//                     value: isChecked,
//                     onChanged: (value) => setState(() => isChecked = value ?? false),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               ElevatedButton(
//                 onPressed: onRegisterPressed,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 ),
//                 child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 16)),
//               ),
//               const SizedBox(height: 20),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Already have an account?', style: TextStyle(color: Colors.white)),
//                   const SizedBox(width: 4),
//                   TextButton(
//                     onPressed: () => Navigator.pushReplacement(
//                         context, MaterialPageRoute(builder: (context) => const Myloginscreen())),
//                     child: const Text('Sign in', style: TextStyle(color: Colors.red)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     String? errorText,
//     Function(String)? onChanged,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     int? maxLength,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         maxLength: maxLength,
//         style: const TextStyle(color: Colors.white),
//         cursorColor: Colors.white,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.white),
//           errorText: errorText,
//           counterText: '',
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.red),
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//         ),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:empetzapp/login.dart';

class MyRegisterScreen extends StatefulWidget {
  const MyRegisterScreen({super.key});

  @override
  State<MyRegisterScreen> createState() => _MyRegisterScreenState();
}

class _MyRegisterScreenState extends State<MyRegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? nameError;
  String? usernameError;
  String? phoneNumberError;
  String? emailError;
  String? passwordError;
  bool isChecked = false;

  Future<void> sendData() async {
    final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/user/registration');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "firstName": nameController.text.trim(),
          "userName": usernameController.text.trim(),
          "phone": phoneNumberController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim()
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Myloginscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  String? validateEmail(String? value) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return value != null && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePhoneNumber(String phoneNumber) {
    if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
      return 'Phone number must be exactly 10 digits';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 6) return 'Password must be at least 6 characters long';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Password must contain at least one uppercase letter';
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Password must contain at least one number';
    return null;
  }

  String? validateUsername(String username) {
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(username)) {
      return 'Username must not contain special characters or numbers';
    }
    if (username.trim().isEmpty) return 'Username cannot be empty';
    return null;
  }

  String? validateName(String name) {
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name)) {
      return 'Name must not contain special characters or numbers';
    }
    if (name.trim().isEmpty) return 'Name cannot be empty';
    return null;
  }

  void onRegisterPressed() {
    setState(() {
      nameError = validateName(nameController.text);
      usernameError = validateUsername(usernameController.text);
      phoneNumberError = validatePhoneNumber(phoneNumberController.text);
      emailError = validateEmail(emailController.text);
      passwordError = validatePassword(passwordController.text);
    });

    if (nameError == null &&
        usernameError == null &&
        phoneNumberError == null &&
        emailError == null &&
        passwordError == null) {
      sendData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'EMPETZ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Create an account',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 30),

            _buildTextField(
              controller: nameController,
              label: 'First Name',
              errorText: nameError,
              onChanged: (val) => setState(() => nameError = validateName(val)),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              controller: usernameController,
              label: 'Username',
              errorText: usernameError,
              onChanged: (val) => setState(() => usernameError = validateUsername(val)),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              controller: phoneNumberController,
              label: 'Phone Number',
              errorText: phoneNumberError,
              keyboardType: TextInputType.number,
              maxLength: 10,
              onChanged: (val) => setState(() => phoneNumberError = validatePhoneNumber(val)),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              controller: emailController,
              label: 'Email',
              errorText: emailError,
              onChanged: (val) => setState(() => emailError = validateEmail(val)),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              controller: passwordController,
              label: 'Password',
              errorText: passwordError,
              obscureText: true,
              onChanged: (val) => setState(() => passwordError = validatePassword(val)),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Keep me signed in', style: TextStyle(color: Colors.black)),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) => setState(() => isChecked = value ?? false),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: onRegisterPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?', style: TextStyle(color: Colors.black)),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const Myloginscreen())),
                  child: const Text('Sign in', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? errorText,
    Function(String)? onChanged,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          errorText: errorText,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
