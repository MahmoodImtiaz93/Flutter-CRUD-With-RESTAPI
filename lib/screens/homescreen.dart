import 'package:flutter/material.dart';
import 'package:notesappv2/model/notesmodel.dart';
import 'package:notesappv2/provider/notedataprovider.dart';
import 'package:notesappv2/screens/addnotes.dart';
import 'package:notesappv2/screens/updatenotescreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String id = '';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final getUserData_provider1 =
  //       Provider.of<User_Data_Provider>(context, listen: false);
  //  // getUserData_provider.getUserData();
  // }
  
  @override
  Widget build(BuildContext context) {
    
    NoteDataProvider notesProvider =
        Provider.of<NoteDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Get api response")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<NoteDataProvider>(
                builder: (context, value, child) {
                  print(value.notesModel.length.toString());
                  return ListView.builder(
                    itemCount: value.notesModel.length,
                    itemBuilder: (context, index) {
                        Notes currentNote = value.notesModel[index];
                        
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateNotesScreen(notes: currentNote),
                              ));
                        },
                        onLongPress: () {
                           showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              "Do you want to delete this note?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                notesProvider
                                                    .deleteNotes(index.toString(), currentNote);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes"),
                                            ),
                                          ],
                                          elevation: 24.0,
                                        ),
                                      );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReusebaleRow(
                                    value: value.notesModel[index].title
                                        .toString(),
                                    title: "Notes : "),
                                ReusebaleRow(
                                    value:
                                        value.notesModel[index].body.toString(),
                                    title: "Body: "),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotesScreen(),
            ),
          );
        },
      ),
    );
  }
}

class ReusebaleRow extends StatelessWidget {
  String title, value;
  ReusebaleRow({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
