import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Pets extends StatefulWidget {
  final Map<String, dynamic> categoryName;

  const Pets({super.key, required this.categoryName});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  Map<String, dynamic>? sellerData;

  @override
  void initState() {
    super.initState();
    fetchSellerData();
  }

  Future<void> fetchSellerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found! Please login again.')),
      );
      return;
    }

    final userId = widget.categoryName['userId'];
    final url = Uri.parse('http://192.168.1.60/Empetz/user/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          sellerData = data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load seller data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  Widget infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.categoryName;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          category['name'] ?? 'No name',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              category['imagePath'] ?? 'https://via.placeholder.com/150',
              height: 350,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: "My Name is ",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 74, 44)),
                      children: [
                        TextSpan(
                          text: category['name'] ?? 'Unknown',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blue),
                    Text(category['locationName'] ?? 'No location'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '₹ ${category['price']?.toString() ?? '0'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Facts About Me",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 7, 74, 44),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoRow("Breed", category['breedName']),
                infoRow("Sex", category['gender']),
                infoRow("Age", category['age']?.toString()),
                infoRow("Height", category['height']?.toString()),
                infoRow("Weight", category['weight']?.toString()),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "My Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 7, 74, 44),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category['description'] ?? 'No description available'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Seller Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 7, 74, 44),
              ),
            ),
          ),
          Card(
            color: Colors.brown,
            child: ListTile(
              title: Text(sellerData?['firstName'] ?? 'Loading...',style: TextStyle(color: Colors.white),),
              subtitle: Text(sellerData?['email'] ?? 'No email',style: TextStyle(color: Colors.white),),
              trailing: IconButton(
                onPressed: () async {
                  final phone = sellerData?['phone'];
                  if (phone != null && phone.isNotEmpty) {
                    final Uri url = Uri.parse('tel:$phone');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cannot make a call')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Phone number not available')),
                    );
                  }
                },
                icon: const Icon(Icons.call, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
