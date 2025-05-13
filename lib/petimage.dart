// import 'dart:convert';
// import 'package:empetzapp/petdetail.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Petimage extends StatefulWidget {
//   final String categoryId;
//   final String categoryName;

//   const Petimage({super.key, required this.categoryId, required this.categoryName});

//   @override
//   State<Petimage> createState() => _PetimageState();
// }

// class _PetimageState extends State<Petimage> {
//   List<dynamic> image = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchImage();
//   }

//   Future<void> fetchImage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Token not found!')),
//       );
//       return;
//     }

//     final url = Uri.parse(
//         'http://192.168.1.60/Empetz/api/v1/pet/catagory?categoryid=${widget.categoryId}&PageNumber=1&PageSize=1000');
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
//         image = data;
//       });
//     } else {
//       print('Error fetching image: ${response.statusCode}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to fetch image')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         centerTitle: true,
//         title: Text(widget.categoryName,style: TextStyle(color: Colors.white),),
//           flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 15, 0, 8),
//               Color(0xff281537),
//             ]),
//           ),
//         ),
//       ),
//       body: image.isEmpty
//           ? const Center(child:Text('No data') )
//           : GridView.builder(
//               itemCount: image.length,
//               padding: const EdgeInsets.all(10),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of columns
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) {
//                 final foto = image[index];
//                 return GestureDetector(
//                   onTap: () {

//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> Pets(categoryName: foto)));
//                   },
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                             child: Image.network(
//                               foto['imagePath'] ?? 'https://via.placeholder.com/150',
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 foto['name'] ?? 'No Name',
//                                 style: const TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 foto['price'] != null ? '₹${foto['price']}' : 'No Price',
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
                              
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'dart:convert';
import 'package:empetzapp/petdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Petimage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const Petimage({super.key, required this.categoryId, required this.categoryName});

  @override
  State<Petimage> createState() => _PetimageState();
}

class _PetimageState extends State<Petimage> {
  List<dynamic> image = [];

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  Future<void> fetchImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found!')),
      );
      return;
    }

    final url = Uri.parse(
        'http://192.168.1.60/Empetz/api/v1/pet/catagory?categoryid=${widget.categoryId}&PageNumber=1&PageSize=1000');
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
        image = data;
      });
    } else {
      print('Error fetching image: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: const TextStyle(color: Colors.black), // Set text color to black
        ),
    backgroundColor: Colors.white,
      ),
      body: image.isEmpty
          ? const Center(child: Text('No data available'))
          : GridView.builder(
              itemCount: image.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final foto = image[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pets(
                          categoryName: foto,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              foto['imagePath'] ?? 'https://via.placeholder.com/150',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                foto['name'] ?? 'No Name',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                foto['price'] != null ? '₹${foto['price']}' : 'No Price',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
