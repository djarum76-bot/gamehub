import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/presentation/components/pipe.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_audios.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_configuration.dart';
import 'package:gamehub/features/game/flappy/utils/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame>{
  final _random = Random();

  @override
  Future<void> onLoad()async{
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - FlappyConfiguration.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(height: centerY - spacing / 2, pipePosition: PipePosition.top),
      Pipe(height: heightMinusGround - (centerY + spacing / 2), pipePosition: PipePosition.bottom)
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= FlappyConfiguration.gameSpeed * dt;

    if(position.x < -10){
      removeFromParent();
      updateScore();
    }

    if(gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore(){
    gameRef.bird.score += 1;
    FlameAudio.play(FlappyAudios.point);
  }
}