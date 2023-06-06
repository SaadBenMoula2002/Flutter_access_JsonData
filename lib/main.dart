import 'package:flutter/material.dart';
import 'package:tp1/Screen/DBproduct.dart';

void main() {
  runApp(js());
}

class js extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Product Search",
      home: DBproduct(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: {},
    );
  }
}