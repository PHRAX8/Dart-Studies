import 'package:flutter/material.dart';

class NewbottomNavigationBar extends StatelessWidget {
  List<Icon> objects;
  NewbottomNavigationBar({this.objects = const []});

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: objects.map( 
      (obj) => 
        BottomNavigationBarItem(label: "",icon: obj),
      ).toList(),
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.grey,);
  }
}

class newBody extends StatelessWidget {
  newBody();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Text("La Fin Du Monde - Bock - 65 ibu"),
      ),
      Expanded(
        child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
      ),
      Expanded(
        child: Text("Duvel - Pilsner - 82 ibu"),
      )
    ]);
  }
}

class newAppBar extends StatelessWidget implements PreferredSizeWidget{
  newAppBar();

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text("Dicas"),
      );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
          appBar: newAppBar(),
          body: newBody(),
          bottomNavigationBar: NewbottomNavigationBar(objects: [
            Icon(Icons.coffee_outlined),
            Icon(Icons.local_drink_outlined),
            Icon(Icons.zoom_out_map_outlined),
            Icon(Icons.flag_outlined)
          ])),
    );
  }
}

void main() {
  MyApp app = MyApp();
  runApp(app);
}
