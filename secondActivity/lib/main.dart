import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'dart:developer';

String text = "Loading";

void main() {
  MaterialApp app = MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'OoohBaby',
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("App")),
        body: newBody(),
        bottomNavigationBar: newBottomNavigationBar(),       
        
      )
    );
  runApp(app);
}

class newBody extends StatelessWidget {
  const newBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StyledText(
            text: 'Testing <bold>$text</bold>',
            style: TextStyle(fontSize: 45),
            tags: {
              'bold': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
            },
          ),   
          Expanded(child: FadeInImage.assetNetwork(
            placeholder: 'assets/pokeball.gif',
            image: 'https://scarletviolet.pokemon.com/_images/global/en/pokemon-scarlet-logo-medium-up.webp',
            )     
          )  
        ]
      ) 
    );
  }
}

class newBottomNavigationBar extends StatelessWidget {
  const newBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.replay_circle_filled_rounded),
          label: 'Reload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
      ],
      selectedLabelStyle: TextStyle(fontSize: 22),
      selectedItemColor: Colors.greenAccent,
      unselectedLabelStyle: TextStyle(fontSize: 20),
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}

void _onItemTapped(int index) {
    if (index == 0){
      log("Reload");
    }
    if (index == 1){
      log("Add");
    }
}
