import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest_api/google_animals/screen/animal_view.dart';

import '../models/google_book_response.dart';

class SearchScreen extends SearchDelegate{
  SearchScreen({required this.googleBookResponse});
  final GoogleBookResponse googleBookResponse;
  @override
  List<Widget>? buildActions(BuildContext context) {

   return [IconButton(onPressed: () {
     query = '';
   }, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in googleBookResponse.items!){
      if(item.volumeInfo!.title.toString().toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item.volumeInfo!.title.toString());
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<VolumeInfo> valume = [];
    var itmes =googleBookResponse.items;
    for(var item in itmes!){
      if(item.volumeInfo!.title.toString().toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item.volumeInfo!.title.toString());
        valume.add(item.volumeInfo!);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalView(volumeInfo: valume[index],),));
          },
          leading: CachedNetworkImage(imageUrl: valume[index].imageLinks!.thumbnail.toString(),placeholder: (context, url) => CircularProgressIndicator(),),
          title: Text(result),
        );
      },
    );

  }


  void searchResult(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalView(),));

  }
}