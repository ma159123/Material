import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motabea/shared/componants/componants.dart';
import 'package:motabea/shared/network/local/shared_preference.dart';

import 'Login.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boardController=PageController();

    void submit(){
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if(value)
          {
            navigateAndfinish(context: context, screen: InformScreen());
          }
      });

    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,

                itemBuilder: (context,index)=>buildBoardingItem(),
                itemCount: 1,
              ),
            ),
            SizedBox(
              height: 40.0,),
            Row(
              children: [
                /*SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: Colors.blue,
                  ),
                  count: 2,
                ),*/
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                   /* if(isLast)
                    {
                      submit();
                    }
                    else{
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve:Curves.fastLinearToSlowEaseIn,
                      );
                    }*/
                   submit();
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem()=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_zfydw4bk.json',),
      ),
      SizedBox(height: 30.0,),
      Text(
        'WELCOME IN FCI',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),
      /*Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),*/
      //SizedBox(height: 15.0,),
    ],
  );

}
