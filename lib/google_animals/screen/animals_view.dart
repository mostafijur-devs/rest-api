import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/google_animals/models/animals_response_model.dart';

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
      final url = 'https://www.googleapis.com/books/v1/volumes?q=flutter';
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
        title: Text("Animals ${animalsResponseModel?.totalItems}"),
        centerTitle: true,
      ),
      body:isloading? Center(child: CircularProgressIndicator(),):ListView.builder(itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(

            title: Text(animalsResponseModel?.items?[index].volumeInfo?.title ?? ''),
            // subtitle: Text(animalsResponseModel?.items?[index].volumeInfo?.description ?? ''),
            subtitle: Text(animalsResponseModel?.items?[index].volumeInfo?.authors?.first ?? 'api response error'),
            leading: Image.network(animalsResponseModel?.items?[index].volumeInfo?.imageLinks?.thumbnail ?? ''),
          ),
        );
      },itemCount:animalsResponseModel?.items?.length ),
    );
  }
}
