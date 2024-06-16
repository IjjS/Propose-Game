import 'package:princess_advanture/components/collision/collision_block.dart';

class Wall extends CollisionBlock {

  Wall({ super.position, super.size });

  @override
  bool isPassable() {
    return false;
  }

}