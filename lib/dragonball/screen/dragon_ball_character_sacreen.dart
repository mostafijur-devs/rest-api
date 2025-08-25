import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../model/dragon_ball_model.dart';
import 'character_details.dart';
import 'next_page.dart';

class DragonBallCharacterSacreen extends StatefulWidget {
  const DragonBallCharacterSacreen({super.key});

  @override
  State<DragonBallCharacterSacreen> createState() =>
      _DragonBallCharacterSacreenState();
}

class _DragonBallCharacterSacreenState
    extends State<DragonBallCharacterSacreen> {
  DragonBallModel? dragonBallModel;
  bool isloading = true;
  int currentPage = 1;
  List page = [1, 2, 3, 4, 5, 6];
  List<TextButton> button = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharacter();
  }

  getCharacter() async {
    final url = 'https://dragonball-api.com/api/characters';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        dragonBallModel = DragonBallModel.fromJson(data);
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dragon Ball Character"), centerTitle: true),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : dragonBallModel == null
          ? Center(child: Text("No Data Found"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final characterList = dragonBallModel!.items;
                      return Card(
                        elevation: 5,
                        child: GridTile(
                          header: Text(characterList[index].name),
                          footer: Text(characterList[index].affiliation),
                          child: ListTile(
                            title: Image.network(
                              characterList[index].image,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image completely loaded -> show actual image
                                  return child;
                                } else {
                                  // Image loading -> show progress indicator
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                }
                              },
                              height: 500,
                            ),
                            // title: CachedNetworkImage(
                            //   imageUrl: characterList[index].image,
                            //   height: 500,
                            //   placeholder: (context, url) =>
                            //       Center(child: CircularProgressIndicator()),
                            //   // Shimmer.fromColors(child: Container(
                            //   //   color: Colors.white,
                            //   //   height: 500,
                            //   //   width: 500,
                            //   // ), baseColor: Colors.grey[300]!,
                            //   //   highlightColor: Colors.grey[100]!,
                            //   //   direction: ShimmerDirection.rtl,
                            //   //   enabled: true,
                            //   //   period: Duration(seconds: 1),
                            //   // )
                            // ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CharacterDetails(
                                    character: characterList[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: dragonBallModel!.items.length,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: _previous, child: Text("Previous")),
          Expanded(
            child: SizedBox(
              width: 300,
              height: 50,

              child: ListView.builder(
                itemBuilder: (context, index) {
                  final pageNumber = index + 1;
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: currentPage == pageNumber
                          ? Colors.blueAccent
                          : Colors.white,
                    ),
                    onPressed: () async {
                      final url =
                          'https://dragonball-api.com/api/characters?page=${index + 1}&limit=10';
                      try {
                        isloading = true;
                        final response = await http.get(Uri.parse(url));
                        if (response.statusCode == 200) {
                          final data = json.decode(response.body);
                          setState(() {
                            dragonBallModel = DragonBallModel.fromJson(data);
                            currentPage = pageNumber;
                            isloading = false;
                          });
                        }
                      } catch (e) {
                        print('Error: $e');
                      }

                      // }, child: Text('${index+1}',style: TextStyle(color: currentPage==index+1?Colors.white:Colors.black),));
                    },
                    child: Text(
                      '$pageNumber',
                      style: TextStyle(
                        color: currentPage == pageNumber
                            ? Colors.black
                            : Colors.blueAccent,
                      ),
                    ),
                  );
                },
                itemCount: page.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
              ),
            ),
          ),
          TextButton(onPressed: _next, child: Text("Next")),
        ],
      ),
    );
  }

  _previous() async {
    final uri = dragonBallModel!.links!.previous;
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          dragonBallModel = DragonBallModel.fromJson(data);
          EasyLoading.showSuccess('previous Page ...........');

          currentPage--;
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage(dragonBallModel: dragonBallModel!,),));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  _next() async {
    final uri = dragonBallModel!.links!.next;

    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          dragonBallModel = DragonBallModel.fromJson(data);
          EasyLoading.showSuccess('Next Page ...........');
          currentPage++;
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage(dragonBallModel: dragonBallModel!,),));
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
