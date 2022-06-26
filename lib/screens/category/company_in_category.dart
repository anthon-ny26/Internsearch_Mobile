import 'package:internsearch_mobile/models/company_in_category_response_model.dart';
import 'package:internsearch_mobile/screens/home/detail_company.dart';
import 'package:internsearch_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class companyIncategory extends StatefulWidget {
  final String name;
  final int categoryId;
  companyIncategory({
    required this.name,
    required this.categoryId,
  });
  @override
  State<companyIncategory> createState() => _companyIncategoryState();
}

class _companyIncategoryState extends State<companyIncategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 22, 7),
        title: Text("Intern in ${widget.name}"),
      ),
      body: ListView(
        children: [
          FutureBuilder<List<companyIncategoryResponseModel>>(
            future: APIService.getcompanyIncategory(widget.categoryId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<companyIncategoryResponseModel> companyIncategory =
                    snapshot.requireData;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: companyIncategory.length,
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
                                          name: companyIncategory[index].name!,
                                          desc: companyIncategory[index].desc!,
                                          img: companyIncategory[index].image!,
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
                                            companyIncategory[index].image!),
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
                                        companyIncategory[index].name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        companyIncategory[index].excerpt!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 20.0,
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
                                                name: companyIncategory[index].name!,
                                                desc: companyIncategory[index].desc!,
                                                img: companyIncategory[index].image!,
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
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    const Text(
                      "No Intern found!",
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
      ),
    );
  }
}
