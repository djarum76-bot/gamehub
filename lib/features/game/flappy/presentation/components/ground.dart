import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_configuration.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_images.dart';

class Ground extends ParallaxComponent<FlappyBirdGame> with HasGameRef<FlappyBirdGame>{
  @override
  Future<void> onLoad()async{
    final ground = await Flame.images.load(FlappyImages.ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none)
      )
    ]);

    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - FlappyConfiguration.groundHeight),
        size: Vector2(gameRef.size.x, FlappyConfiguration.groundHeight)
      )
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = FlappyConfiguration.gameSpeed;
  }
}