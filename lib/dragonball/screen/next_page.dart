import 'package:flutter/material.dart';
import 'package:rest_api/dragonball/model/dragon_ball_model.dart';
import 'package:rest_api/dragonball/screen/character_details.dart';

class NextPage extends StatelessWidget {
  NextPage({super.key, required this.dragonBallModel});

  DragonBallModel dragonBallModel;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body:
      SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final characterList = dragonBallModel.items;
            return Card(
              elevation: 5,
              child: GridTile(
                  header: Text(characterList[index].name),
                  footer: Text(characterList[index].affiliation),
                  child: ListTile(
                      title: Image.network(characterList[index].image),onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetails(character:characterList[index] ,),));
                      },),

              ),

            );
          },
          itemCount: dragonBallModel.items.length,
        ),
      ),
    );
  }
}
