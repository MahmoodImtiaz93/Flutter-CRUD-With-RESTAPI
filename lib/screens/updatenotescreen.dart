import 'package:flutter/material.dart';
import 'package:notesappv2/model/notesmodel.dart';
import 'package:notesappv2/provider/notedataprovider.dart';
import 'package:provider/provider.dart';

class UpdateNotesScreen extends StatefulWidget {
  final Notes? notes;

  UpdateNotesScreen({Key? key, this.notes}) : super(key: key);

  @override
  State<UpdateNotesScreen> createState() => _UpdateNotesScreenState();
}

class _UpdateNotesScreenState extends State<UpdateNotesScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.notes!.title!;
    _contentController.text = widget.notes!.body!;
    id = widget.notes!.id.toString();
  }

  void updateNotes() {
    Notes newNotes = Notes(
      id: int.parse(id),
      title: _titleController.text,
      body: _contentController.text,
    );
    Provider.of<NoteDataProvider>(context, listen: false)
        .updatedNotes(id, newNotes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Number: " + id),
        actions: [
          IconButton(
              onPressed: () {
                // Map data = {
                //   "title": _titleController.toString(),
                //   "body": _contentController.toString()
                // };
                updateNotes();
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
