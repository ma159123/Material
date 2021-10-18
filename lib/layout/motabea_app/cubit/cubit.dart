import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motabea/layout/motabea_app/cubit/states.dart';
import 'package:motabea/models/lecture_model.dart';
import 'package:motabea/models/subject_model.dart';
import 'package:motabea/modules/pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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

  List<bool> isVisible=[false,false,false,false];

  void changeVisibility() {
    isVisible[0] = !isVisible[0];
    emit(AppChangeVisibilitySuccessState());
  }

  void changeVisibil() {
    isVisible[1] = !isVisible[1];
    emit(AppChangeVisibilitySuccessState());
  }

  void changeVisib() {
    isVisible[2] = !isVisible[2];
    emit(AppChangeVisibilitySuccessState());
  }

  void changeVisi() {
    isVisible[3] = !isVisible[3];
    emit(AppChangeVisibilitySuccessState());
  }

  SubjectModel? subjectModel;
  List<SubjectModel> listSubject = [
    SubjectModel(
      name: 'math',
      icon: 'assets/images/math.png',

    ),
    SubjectModel(
      name: 'program',
      icon: 'assets/images/programming.png',
    ),
    SubjectModel(
      name: 'english',
      icon: 'assets/images/literature.png',
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
  late List<LectureModel>listLecture=[
    LectureModel(lec_name: lec[0]['lec_name'], lec_date: lec[0]['lec_date'], lec_material: lec[0]['lec_material'],),
    LectureModel(lec_name: lec[1]['lec_name'],  lec_date: lec[1]['lec_date'], lec_material: lec[1]['lec_material'],),
    LectureModel(lec_name: lec[2]['lec_name'],  lec_date: lec[2]['lec_date'], lec_material: lec[2]['lec_material'],),
    LectureModel(lec_name: lec[0]['lec_name'],  lec_date: lec[0]['lec_date'], lec_material: lec[0]['lec_material'],),
    LectureModel(lec_name: lec[1]['lec_name'],  lec_date: lec[1]['lec_date'], lec_material: lec[1]['lec_material'],),
    LectureModel(lec_name: lec[2]['lec_name'],  lec_date: lec[2]['lec_date'], lec_material: lec[2]['lec_material'],),
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

  List lec=[];
void  getLecture()async
{
  //lec=[];
    FirebaseFirestore.instance
      .collection('lectures').get().then((value){
       value.docs.forEach((element) {
        // print(element.data());
         lec.add(element.data());
       //  LectureModel(lec_material: lec[element]['lec_material'], lec_date: '', lec_name: '');
       });

       print(lec.length);
       print( lec[0]['lec_material']);
     }).catchError((error){
       print(error.toString());

    });
}

}