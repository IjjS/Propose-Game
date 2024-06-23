import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:princess_advanture/components/level.dart';
import 'package:princess_advanture/player/Player.dart';
import 'package:princess_advanture/enums/player_direction.dart';
import 'package:princess_advanture/components/jump_button.dart';

class PinkAdventure extends FlameGame with DragCallbacks {

  late CameraComponent cam;
  late final JoystickComponent joystick;
  late final JumpButton jumpButton;
  final player = Player();

  PinkAdventure() {
    pauseWhenBackgrounded = false;
  }

  @override
  FutureOr<void> onLoad() async {

    overlays.add('Landing');
    await images.loadAllImages();

    final level = Level(player: player, name: 'landing');
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Knob.png')),
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Background.png')),
      ),
      margin: const EdgeInsets.only(left: 64, bottom: 32),
    );
    jumpButton = JumpButton();

    _loadLevel(level);
    
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left || JoystickDirection.upLeft || JoystickDirection.downLeft:
        player.direction = PlayerDirection.left;
        break;
      case JoystickDirection.right || JoystickDirection.upRight || JoystickDirection.downRight:
        player.direction = PlayerDirection.right;
        break;
      default:
        player.direction = PlayerDirection.none;
        break;
    }
  }

  void nextLevel(String levelName) {
    removeWhere((component) => component is Level);
    final level = Level(player: player, name: levelName);

    _loadLevel(level);
  }

  void _loadLevel(Level level) {
    cam = CameraComponent.withFixedResolution(world: level, width: 892, height: 392);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([level, cam]);
    cam.viewport.add(joystick);
    cam.viewport.add(jumpButton);
  }

}