import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:princess_advanture/components/landing.dart';
import 'package:princess_advanture/pink_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  PinkAdventure game = PinkAdventure();
  // on deployment, run the prod mode
  runApp(
      GameWidget(
        game: kDebugMode ? PinkAdventure() : game,
        overlayBuilderMap: {
          Landing.ID: (BuildContext context, PinkAdventure game) => Landing(game: game),
        },
      )
  );
}
