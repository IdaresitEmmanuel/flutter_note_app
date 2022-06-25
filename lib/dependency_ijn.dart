import 'package:get/get.dart';
import 'package:note_app/services/notification_service.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';
import 'package:note_app/views/notes_page/notes_page_controller.dart';

void init() {
  // controllers
  Get.put(EditPageController());
  Get.put(NotesPageController());
  //services
  Get.put(NotificationService());
}
