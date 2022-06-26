import 'package:internsearch_mobile/models/category_response_model.dart';
import 'package:internsearch_mobile/screens/category/company_in_category.dart';
import 'package:internsearch_mobile/screens/home/detail_company.dart';
import 'package:internsearch_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<List<categoryData>> fetchCategory() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/category'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => categoryData.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class categoryData {
  late final int id;
  late final String name;
  late final String slug;

  categoryData({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory categoryData.fromJson(Map<String, dynamic> json) {
    return categoryData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class categoryPage extends StatefulWidget {
  const categoryPage({Key? key}) : super(key: key);

  @override
  State<categoryPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<categoryPage> {
  late Future<List<categoryData>> futureData;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureData = fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 22, 7),
        title: Text("All Categories"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          FutureBuilder<List<categoryResponseModel>>(
            future: APIService.getcategory(),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                List<categoryResponseModel> categoryData = snapshot.requireData;
                print(categoryData);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categoryData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => companyIncategory(
                                        name: categoryData[index].name,
                                        categoryId: categoryData[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          categoryData[index].name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          categoryData[index].slug,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    const Text(
                      "No category found!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
