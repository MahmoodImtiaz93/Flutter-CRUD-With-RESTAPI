import 'dart:convert';

 
import 'package:http/http.dart' as http;
import 'package:notesappv2/model/notesmodel.dart';

class NoteApiServices {
  // get all notes
  static Future<List<Notes>> getNotes() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/notes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final item = jsonDecode(response.body)['notes'] as List;
    List<Notes> notesModel = [];

    for (var i in item) {
      Notes notes = Notes.fromJson(i);
      notesModel.add(notes);
    }
    return notesModel;
  }

  //get single note items
  static Future<Notes> getSingleItem(String id) async {
    Notes notes;

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/notes/get/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      notes = Notes.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
    return notes;
  }

  //add notes
  static Future<Notes> addNotes(Notes notes) async {
    Map data = {'title': notes.title, 'body': notes.body};
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/notes/add'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      return Notes.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create note.');
    }
  }

  //update notes
  static Future<Notes> updateNotes(String id, Notes notes) async {
    Map data = {'title': notes.title, 'body': notes.body};

    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/notes/update/$id'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Notes.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  //delete notes
  static Future<void> deleteNotes(String id, Notes notes) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/api/notes/delete/$id'),
    );
    if (response.statusCode == 200) {
      print("Notes Deleted");
    } else {
      throw Exception('Failed to delet the Notes');
    }
  }

}
