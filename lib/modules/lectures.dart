import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motabea/layout/motabea_app/cubit/cubit.dart';
import 'package:motabea/layout/motabea_app/cubit/states.dart';
import 'package:motabea/modules/pdf_view.dart';

import '../layout/motabea_app/cubit/cubit.dart';

class LecturesScreen extends StatelessWidget {
  late String image;
  LecturesScreen({required this.image});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MotabeaCubit, MotabeaStates>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        //declarations
        MotabeaCubit cubit = MotabeaCubit.getCubitObj(context);
        // double width = MediaQuery.of(context).size.width;
        //double height = MediaQuery.of(context).size.height;

        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(top: 150.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.0),
                      )),
                  height: double.infinity,
                  width: double.infinity,
                  child: GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: List.generate(
                          cubit.lecturesList.length,
                          (index) => InkWell(
                                child: Card(
                                  elevation: 2.0,
                                  color: HexColor('#43dd86'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          height: 30.0,
                                          width: 30.0,
                                          child: Text(
                                            '${index + 1}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          cubit.lecturesList[index].lec_name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.lecturesList[index]
                                                    .lec_date,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              widthFactor: 0.5,
                                              heightFactor: 0.5,
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.download_for_offline,
                                                    size: 25.0,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  // print(cubit.lecturesList[index].lec_material);
                                  await cubit.loadNetwork(
                                      'https://dl.dropboxusercontent.com/s/4xpn83yrebdcngo/Programming%202%20-%20Lecture%203.pdf?dl=0');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfView(
                                        path: cubit.filePath,
                                      ),
                                    ),
                                  );

                                  // print(
                                  //     '************** ${cubit.lec[index]['lec_material']}');
                                  print(
                                      '******filepath******** ${cubit.filePath}');
                                },
                              ))),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
