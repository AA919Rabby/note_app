import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_app/models/notemodels.dart';

class FavouriteController extends GetxController {
  Box favBox = Hive.box('favourites');

  addFavourite(NoteModel note) {
    favBox.add(note);
    update();
  }

  deleteFavourite(int index) {
    favBox.deleteAt(index);
    update();
  }
}
