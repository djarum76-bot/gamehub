import 'package:flutter/material.dart';
import 'package:gamehub/features/home/presentation/widgets/launcher_button.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeBody(context),
    );
  }

  Widget _homeBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Wrap(
          children: [
            LauncherButton(onTap: (){}, color: Colors.amber, name: "Flappy Bird"),
          ],
        ),
      ),
    );
  }
}