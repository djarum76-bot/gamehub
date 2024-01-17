import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/features/game/flappy/presentation/components/background.dart';
import 'package:gamehub/features/game/flappy/presentation/components/bird.dart';
import 'package:gamehub/features/game/flappy/presentation/components/ground.dart';
import 'package:gamehub/features/game/flappy/presentation/components/pipe_group.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_configuration.dart';
import 'package:google_fonts/google_fonts.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection{
  late Bird bird;
  late TextComponent score;
  Timer interval = Timer(FlappyConfiguration.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad()async{
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore()
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        text: "Score: 0",
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
            style: GoogleFonts.schoolbell(fontSize: 40, fontWeight: FontWeight.bold)
        )
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = "Score: ${bird.score}";
  }
}