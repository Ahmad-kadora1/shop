// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop/layout/shared/componants/componants.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/local/cash_helper.dart';
import '../../../shared/style/colors.dart';
import '../login_shop/login.dart';

class OnBordingscreen extends StatefulWidget {
  const OnBordingscreen({Key? key}) : super(key: key);

  @override
  State<OnBordingscreen> createState() => _OnBordingscreenState();
}

class _OnBordingscreenState extends State<OnBordingscreen> {
  List<OnBordingModel> bording = [
    OnBordingModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJZNo_0ySdBTwrVphFPl5mPTM0DIC5AIVdJw&usqp=CAU',
        titel: 'on board 1 title',
        body: 'on board 1 body'),
    OnBordingModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJZNo_0ySdBTwrVphFPl5mPTM0DIC5AIVdJw&usqp=CAU',
        titel: 'on board 2 title',
        body: 'on board 2 body'),
    OnBordingModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJZNo_0ySdBTwrVphFPl5mPTM0DIC5AIVdJw&usqp=CAU',
        titel: 'on board 3 title',
        body: 'on board 3 body'),
  ];
  bool islast = false;
  var bordingControler = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextbutton(
            onpress: () {
              submit(context);
            },
            text: 'SKIP',
            // style: TextStyle(fontSize: 20.0, color: Colors.orange),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                controller: bordingControler,
                onPageChanged: (int index) {
                  if (index == bording.length - 1) {
                    setState(() {
                      islast = true;
                    });
                    print('laster');
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardItem(context, bording[index]),
                itemCount: bording.length,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                    controller: bordingControler,
                    count: bording.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      spacing: 5.0,
                      dotWidth: 10,
                      activeDotColor: defaultColor,
                    )),
                const Spacer(),
                FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        submit(context);
                      } else {
                        bordingControler.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardItem(context, OnBordingModel modelon) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(modelon.image),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            modelon.titel,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            // ignore: unnecessary_string_interpolations
            '${modelon.body}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      );
}

void submit(context) {
  CashHelper.saveData(key: 'onBording', value: true).then((value) {
    if (value) {
      navigateAndFinsh(context, LoginScreen());
    }
  });
}

class OnBordingModel {
  String image;
  String titel;
  String body;
  OnBordingModel(
      {required this.image, required this.titel, required this.body});
}
