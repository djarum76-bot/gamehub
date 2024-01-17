import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_images.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame>{
  @override
  Future<void> onLoad()async{
    final background = await Flame.images.load(FlappyImages.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}