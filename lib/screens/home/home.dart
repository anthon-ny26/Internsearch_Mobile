import 'package:internsearch_mobile/screens/category/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internsearch_mobile/models/category_response_model.dart';
import 'package:internsearch_mobile/models/user_response_model.dart';
import 'package:internsearch_mobile/screens/account/account.dart';
import 'package:internsearch_mobile/screens/category/category.dart';
import 'package:internsearch_mobile/screens/home/detail_company.dart';
import 'package:internsearch_mobile/services/api_service.dart';
import 'package:internsearch_mobile/services/shared_services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<List<companyData>> fetchCompany() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/company'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => companyData.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class companyData {
  late final int id;
  late final int company_id;
  late final String category_name;
  late final String name;
  late final String slug;
  late final String image;
  late final String excerpt;
  late final String desc;
  String? createdAt;
  String? updatedAt;

  companyData({
    required this.id,
    required this.company_id,
    required this.category_name,
    required this.name,
    required this.slug,
    required this.image,
    required this.excerpt,
    required this.desc,
    this.createdAt,
    this.updatedAt,
  });

  factory companyData.fromJson(Map<String, dynamic> json) {
    return companyData(
      id: json['id'],
      company_id: json['company_id'],
      category_name: json['category_name'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      excerpt: json['excerpt'],
      desc: json['desc'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<companyData>> futureData;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureData = fetchCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: FutureBuilder<UserResponseModel>(
              future: APIService.getUserProfile(),
              builder: (BuildContext context,
                  AsyncSnapshot<UserResponseModel> model) {
                if (model.hasData) {
                  print(model.data!.name);
                  return Text(
                    "Hello, ${model.data!.name}",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  );
                }
                return const Text("Please Login");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All Intern",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder<List<companyData>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<companyData> CompanyData = snapshot.requireData;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: CompanyData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Detailcompany(
                                          name: CompanyData[index].name,
                                          desc: CompanyData[index].desc,
                                          img: CompanyData[index].image,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 2.0),
                                    width: 170,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            CompanyData[index].image),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.darken),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        CompanyData[index].name,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        CompanyData[index].category_name,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        CompanyData[index].excerpt,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Color.fromARGB(255, 229, 22, 7)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Detailcompany(
                                                name: CompanyData[index].name,
                                                desc: CompanyData[index].desc,
                                                img: CompanyData[index].image,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text("Detail"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          )
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
