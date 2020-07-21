import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screen/homescreen.dart';
import './provider/firebase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FirebaseProvider()),
      ],
      child: MaterialApp(
        title: 'Firestore Crud',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
              color: Colors.deepOrange[300],
            )),
        home: HomeScreen(),
      ),
    );
  }
}
