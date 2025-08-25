import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/animals_response_model.dart';

class AnimalView extends StatelessWidget {
   AnimalView({super.key,required this.volumeInfo});
  VolumeInfo? volumeInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(volumeInfo?.title.toString()??'Animal name not found'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: volumeInfo?.imageLinks?.thumbnail ?? '',height: 300,width: 200,fit: BoxFit.cover,),
              SizedBox(height: 30,),
              Text(volumeInfo?.title.toString() ?? 'Name not found'),
              SizedBox(height: 30,),
              Text(volumeInfo?.authors.toString() ?? 'Author not found'),
              SizedBox(height: 30,),
              Text(volumeInfo?.publishedDate.toString() ?? 'publishedDate not found'),
              SizedBox(height: 30,),
              Text(volumeInfo?.previewLink.toString() ?? 'Description not found'),

              SizedBox(height: 30,),
              volumeInfo?.description != null?Text(volumeInfo!.description.toString()) : Text('Description not found')

            ],
          ),
        ),
      ),
    );
  }
}
