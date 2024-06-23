import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:princess_advanture/pink_adventure.dart';

class JumpButton extends SpriteComponent with HasGameRef<PinkAdventure>, TapCallbacks {

  final margin = 32;
  final buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    sprite  = Sprite(game.images.fromCache('HUD/Jump.png'));
    // TODO: iphone button size
    position = Vector2(
      game.size.x,
      game.size.y - buttonSize,
    );

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;

    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;

    super.onTapUp(event);
  }

}