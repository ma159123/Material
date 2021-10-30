import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motabea/layout/motabea_app/cubit/states.dart';
import 'package:motabea/models/lec_model.dart';
import 'package:motabea/models/lecture_model.dart';
import 'package:motabea/models/subject_model.dart';
import 'package:motabea/models/topics_model.dart';
import 'package:motabea/modules/pdf_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class MotabeaCubit extends Cubit<MotabeaStates> {
  MotabeaCubit() : super(MotabeaInitialState());

  static MotabeaCubit getCubitObj(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;
  List<String> titles = [
    'level one',
    'level two',
    'level three',
    'level four',
  ];

  List<bool> isVisible = [false, false, false, false];

  void changeVisibility() {
    isVisible[0] = !isVisible[0];
    // print(isVisible[0]);
    emit(AppChangeVisibilitySuccessState());
  }

  void changeVisibil() {
    isVisible[1] = !isVisible[1];
    emit(AppChangeVisibilSuccessState());
  }

  void changeVisib() {
    isVisible[2] = !isVisible[2];
    emit(AppChangeVisibSuccessState());
  }

  void changeVisi() {
    isVisible[3] = !isVisible[3];
    emit(AppChangeVisiSuccessState());
  }

  SubjectModel? subjectModel;
  List<SubjectModel> listSubject = [
    SubjectModel(
      name: 'English',
      icon: 'assets/images/literature.png',
    ),
    SubjectModel(
      name: 'programmig',
      icon: 'assets/images/programming.png',
    ),
    SubjectModel(
      name: 'math',
      icon: 'assets/images/math.png',
    ),
    SubjectModel(
      name: 'physics',
      icon: 'assets/images/relativity.png',
    ),
    SubjectModel(
      name: 'business',
      icon: 'assets/images/corporate.png',
    ),
    SubjectModel(
      name: 'chemistry',
      icon: 'assets/images/test-tube.png',
    ),
  ];

  LectureModel? lectureModel;
  late List<LectureModel> listLecture = [
    LectureModel(
      lec_name: lec[0]['lec_name'],
      lec_date: lec[0]['lec_date'],
      lec_material: lec[0]['lec_material'],
    ),
    LectureModel(
      lec_name: lec[1]['lec_name'],
      lec_date: lec[1]['lec_date'],
      lec_material: lec[1]['lec_material'],
    ),
    LectureModel(
      lec_name: lec[2]['lec_name'],
      lec_date: lec[2]['lec_date'],
      lec_material: lec[2]['lec_material'],
    ),
    LectureModel(
      lec_name: lec[0]['lec_name'],
      lec_date: lec[0]['lec_date'],
      lec_material: lec[0]['lec_material'],
    ),
    LectureModel(
      lec_name: lec[1]['lec_name'],
      lec_date: lec[1]['lec_date'],
      lec_material: lec[1]['lec_material'],
    ),
    LectureModel(
      lec_name: lec[2]['lec_name'],
      lec_date: lec[2]['lec_date'],
      lec_material: lec[2]['lec_material'],
    ),
  ];

  List<String> assetsPdf = [
    'https://l.facebook.com/l.php?u=https%3A%2F%2Fwww.dropbox.com%2Fs%2F4xpn83yrebdcngo%2Fprogramming%25202%2520-%2520lecture%25203.pdf%3Fdl%3D0%26fbclid%3DIwAR2tDHoZuC2pTIlGZXdOETzC1TWeJsxnBYrWVvUiVNMHUYQYCfurd7FL_f0&h=AT1DVZMOB_H81TwbEHQAJz4tP_fwIpbDUwf30PTCEGDVe-3LhRyMr2ZZ5TmTZWalXj33G1B4TlR5u7gH4lUrbt-jbCP_gcdBUZgY4J3GyWkHW_eydK-jTN1DM-d-gMV-dXhaIg',
    'https://l.facebook.com/l.php?u=https%3A%2F%2Fwww.dropbox.com%2Fs%2Fotkcczahm7cqggc%2Fprogramming%25202%2520-%2520lecture%25205.pdf%3Fdl%3D0%26fbclid%3DIwAR1x4WKaQnT8ph4RlBQK-CYGVMdclHE3zPN0wYiGIzSRKCjTThGwDlS71qU&h=AT1DVZMOB_H81TwbEHQAJz4tP_fwIpbDUwf30PTCEGDVe-3LhRyMr2ZZ5TmTZWalXj33G1B4TlR5u7gH4lUrbt-jbCP_gcdBUZgY4J3GyWkHW_eydK-jTN1DM-d-gMV-dXhaIg',
    'assets/pdfs/Book List.pdf',
    'assets/pdfs/week 1.pdf',
    'assets/pdfs/2d_array_sheet.pdf.docx',
    'assets/pdfs/English Worksheet.pdf.lnk',
  ];

  /*Future<File>loadNetwork(Uri url)async
  {
    final response= await http.get(url);
    final bytes= response.bodyBytes;
    return storeFile(url,bytes);
  }
  static Future<File> storeFile(Uri url, List<int>bytes)async
  {
    final filename=basename(url as String);
    final dir= await getApplicationDocumentsDirectory();

    final file=File('${dir.path}/$filename}');
    await file.writeAsBytes(bytes,flush: true);
    return file;
  }*/

  void openPdf(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PdfView(
                  path: '',
                )),
      );

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/week1.pdf');
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (error) {
      throw Exception('error opening asset file');
    }
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url as Uri);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/week1.pdf');
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (error) {
      throw Exception('error opening url file');
    }
  }

  List lec = [];

  void getLecture() async {
    //lec=[];
    FirebaseFirestore.instance.collection('lectures').get().then((value) {
      value.docs.forEach((element) {
        // print(element.data());
        lec.add(element.data());
        //  LectureModel(lec_material: lec[element]['lec_material'], lec_date: '', lec_name: '');
      });
      emit(GetLectureSuccessState());
      print(lec.length);
      // print( lec[0]['lec_material']);
    }).catchError((error) {
      print(error.toString());
      emit(GetLectureErrorState());
    });
  }

  /*late List<LecModel> listLec = [
    LecModel(
      cs: '', english: '', math: '', ethics: '', physics: '', programming: '',
    ),
    LecModel(
      cs: '', english: '', math: '', ethics: '', physics: '', programming: '',
    ),
    LecModel(
      cs: '', english: '', math: '', ethics: '', physics: '', programming: '',
    ),
    LecModel(
      cs: '', english: '', math: '', ethics: '', physics: '', programming: '',
    ),
    LecModel(
      cs: '', english: '', math: '', ethics: '', physics: '', programming: '',
    ),
    LecModel(
      cs: '', english: '', math: '', ethics: '', physics: '', programming: '',
    ),
  ];*/

  List<LecModel> lecturesList = [];
  List lecture = ['English', 'Programming'];

  void getLec(int index) async {
    lecturesList = [];
    FirebaseFirestore.instance.collection(lecture[index]).get().then((value) {
      value.docs.forEach((element) {
        lecturesList.add(LecModel.fromJson(element.data()));
      });
      emit(GetLecSuccessState());
      print(lecturesList.length);
    }).catchError((error) {
      print(error.toString());
      emit(GetLecErrorState());
    });
  }

  Future<String> downloadFile(String url, String fileName) async {
    var dirDictionary = await getApplicationDocumentsDirectory();
    String dir = dirDictionary.path;
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url + '/' + fileName;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  String filePath = "";

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    filePath = file.path;
    return file;
  }

  ///
  ///

  Database? dataB;
  List<TopicsModel> topicsLocal = [];

  // Map<String,TopicsModel> topics = {};
  // Map<String, List<LecModel>> subjects = {};
  List<LecModel> englishLocal = [];

  void createDatabase() {
    openDatabase(
      'materials.db',
      version: 1,
      onCreate: (dataB, version) async {
        // id integer
        // title String
        // date String
        // time String
        // status String

        //creating topics table
        await dataB
            .execute(
                'CREATE TABLE topics (id INTEGER PRIMARY KEY, topic_grade INTEGER, topic_term INTEGER, topic_name TEXT)')
            .then((value) {
          print(' topic table created');
        }).catchError((error) {
          print('Error When Creating topic Table ${error.toString()}');
        });

        getTopicsNames();
        //creating subjects table
        await dataB
            .execute(
                'CREATE TABLE English (id INTEGER PRIMARY KEY, lec_date TEXT, lec_material TEXT, lec_name TEXT, isDownloaded BOOLEAN)')
            .then((value) {
          print('English table created');
        }).catchError((error) {
          print('Error When Creating English Table ${error.toString()}');
        });

        print('database created');
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        saveFirestoreTopicsToSqflite();
        getEnglish();
        print('database opened');
      },
    ).then((value) {
      dataB = value;
      emit(AppCreateDatabaseState());
    });
  }

  fun() {} //to avoid Future txn return type

  // topic_grade INTEGER, topic_term INTEGER, topic_name TEXT
  insertToTopics({
    required int topic_grade,
    required int topic_term,
    required String topic_name,
  }) async {
    await dataB!.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO topics(topic_grade, topic_term, topic_name) VALUES("$topic_grade", "$topic_term", "$topic_name")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(dataB!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return Future.delayed(Duration(microseconds: 1));
    });
  }

  // lec_date TEXT, lec_material TEXT, lec_name TEXT, isDownloaded BOOLEAN

  insertToEnglish({
    String lec_date = '',
    required String lec_material,
    required String lec_name,
    bool isDownloaded = false,
  }) async {
    await dataB!.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO English(lec_date, lec_material, lec_name, isDownloaded) VALUES("$lec_date", "$lec_material", "$lec_name", $isDownloaded)',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(dataB!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    return  Future.delayed(const Duration(microseconds: 1), (){});
      // return Future(fun());
    });
  }

  void getDataFromDatabase(Database dataB) async{
    topicsLocal = [];
    englishLocal = [];

    emit(AppGetDatabaseLoadingState());

    // returns a List<Map>  = Json or table ,,,
    // map<String, dynamic> = record
   await dataB.rawQuery('SELECT * FROM topics').then((recordsJson) {
      recordsJson.forEach((record) {
        topicsLocal.add(TopicsModel.fromJson(record));
        print('record*********** $record');
        print('recordFromLocal*********** ${topicsLocal[0].topic_name}');
      });

      emit(AppGetDatabaseState());
    });

    await dataB.rawQuery('SELECT * FROM English').then((recordsJson) {
      recordsJson.forEach((record) {
        englishLocal.add(LecModel.fromJson(record));
        print('record*********** $record');
        print('recordFromLocal*********** ${englishLocal[0].lec_material}');
      });

      emit(AppGetDatabaseState());
    });




}


  // void updateData({
  //   @required String status,
  //   @required int id,
  // }) async {
  //   database.rawUpdate(
  //     'UPDATE tasks SET status = ? WHERE id = ?',
  //     ['$status', id],
  //   ).then((value) {
  //     getDataFromDatabase(database);
  //     emit(AppUpdateDatabaseState());
  //   });
  // }

  // void deleteData({
  //   @required int id,
  // }) async {
  //   database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
  //     getDataFromDatabase(database);
  //     emit(AppDeleteDatabaseState());
  //   });
  // }

  void saveFirestoreTopicsToSqflite() async {
    FirebaseFirestore.instance.collection('topics').get().then((json) {
      json.docs.forEach((record) {
        topicsNames.add(record.data()['topic_name']);
        insertToTopics(
            topic_grade: record.data()['topic_grade'],
            topic_term: record.data()['topic_term'],
            topic_name: record.data()['topic_name']);
        // topicsList.add(TopicsModel.fromJson(record.data()));
        // print('************** record.data() ${record.data()}');
        // print('************** topicsmodel ${topicsList[0].topic_grade}');
        // print('recordFromLocal*********** ${topics[0].topic_name}');
      });
      emit(GetTopicSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTopicErrorState());
    });
  }

  List topicsNames = [];
  void getTopicsNames() async {
    topicsNames = [];
    FirebaseFirestore.instance.collection('topics').get().then((json) {
      json.docs.forEach((record) {
        topicsNames.add(record.data()['topic_name']);
      });
      emit(GetTopicsNamesErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTopicsNamesErrorState());
    });
  }



  // List<LecModel> englishLectures = [];

  void getEnglish() async {
    // englishLectures = [];
    FirebaseFirestore.instance.collection('English').get().then((json) {
      json.docs.forEach((record) {
        insertToEnglish(
            lec_material: record.data()['lec_material'],
            lec_name: record.data()['lec_name'],
            lec_date: record.data()['lec_date']);
        // topicsList.add(TopicsModel.fromJson(record.data()));
        // print('************** record.data() ${record.data()}');
        // print('************** topicsmodel ${topicsList[0].topic_grade}');
        // print('recordFromLocal*********** ${topics[0].topic_name}');
      });
      emit(GetSubjectSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSubjectErrorState());
    });
  }
}
