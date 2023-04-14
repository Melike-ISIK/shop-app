import 'package:flutter/material.dart';
import 'Route/Router.dart' as myRoute;

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: myRoute.Router.generateRoute,
      theme: ThemeData(
        fontFamily: 'Gordita'
      ),
    );
  }
}
