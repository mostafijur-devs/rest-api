import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/google_animals/models/animals_response_model.dart';

import 'animal_view.dart';

class AnimalsView extends StatefulWidget {
  const AnimalsView({super.key});

  @override
  State<AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<AnimalsView> {
  AnimalsRespons? animalsResponseModel;
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAnimals();
  }

  _getAnimals() async{

    try{
      final url = 'https://www.googleapis.com/books/v1/volumes?q=animals';
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final data = json.decode(response.body);
      setState(() {
        animalsResponseModel = AnimalsRespons.fromJson(data);
        isloading = false;

        print(animalsResponseModel);

      });

      }


    }catch(e){
      print('Error: $e');
    }finally{
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animals List"),
        centerTitle: true,
      ),
      body:isloading? Center(child: CircularProgressIndicator(),):ListView.builder(itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalView(volumeInfo: animalsResponseModel?.items?[index].volumeInfo,)));
            },

            title: Text(animalsResponseModel?.items?[index].volumeInfo?.title ?? ''),
            // subtitle: Text(animalsResponseModel?.items?[index].volumeInfo?.description ?? ''),
            subtitle: Text(animalsResponseModel?.items?[index].volumeInfo?.authors?.first ?? 'api response error'),
            leading: CachedNetworkImage(imageUrl: animalsResponseModel?.items?[index].volumeInfo?.imageLinks?.thumbnail ?? '',placeholder: (context, url) => CircularProgressIndicator(),),
          ),
        );
      },itemCount:animalsResponseModel?.items?.length ),
    );
  }
}
