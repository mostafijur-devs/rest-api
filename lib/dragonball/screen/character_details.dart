import 'package:flutter/material.dart';

import '../model/dragon_ball_model.dart';

class CharacterDetails extends StatelessWidget {
   const CharacterDetails({super.key,required this.character});
   final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${character.name} Details"),
        centerTitle: true,
      ),
      body:ListView(
        children: [
          Image.network(character.image,height: MediaQuery.of(context).size.height*0.7,width: 200,),
          Text("Name: ${character.name}"),
          Text("Ki: ${character.ki}"),
          Text("Max Ki: ${character.maxKi}"),
          Text("Race: ${character.race}"),
          Text("Gender: ${character.gender}"),
          Text("Description: ${character.description}"),

        ],
      ) ,
    );
  }
}
