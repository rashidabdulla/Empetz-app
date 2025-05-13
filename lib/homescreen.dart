import 'dart:convert';
import 'package:empetzapp/about.dart';
import 'package:empetzapp/account.dart';
import 'package:empetzapp/favorite.dart';
import 'package:empetzapp/petimage.dart';
import 'package:empetzapp/sellerscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'main.dart'; // Import to access the dark mode toggle

class Myhomescreen extends StatefulWidget {
  const Myhomescreen({super.key});

  @override
  State<Myhomescreen> createState() => _MyhomescreenState();
}

class _MyhomescreenState extends State<Myhomescreen> {
  List<dynamic> buyer = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found! Please login again.')),
      );
      return;
    }

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
        buyer = data;
      });
    } else {
      print('Error fetching categories: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch category data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          title: Text(
            'EMPETZ',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                isDarkMode.value = !isDarkMode.value;
              },
              icon: Icon(
                isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).iconTheme.color,
              ),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Buyer'),
              Tab(text: 'Seller'),
            ],
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 40,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'EMPETZ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Account'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Myaccount()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorite'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyFavorite()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_mark_outlined),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Myabout()),
                  );
                },
              ),
              const ListTile(
                leading: Icon(Icons.contacts_outlined),
                title: Text('Contact us'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: buyer.length,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 5 / 4,
              ),
              itemBuilder: (context, index) {
                final category = buyer[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final categoryId = category['id'];
                      final categoryName = category['name'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Petimage(
                            categoryId: categoryId,
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        category['imagePath'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Myfloat(),
          ],
        ),
      ),
    );
  }
}


class Myfloat extends StatefulWidget {
  const Myfloat({super.key});

  @override
  State<Myfloat> createState() => _MyfloatState();
}

class _MyfloatState extends State<Myfloat> {
  List<dynamic> history = [];

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found! Please login again.')),
      );
      return;
    }

    final url =
        Uri.parse('http://192.168.1.60/Empetz/api/v1/user-posted-history');
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
        history = data;
      });
    } else {
      print('Error fetching history: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch history data')),
      );
    }
  }

  Future<void> delete(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found! Please login again.')),
      );
      return;
    }

    final url = Uri.parse('http://192.168.1.60/Empetz/api/v1/pet/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted successfully')),
      );
      fetchHistory();
    } else {
      print('Error deleting history: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Mysellerscreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final hist = history[index];

          final List<Color> cardColors = [
            Colors.blue.shade100,
            Colors.green.shade100,
            Colors.orange.shade100,
            Colors.pink.shade100,
          ];

          final cardColor = cardColors[index % cardColors.length];

          return Card(
            color: cardColor,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: hist['image'] != null
                    ? MemoryImage(base64Decode(hist['image']))
                    : null,
                child: hist['image'] == null ? const Icon(Icons.person) : null,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hist['name'] ?? 'No Name',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(hist['categoryName'] ?? 'No Category'),
                        Text(hist['price'].toString()),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      final petid = hist['id'];
                      if (petid != null) {
                        delete(petid);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ID not found')),
                        );
                      }
                    },
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
