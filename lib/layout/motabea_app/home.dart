import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motabea/layout/motabea_app/cubit/cubit.dart';
import 'package:motabea/layout/motabea_app/cubit/states.dart';
import 'package:motabea/modules/lectures.dart';
import 'package:motabea/shared/componants/componants.dart';

class MaterialHomeScreen extends StatelessWidget {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    MotabeaCubit cubit = MotabeaCubit.getCubitObj(context);
    // List<bool> isVisible=[cubit.isVisible[0],cubit.isVisible[1],cubit.isVisible[2],cubit.isVisible[3]];

    return BlocProvider(
      create: (BuildContext context) => MotabeaCubit()..createDatabase(),
      // ..getTopics(),
      child: BlocConsumer<MotabeaCubit, MotabeaStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Materials'),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.blueGrey,
                      Colors.black45,
                    ])),
                    child: Column(
                      children: [
                        Material(
                          borderRadius:
                              BorderRadius.all(Radius.circular(200.0)),
                          elevation: 15.0,
                          child: Image(
                            image: NetworkImage(
                              'https://cdn0.iconfinder.com/data/icons/online-education-butterscotch-vol-2/512/Learning_Material-512.png',
                            ),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'MATERIALS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  buildDrawerItem(
                      onTap: () {
                        cubit.changeVisibility();
                        //  print(isVisible[0]);
                      },
                      title: 'Level one'),
                  buildVisibleDrawerItem(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialHomeScreen(),
                            ));
                      },
                      title: 'general',
                      isVisible: cubit.isVisible[0]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'bio',
                      isVisible: cubit.isVisible[0]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'AI',
                      isVisible: cubit.isVisible[0]),
                  buildDrawerItem(
                      onTap: () {
                        cubit.changeVisibil();
                      },
                      title: 'Level two'),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'general',
                      isVisible: cubit.isVisible[1]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'bio',
                      isVisible: cubit.isVisible[1]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'AI',
                      isVisible: cubit.isVisible[1]),
                  buildDrawerItem(
                      onTap: () {
                        cubit.changeVisib();
                      },
                      title: 'Level three'),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'general',
                      isVisible: cubit.isVisible[2]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'bio',
                      isVisible: cubit.isVisible[2]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'AI',
                      isVisible: cubit.isVisible[2]),
                  buildDrawerItem(
                      onTap: () {
                        cubit.changeVisi();
                      },
                      title: 'Level four'),
                  /* Padding(
                    padding: const EdgeInsets.all( 10.0),
                    child: Row(
                      children: [
                        buildVisibleBottom(
                            onPressed: () {},
                            title: 'term 1',
                            isVisible: cubit.isVisible[0], height: 50, width:130),

                        buildVisibleBottom(
                            onPressed: () {},
                            title: 'term 2',
                            isVisible: cubit.isVisible[0], height: 50, width:130),
                      ],
                    ),
                  ),*/
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'general',
                      isVisible: cubit.isVisible[3]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'bio',
                      isVisible: cubit.isVisible[3]),
                  buildVisibleDrawerItem(
                      onPressed: () {},
                      title: 'AI',
                      isVisible: cubit.isVisible[3]),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image(
                        image: NetworkImage(
                            'https://assets.materialstoday.com/wpimg/snippet/f30c230a-79d6-4520-b14e-875a6490d31e.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 1.0,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1.2 / 1.2,
                    children: List.generate(
                      cubit.listSubject.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            // print(MotabeaCubit.getCubitObj(context)
                            //   .assetsPdf[index]);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => PdfView(
                            //           path: MotabeaCubit.getCubitObj(context)
                            //               .assets[index]),
                            //     ));
                            //if(cubit.ll.length==0)
                            cubit.getLec(index);
                            //  if(cubit.lec.length!=0)
                            navigateTo(
                                context: context,
                                screen: LecturesScreen(
                                  image:
                                      'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/c5/97/t-t-2249-materials-display-banner_ver_2.jpg',
                                ));
                          },
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white,
                                shadowColor: Colors.blueGrey.withOpacity(0.8),
                                elevation: 4.0,
                                child: Image(
                                  image:
                                      AssetImage(cubit.listSubject[index].icon),
                                  width: 200,
                                  height: 100,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  cubit.listSubject[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget customListTile(context, String title, Function() onTap) => Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: Column(
          children: [
            InkWell(
              splashColor: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_right,
                      size: 40.0,
                    ),
                  ],
                ),
              ),
              onTap: onTap,
            ),
            Visibility(
              visible: isVisible,
              child: InkWell(
                splashColor: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_right,
                        size: 40.0,
                      ),
                    ],
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ],
        ),
      );
}
