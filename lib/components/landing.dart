import 'package:flutter/material.dart';
import 'package:princess_advanture/pink_adventure.dart';

class Landing extends StatelessWidget {

  static const String ID = 'Landing';
  final PinkAdventure game;
  const Landing({ super.key, required this.game });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 15.0),
            child: Text(
              'Pink Adventure',
              style: TextStyle(
                fontSize: 50.0,
                color: Color(0xFFE593B3),
              ),
            )
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove('Landing');
                game.nextLevel('japan');
              },
              child: const Text(
                '게임 시작',
                style: TextStyle(
                  color: Color(0xFFE593B3),
                )
              ),
            )
          )
        ]
      )
    );
  }

}