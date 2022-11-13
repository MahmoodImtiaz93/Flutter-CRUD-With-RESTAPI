import 'package:flutter/material.dart';
import 'package:notesappv2/provider/notedataprovider.dart';
import 'package:notesappv2/screens/addnotes.dart';
import 'package:notesappv2/screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteDataProvider(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen()),
    );
  }
}
