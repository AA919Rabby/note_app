import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controllers/notecontroller.dart';
import 'package:get/get.dart';
import 'package:note_app/models/notemodels.dart';
import 'package:note_app/screens/notedetails.dart';

class Note extends StatelessWidget {
  Note({super.key});
  TextEditingController titleClt = TextEditingController();
  TextEditingController descriptionClt = TextEditingController();
  NoteController noteController = Get.put(NoteController());
  final Box box=Hive.box('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey,
      body: GetBuilder<NoteController>(
        builder: (context) {
          return box.keys.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note, color: Colors.black),
                    SizedBox(height: 7),
                    Center(
                      child: Text(
                        'Empty notes',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              : ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: box.keys.length,
                      itemBuilder: (context, index) {
                        NoteModel note = box.getAt(index);
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(Notedetails(), arguments: {'note': note});
                            },
                            title: Text(
                              note.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                            tileColor: Colors.white10,
                            subtitle: Text(
                              note.description,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: SizedBox(
                              width: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      titleClt.text = note.title;
                                      descriptionClt.text = note.description;
                                      showAlertDialog(context, index);
                                    },
                                    child: Icon(Icons.edit, color: Colors.brown),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      noteController.deleteNote(index);
                                    },
                                    child: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
              );
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: titleClt,
                    decoration: InputDecoration(hintText: 'Enter a title'),
                  ),
                  TextField(
                    controller: descriptionClt,
                    decoration: InputDecoration(
                      hintText: 'Enter a description',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleClt.text.isNotEmpty &&
                        descriptionClt.text.isNotEmpty) {
                      DateTime now = DateTime.now();
                      String formattedDateTime = DateFormat(
                        'dd MMM yyyy, hh:mm a',
                      ).format(now);
                      String editedDateTime = '$formattedDateTime (Edited)';
                      noteController.updateNote(
                        index,
                        NoteModel(
                          titleClt.text,
                          descriptionClt.text,
                          editedDateTime,
                        ),
                      );
                      Get.back();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
