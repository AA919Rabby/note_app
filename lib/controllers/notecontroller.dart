import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_app/models/notemodels.dart';


class NoteController extends GetxController {
  final Box box=Hive.box('notes');
  addNote(NoteModel note) {
    box.add(note);
    update();
  }

  deleteNote(int index) {
   box.deleteAt(index);
    update();
  }

  updateNote( int index,NoteModel note) {
    box.putAt(index,note);
    update();
  }
}
