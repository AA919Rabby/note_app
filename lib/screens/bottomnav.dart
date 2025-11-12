import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controllers/notecontroller.dart';
import 'package:note_app/models/notemodels.dart';
import 'package:note_app/screens/favourite.dart';
import 'package:note_app/screens/note.dart';
import 'package:get/get.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  NoteController noteController = Get.put(NoteController());
  TextEditingController titleClt = TextEditingController();
  TextEditingController descriptionClt = TextEditingController();
  int currentIndex = 0;
  List pages = [Note(), Favourite()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.brown,
        child: Icon(Icons.add, color: Colors.white, size: 27),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note, color: Colors.brown),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.brown),
            label: 'Favourite',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
  showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Center(child: Text('Create a note')),
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
                      String formattedDateTime = DateFormat('dd MMM yyyy, hh:mm a').format(now);
                      noteController.addNote(
                        NoteModel(
                          titleClt.text,
                          descriptionClt.text,
                            formattedDateTime
                        ),
                      );
                      Get.back();
                    titleClt.clear();
                    descriptionClt.clear();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
