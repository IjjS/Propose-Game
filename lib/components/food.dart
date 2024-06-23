import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:princess_advanture/pink_adventure.dart';
import 'package:princess_advanture/player/Player.dart';

class Food extends SpriteAnimationComponent with HasGameRef<PinkAdventure>, CollisionCallbacks {

  final String name;

  Food({ required this.name, super.position, super.size });

  final double stepTime = 0.03;
  bool _collected = false;

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Food/menu/$name.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: size),
    );

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      if (!_collected) {
        animation = SpriteAnimation.fromFrameData(
          game.images.fromCache('Items/Fruits/Collected.png'),
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: stepTime,
            textureSize: Vector2.all(32),
            loop: false
          ),
        );

        _collected = true;

        game.number++;

        Future.delayed(
          const Duration(milliseconds: 400),
              () => removeFromParent(),
        );
      }
    }

    super.onCollision(intersectionPoints, other);
  }

}