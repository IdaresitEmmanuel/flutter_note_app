import 'package:get/get.dart';
import 'package:note_app/core/date_time_extensions.dart';

class TimeController {
  String hours;
  String minute;
  bool isPM;
  RxBool shouldValidate = false.obs;
  RxString errorString = "".obs;
  TimeController({
    this.hours = "0",
    this.minute = "0",
    this.isPM = false,
  });

  void setHours(String h) {
    hours = h;
    validate();
  }

  void computeHours(int h) {
    if (h >= 12) {
      isPM = true;
    } else {
      isPM = false;
    }
    int tempHour = h > 12 ? h - 12 : (h == 0 ? h + 12 : h);
    hours = tempHour.toString();
  }

  void setMinutes(String m) {
    minute = m;
    validate();
  }

  void setSetShouldValidate(bool b) {
    shouldValidate.value = b;
  }

  bool validate() {
    if (hours.isEmpty || minute.isEmpty) {
      errorString.value = "Fields cannot be empty";
      return false;
    }
    if (int.parse(hours) < 1 ||
        int.parse(hours) > 12 ||
        int.parse(minute) > 59) {
      errorString.value = "invalid value";
      return false;
    }
    errorString.value = "";
    return true;
  }

  bool isValidated() {
    shouldValidate.value = true;
    return validate();
  }

  DateTime getTime() {
    int h = int.parse(hours);
    int m = int.parse(minute);
    if (isPM && h != 12) {
      h += 12;
    } else if (!isPM && h == 12) {
      h -= 12;
    }
    return DateTime.now().copyWith(hour: h == 24 ? 0 : h, minute: m);
  }
}
