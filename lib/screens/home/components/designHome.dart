//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Ar_interior2.dart';

class DesignHomePage extends StatefulWidget {
  const DesignHomePage({super.key});

  @override
  _DesignHomePageState createState() => _DesignHomePageState();
}

class _DesignHomePageState extends State<DesignHomePage> {
  late Future<Map<String, dynamic>> _data;
  String _selectedCategory = "Bed_Room";

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse("https://visionaryhome.vercel.app/design_options"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return DropdownButton<String>(
              value: _selectedCategory,
              style: const TextStyle(
                  color: Colors.white), // Make the selected category text white
              dropdownColor: const Color.fromARGB(
                  255, 66, 66, 66), // Keeps dropdown items' background white
              items: snapshot.data!.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(
                    snapshot.data![key]['name'],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 251, 250,
                            250)), // Keeps dropdown items text black
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error fetching data"));
                }
                List<String> imageUrls = [];
                snapshot.data![_selectedCategory].forEach((key, value) {
                  if (key != "name") {
                    imageUrls.add(value);
                  }
                });
                return ListView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(imageUrls[index], fit: BoxFit.cover),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AR_Sessionn()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 34, 84),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Start Designing in AR'),
            ),
          ),
        ],
      ),
    );
  }
}
