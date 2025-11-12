import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/models/notemodels.dart';
import 'package:note_app/controllers/favouritecontroller.dart';
import 'package:note_app/screens/notedetails.dart';

class Favourite extends StatelessWidget {
  Favourite({super.key});

 final FavouriteController favouriteController = Get.put(FavouriteController());
  final Box favBox = Hive.box('favourites');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite notes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey,
      body: GetBuilder<FavouriteController>(
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: favBox.listenable(),
            builder: (context, value, child) {
              if (favBox.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Colors.black),
                    SizedBox(height: 7),
                    Center(
                      child: Text(
                        'Empty notes',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: favBox.length,
                itemBuilder: (context, index) {
                  NoteModel note = favBox.getAt(index);
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(Notedetails(), arguments: {'note': note, 'fromFavourite': true});
                      },
                      title: Text(note.title, overflow: TextOverflow.ellipsis),
                      subtitle: Text(note.description, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          favouriteController.deleteFavourite(index);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
