import 'package:flutter/cupertino.dart';
import 'package:notesappv2/model/notesmodel.dart';
import 'package:notesappv2/services/notesapiervices.dart';

 

class NoteDataProvider extends ChangeNotifier {
  List<Notes> notesModel = [];
  Notes notes = Notes();

  NoteDataProvider() {
    getAllNotes();
    getSingleItem("3");
  }

  //getAllNotesData
  getAllNotes() async {
    notesModel = await NoteApiServices.getNotes();
    notifyListeners();
  }

  //getSingleItemsData
  getSingleItem(String id) async {
    notes = await NoteApiServices.getSingleItem(id);
    notifyListeners();
  }

  //addNotesData
  void addNotes(Notes notes) async {
    notesModel.add(notes); // 1. this line will add notes to notelist.
    notifyListeners(); // 2. this line will notify and update the ui without loading the screen
    //1 and 2 for update the ui without hiting the api again.
    NoteApiServices.addNotes(notes); // this line will add notes to the server.
    notifyListeners(); // this will update the ui after refresh or hiting the api again.
  }

  //updateNotesData
  void updatedNotes(String id, Notes note) {
    int indexOfNote = notesModel
        .indexOf(notesModel.firstWhere((element) => element.id == note.id));
    notesModel[indexOfNote] = note;
    notifyListeners();
    NoteApiServices.updateNotes(id, note);
    notifyListeners();
  }

  //deleteNotesData
  void deleteNotes(String id, Notes note) {
    int indexOfNote = notesModel
        .indexOf(notesModel.firstWhere((element) => element.id == note.id));
    notesModel.removeAt(indexOfNote);
    notifyListeners();
    NoteApiServices.deleteNotes(id, note);
    notifyListeners();
  }

}
