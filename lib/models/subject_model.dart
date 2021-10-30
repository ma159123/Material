import 'package:motabea/models/lec_model.dart';

class SubjectLecturesModel {
  List<LecModel> subjectLectures = [];

  SubjectLecturesModel.fromJson(List<Map<String, dynamic>> json) {
    json.forEach((record) {
      subjectLectures.add(LecModel.fromJson(record));
    });
  }
}
