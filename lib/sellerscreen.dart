// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:empetzapp/homescreen.dart';

// class Mysellerscreen extends StatefulWidget {
//   const Mysellerscreen({super.key});

//   @override
//   State<Mysellerscreen> createState() => _SellersState();
// }

// class _SellersState extends State<Mysellerscreen> {
//   List<dynamic> categories = [];
//   List<dynamic> breed = [];
//   List<dynamic> locations = [];

//   String? selectedCategory;
//   String? selectedBreed;
//   String? selectedAge;
//   String? selectedGender;
//   String? selectedLocation;

//   bool isVaccinated = false;
//   bool hasCertificate = false;
//   bool isAdoption = false;
//   bool isVisible = true;

//   XFile? file;
//   final ImagePicker _picker = ImagePicker();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController nicknameController = TextEditingController();
//   final TextEditingController heightController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController petDescriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//     fetchLocations();
//   }

//   Future<void> fetchCategories() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/category');
//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         categories = data;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to load categories')),
//       );
//     }
//   }

//   Future<void> fetchBreeds(String categoryId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/breed/category/$categoryId');
//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         breed = data;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to load breeds')),
//       );
//     }
//   }

//   Future<void> fetchLocations() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/location');
//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         locations = data;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to load locations')),
//       );
//     }
//   }

//   Future<void> sendData() async {
//     if (file == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select an image')),
//       );
//       return;
//     }

//     if (selectedLocation == null || selectedLocation!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a location')),
//       );
//       return;
//     }

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/pet');
//     final request = http.MultipartRequest('POST', url);

//     request.headers.addAll({
//       'Authorization': 'Bearer $token',
//     });

//     request.fields['Name'] = nicknameController.text.trim();
//     request.fields['BreedId'] = selectedBreed ?? '';
//     request.fields['Age'] = selectedAge ?? '';
//     request.fields['Gender'] = selectedGender ?? '';
//     request.fields['CategoryId'] = selectedCategory ?? '';
//     request.fields['Address'] = addressController.text.trim();
//     request.fields['LocationId'] = selectedLocation ?? '0';
//     request.fields['Price'] = isAdoption ? '0' : priceController.text.trim();
//     request.fields['height'] = heightController.text.trim();
//     request.fields['weight'] = weightController.text.trim();
//     request.fields['Discription'] = petDescriptionController.text.trim();
//     request.fields['IsAdoption'] = isAdoption.toString();
//   //  request.fields['IsVaccinated'] = isVaccinated.toString();
//    // request.fields['HasCertificate'] = hasCertificate.toString();

//     request.files.add(await http.MultipartFile.fromPath(
//       'ImageFile',
//       file!.path,
//     ));

//     try {
//       final response = await request.send();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Myhomescreen()),
//         );
//       } else {
//         final resBody = await response.stream.bytesToString();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to submit: $resBody')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("ADD DETAILS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 15, 0, 8),
//               Color(0xff281537),
//             ]),
//           ),
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     child: Container(
//                       height: 300,
//                       width: double.infinity,
//                       color: Colors.grey,
//                       child: Center(
//                         child: file == null ? const Icon(Icons.add) : Image.file(File(file!.path)),
//                       ),
//                     ),
//                     onTap: () async {
//                       final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//                       setState(() {
//                         file = photo;
//                       });
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildTextField(nicknameController, 'Name'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildDropdownField("Categories", selectedCategory, (value) {
//                     setState(() {
//                       selectedCategory = value;
//                       selectedBreed = null;
//                     });
//                     if (value != null) fetchBreeds(value);
//                   }, categories.map<DropdownMenuItem<String>>((item) {
//                     return DropdownMenuItem<String>(
//                       value: item['id'].toString(),
//                       child: Text(item['name']),
//                     );
//                   }).toList()),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildDropdownField("Breed", selectedBreed, (value) => setState(() => selectedBreed = value),
//                       breed.map<DropdownMenuItem<String>>((item) {
//                     return DropdownMenuItem<String>(
//                       value: item['id'].toString(),
//                       child: Text(item['name']),
//                     );
//                   }).toList()),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildDropdownField("Age", selectedAge, (value) => setState(() => selectedAge = value),
//                       List.generate(10, (index) => DropdownMenuItem(value: "${index + 1}", child: Text("${index + 1}")))),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildDropdownField("Gender", selectedGender, (value) => setState(() => selectedGender = value), const [
//                     DropdownMenuItem(value: "Male", child: Text("Male")),
//                     DropdownMenuItem(value: "Female", child: Text("Female")),
//                   ]),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildNumberField(heightController, "Height"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildNumberField(weightController, "Weight"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildTextArea(addressController, "Address"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildDropdownField("Location", selectedLocation, (value) => setState(() => selectedLocation = value),
//                       locations.map<DropdownMenuItem<String>>((item) {
//                     return DropdownMenuItem<String>(
//                       value: item['id'].toString(),
//                       child: Text(item['name']),
//                     );
//                   }).toList()),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: _buildTextArea(petDescriptionController, "Pet Description"),
//                 ),
                
//                 Visibility(
//                   visible: isVisible,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: _buildNumberField(priceController, "Price"),
//                   ),
//                 ),
                
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                   child: const Text("Submit", style: TextStyle(color: Colors.white)),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       sendData();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator: (value) => value == null || value.trim().isEmpty ? '$label is required' : null,
//       ),
//     );
//   }

//   Widget _buildNumberField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) return '$label is required';
//           if (double.tryParse(value) == null) return 'Enter a valid number';
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildTextArea(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: controller,
//         maxLines: 4,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator: (value) => value == null || value.trim().isEmpty ? '$label is required' : null,
//       ),
//     );
//   }

//   Widget _buildDropdownField(String hint, String? value, void Function(String?) onChanged, List<DropdownMenuItem<String>> items) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//             side: const BorderSide(width: 1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: DropdownButtonFormField<String>(
//           value: value,
//           hint: Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Text(hint),
//           ),
//           items: items,
//           onChanged: onChanged,
//           validator: (value) => value == null ? 'Please select a $hint' : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckbox(String label, bool value, void Function(bool?) onChanged) {
//     return Row(
//       children: [
//         Checkbox(
//           activeColor: Colors.blue,
//           value: value,
//           onChanged: onChanged,
//         ),
//         Text(label),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empetzapp/homescreen.dart';

class Mysellerscreen extends StatefulWidget {
  const Mysellerscreen({super.key});

  @override
  State<Mysellerscreen> createState() => _SellersState();
}

class _SellersState extends State<Mysellerscreen> {
  List<dynamic> categories = [];
  List<dynamic> breed = [];
  List<dynamic> locations = [];

  String? selectedCategory;
  String? selectedBreed;
  String? selectedAge;
  String? selectedGender;
  String? selectedLocation;

  bool isVaccinated = false;
  bool hasCertificate = false;
  bool isAdoption = false;
  bool isVisible = true;

  XFile? file;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController petDescriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchLocations();
  }

  Future<void> fetchCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/category');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        categories = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load categories')),
      );
    }
  }

  Future<void> fetchBreeds(String categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/breed/category/$categoryId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        breed = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load breeds')),
      );
    }
  }

  Future<void> fetchLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/location');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        locations = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load locations')),
      );
    }
  }

  Future<void> sendData() async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (selectedLocation == null || selectedLocation!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/pet');
    final request = http.MultipartRequest('POST', url);

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.fields['Name'] = nicknameController.text.trim();
    request.fields['BreedId'] = selectedBreed ?? '';
    request.fields['Age'] = selectedAge ?? '';
    request.fields['Gender'] = selectedGender ?? '';
    request.fields['CategoryId'] = selectedCategory ?? '';
    request.fields['Address'] = addressController.text.trim();
    request.fields['LocationId'] = selectedLocation ?? '0';
    request.fields['Price'] = isAdoption ? '0' : priceController.text.trim();
    request.fields['height'] = heightController.text.trim();
    request.fields['weight'] = weightController.text.trim();
    request.fields['Discription'] = petDescriptionController.text.trim();
    request.fields['IsAdoption'] = isAdoption.toString();

    request.files.add(await http.MultipartFile.fromPath(
      'ImageFile',
      file!.path,
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Myhomescreen()),
        );
      } else {
        final resBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit: $resBody')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("ADD DETAILS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: file == null
                              ? const Icon(Icons.add, size: 40)
                              : Image.file(File(file!.path), fit: BoxFit.cover),
                        ),
                      ),
                      onTap: () async {
                        final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          file = photo;
                        });
                      },
                    ),
                    _buildTextField(nicknameController, 'Name'),
                    _buildDropdownField("Categories", selectedCategory, (value) {
                      setState(() {
                        selectedCategory = value;
                        selectedBreed = null;
                      });
                      if (value != null) fetchBreeds(value);
                    }, categories.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['name']),
                      );
                    }).toList()),
                    _buildDropdownField("Breed", selectedBreed, (value) => setState(() => selectedBreed = value),
                        breed.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['name']),
                      );
                    }).toList()),
                    _buildDropdownField("Age", selectedAge, (value) => setState(() => selectedAge = value),
                        List.generate(10, (index) => DropdownMenuItem(value: "${index + 1}", child: Text("${index + 1}")))),
                    _buildDropdownField("Gender", selectedGender, (value) => setState(() => selectedGender = value), const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                    ]),
                    _buildNumberField(heightController, "Height"),
                    _buildNumberField(weightController, "Weight"),
                    _buildTextArea(addressController, "Address"),
                    _buildDropdownField("Location", selectedLocation, (value) => setState(() => selectedLocation = value),
                        locations.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['name']),
                      );
                    }).toList()),
                    _buildTextArea(petDescriptionController, "Pet Description"),
                    Visibility(
                      visible: isVisible,
                      child: _buildNumberField(priceController, "Price"),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text("Submit", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendData();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.trim().isEmpty ? '$label is required' : null,
      ),
    );
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return '$label is required';
          if (double.tryParse(value) == null) return 'Enter a valid number';
          return null;
        },
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.trim().isEmpty ? '$label is required' : null,
      ),
    );
  }

  Widget _buildDropdownField(String hint, String? value, void Function(String?) onChanged, List<DropdownMenuItem<String>> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
        items: items,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select a $hint' : null,
      ),
    );
  }
}
