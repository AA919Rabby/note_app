import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app/models/notemodels.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/favouritecontroller.dart';
import 'package:share_plus/share_plus.dart';

class Notedetails extends StatefulWidget {
  const Notedetails({super.key});

  @override
  State<Notedetails> createState() => _NotedetailsState();
}

class _NotedetailsState extends State<Notedetails> {
  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    NoteModel note = Get.arguments['note'];
    final bool fromFavourite = Get.arguments['fromFavourite'] ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Note details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions:  fromFavourite
            ? []
            :
        [

          SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: '${note.title}\n\n${note.description}'),
              );
              Fluttertoast.showToast(
                msg: 'Copied to clipboard',
                backgroundColor: Colors.brown,
                textColor: Colors.white,
              );
            },
            child: Icon(Icons.copy, color: Colors.white, size: 19),
          ),

          SizedBox(width: 15),
          Center(
            child: InkWell(
              onTap: () {
                Share.share('${note.title}\n\n${note.description}');
              },
              child: Icon(Icons.share, color: Colors.white, size: 19),
            ),
          ),
          SizedBox(width: 18),
          GestureDetector(
            onTap: () {
              favouriteController.addFavourite(note);
              Fluttertoast.showToast(
                msg: 'Added to favourites',
                backgroundColor: Colors.brown,
              );
            },
            child: Icon(Icons.favorite, color: Colors.white, size: 19),
          ),
          SizedBox(width: 18),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                note.date,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 11,
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                indent: 5,
                endIndent: 5,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  note.description,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
