import 'package:flutter/material.dart';
import 'package:notesappv2/model/notesmodel.dart';
import 'package:notesappv2/provider/notedataprovider.dart';
import 'package:provider/provider.dart';

import '../model/notesmodel.dart';

class AddNotesScreen extends StatefulWidget {
  AddNotesScreen({Key? key}) : super(key: key);

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  void addNewNote() {
    Notes newNotes = Notes(
      title: _titleController.text,
      body: _contentController.text,
    );
    Provider.of<NoteDataProvider>(context, listen: false).addNotes(newNotes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        actions: [
          IconButton(
              onPressed: () {
                // Map data = {
                //   "title": _titleController.toString(),
                //   "body": _contentController.toString()
                // };
                addNewNote();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              decoration:
                  InputDecoration(labelText: 'Title', border: InputBorder.none),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                controller: _contentController,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    labelText: 'Content', border: InputBorder.none),
              ),
            ),
          ],
        ),
      )),
    );
  }
  
   
}
