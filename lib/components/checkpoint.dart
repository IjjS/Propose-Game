import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:princess_advanture/pink_adventure.dart';
import 'package:princess_advanture/player/Player.dart';

class Checkpoint extends SpriteAnimationComponent with HasGameRef<PinkAdventure>, CollisionCallbacks {

  Checkpoint({ super.position, super.size });

  final double stepTime = 0.05;
  bool reached = false;

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    add(RectangleHitbox(
      position: Vector2(30, 50),
      size: Vector2(34, 18),
    ));

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Checkpoints/Start/Start (Moving) (64x64).png'),
      SpriteAnimationData.sequenced(
        amount: 17,
        stepTime: stepTime,
        textureSize: Vector2.all(64),
      )
    );

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      game.pauseEngine();
    }

    super.onCollision(intersectionPoints, other);
  }

}