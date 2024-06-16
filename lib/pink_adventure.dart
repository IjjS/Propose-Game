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

  late final CameraComponent cam;
  late JoystickComponent joystick;
  final player = Player();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    final level = Level(player: player, name: 'landing');

    cam = CameraComponent.withFixedResolution(world: level, width: 892, height: 392);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([level, cam]);
    addJoystick();
    addJumpButton();
    
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Knob.png')),
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Background.png')),
      ),
      margin: const EdgeInsets.only(left: 64, bottom: 32),
    );

    cam.viewport.add(joystick);
  }

  void addJumpButton() {
    final jumpButton = JumpButton();

    cam.viewport.add(jumpButton);
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

}