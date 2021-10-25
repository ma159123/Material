import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motabea/layout/motabea_app/cubit/cubit.dart';
import 'package:motabea/layout/motabea_app/cubit/states.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  final String path;
  const PdfView({Key? key, required this.path}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    // final name=basename(widget.path);
    int totalPages = 0;
    int currentPage = 0;
    bool pdfReady = false;
    // PDFViewController pdfViewController=0 as PDFViewController;
    return BlocConsumer<MotabeaCubit, MotabeaStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context,  state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('my pdf'),
            ),
            body: SfPdfViewer.asset(widget.path));
      },
    );
  }
}

/*Stack(
children: [
PDFView(
filePath: path,
autoSpacing: true,
enableSwipe: true,
pageSnap: true,
swipeHorizontal: true,
onError: (error){
print(error.toString());
},
onRender: (pages){
setState(() {
totalPages=pages!;
pdfReady=true;
});
},
onViewCreated: (PDFViewController vs){
// pdfViewController=vs;
},
onPageChanged: (int? page,int? total){
setState(() {

});
},

onPageError: (page,error){

},
),
!pdfReady?Center(child: CircularProgressIndicator()):Offstage()

],

) ,
floatingActionButton: Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
currentPage>0?FloatingActionButton.extended(
backgroundColor: Colors.red,
label: Text('Go to ${currentPage-1}'),
onPressed: () {
currentPage-=1;
// pdfViewController.setPage(currentPage);
},
):Offstage(),

currentPage<totalPages?FloatingActionButton.extended(
backgroundColor: Colors.green,
label: Text('Go to ${currentPage+1}'),
onPressed: () {
currentPage+=1;
//  pdfViewController.setPage(currentPage);
},
):Offstage(),
],
),*/
