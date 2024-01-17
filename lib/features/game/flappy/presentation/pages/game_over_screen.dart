import 'package:flutter/material.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_images.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_routes.dart';
import 'package:gamehub/shared/extensions/media_query_extension.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget{
  const GameOverScreen({super.key, required this.game});
  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Score: ${game.bird.score}",
              style: GoogleFonts.schoolbell(fontSize: 60.sp, color: Colors.white),
            ),
            SizedBox(height: 2.5.h,),
            Image.asset(FlappyImages.gameOver),
            SizedBox(height: 5.h,),
            ElevatedButton(
              onPressed: _onRestart,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text(
                "Restart",
                style: GoogleFonts.schoolbell(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 2.5.h,),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                "Exit game",
                style: GoogleFonts.schoolbell(fontSize: 20.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onRestart() {
    game.bird.reset();
    game.overlays.remove(FlappyRoutes.gameOver);
    game.resumeEngine();
  }
}