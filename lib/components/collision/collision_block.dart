import 'dart:ui';

import 'package:flame/components.dart';

abstract class CollisionBlock extends PositionComponent {

  CollisionBlock({ super.position, super.size });

  bool isPassable();

  bool isCollidingWith(PositionComponent target) {
    return target.toRect().overlaps(toRect());
  }

  bool isCollidingBottom(PositionComponent target) {
    Rect intersect = toRect().intersect(target.toRect());

    return intersect.width > 5;
  }

  bool isCollidingSides(PositionComponent target) {
    Rect intersect = toRect().intersect(target.toRect());

    return intersect.height > 5;
  }

}