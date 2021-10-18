import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:motabea/layout/motabea_app/cubit/cubit.dart';
import 'package:motabea/layout/motabea_app/cubit/states.dart';
import 'package:motabea/layout/motabea_app/home.dart';
import 'package:motabea/shared/componants/componants.dart';
import 'package:motabea/shared/network/local/shared_preference.dart';

class InformScreen extends StatelessWidget {
  const InformScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MotabeaCubit(),
      child: BlocConsumer<MotabeaCubit, MotabeaStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          MotabeaCubit cubit = MotabeaCubit.getCubitObj(context);
          List<bool> isVisible=[cubit.isVisible[0],cubit.isVisible[1],cubit.isVisible[2],cubit.isVisible[3]];

          void submit(){
            CacheHelper.saveData(key: 'isLogin', value: true).then((value) {
              if(value)
              {
                navigateAndfinish(context: context, screen: MaterialHomeScreen());
              }
            });

          }
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('WELCOME')),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Lottie.network(
                            'https://assets9.lottiefiles.com/private_files/lf30_TBKozE.json')
                        ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'what your level',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildLoginBottom(
                      onPressed: () {
                        cubit.changeVisibility();
                      },
                      title: 'level one'),
                  SizedBox(
                    height: 15,
                  ),
                  buildVisibleBottom(
                      onPressed: () {
                        submit();
                      /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialHomeScreen(),
                            ));*/
                      },
                      title: 'general',
                      isVisible: isVisible[0]),
                  buildVisibleBottom(
                      onPressed: () async {},
                      title: 'bio',
                      isVisible: isVisible[0]),
                  buildVisibleBottom(
                      onPressed: () {
                      /*  MotabeaCubit.getCubitObj(context)
                            .getFileFromAsset('assets/images/week 1.pdf')
                            .then((value) {});*/
                      }, title: 'AI', isVisible: isVisible[0]),
                  buildLoginBottom(
                      onPressed: () {
                        cubit.changeVisibil();
                      },
                      title: 'level two'),
                  SizedBox(
                    height: 15,
                  ),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'general', isVisible: isVisible[1]),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'bio', isVisible: isVisible[1]),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'AI', isVisible: isVisible[1]),
                  buildLoginBottom(
                      onPressed: () {
                        cubit.changeVisib();
                      },
                      title: 'level three'),
                  SizedBox(
                    height: 15,
                  ),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'general', isVisible: isVisible[2]),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'bio', isVisible: isVisible[2]),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'AI', isVisible: isVisible[2]),
                  buildLoginBottom(
                      onPressed: () {
                        cubit.changeVisi();
                      },
                      title: 'level four'),
                  SizedBox(
                    height: 15,
                  ),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'general', isVisible: isVisible[3]),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'bio', isVisible: isVisible[3]),
                  buildVisibleBottom(
                      onPressed: () {}, title: 'AI', isVisible: isVisible[3]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
