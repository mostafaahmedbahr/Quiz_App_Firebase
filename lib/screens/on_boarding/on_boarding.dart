import 'package:flutter/material.dart';

import '../start/start.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemCount: demoData.length,
                  itemBuilder: (context, index) => onBoardingContent(
                    title: demoData[index].title,
                    image: demoData[index].image,
                    describtion: demoData[index].describtion,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demoData.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 45,
                    width: 159,
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(164, 94, 217, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: GestureDetector(
                        child: Text(
                          'Continue',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyStartPage()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: FractionallySizedBox(
              //     widthFactor: 0.9,
              //     child: Image.asset('asset/image/cu.png'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: isActive ? Colors.purple[300] : Colors.purple[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}

class Onboard {
  final String title, image, describtion;

  Onboard({
    required this.title,
    required this.image,
    required this.describtion,
  });
}

final List<Onboard> demoData = [
  Onboard(
    title: ' Welcome To\nEduEval',
    image: 'asset/image/frame.png',
    describtion:
    'This is an online tool that allows student\nto take tests and assessments\nin a virtual environment',
  ),
  Onboard(
    title: ' Examination&\nQuizes',
    image: 'asset/image/Group.png',
    describtion: 'You can have your test any time and \nevery where..',
  ),
  Onboard(
    title: ' See Your\nStudy Progress',
    image: 'asset/image/Illustration.png',
    describtion:
    'Edu Eval provide with a variety tools that help\nstudents to track their completion of\nassignments and assessments,',
  ),
];

class onBoardingContent extends StatelessWidget {
  const onBoardingContent({
    Key? key,
    required this.title,
    required this.image,
    required this.describtion,
  }) : super(key: key);

  final String title, image, describtion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: const Color.fromRGBO(88, 17, 142, 1),
            fontFamily: 'Poppins-Bold',
          ),
        ),
        const Spacer(),
        Image.asset(
          image,
          height: 200,
        ),
        const Spacer(),
        Text(
          describtion,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.purple,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}






// import 'package:flutter/material.dart';
//
// class OnBoarding extends StatefulWidget {
//   const OnBoarding({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoarding> createState() => _OnBoardingState();
// }
//
// class _OnBoardingState extends State<OnBoarding> {
//   late PageController _pageController;
//   int _pageIndex = 0;
//
//   @override
//   void initState() {
//     _pageController = PageController(initialPage: 0);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _pageIndex = index;
//                     });
//                   },
//                   itemCount: demo_data.length,
//                   itemBuilder: (context, index) => onBoardingContent(
//                     title: demo_data[index].title,
//                     image: demo_data[index].image,
//                     describtion: demo_data[index].describtion,
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   ...List.generate(
//                     demo_data.length,
//                         (index) => Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: DotIndicator(
//                         isActive: index == _pageIndex,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   SizedBox(
//                     height: 45,
//                     width: 159,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.ease);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Color.fromRGBO(164, 94, 217, 1),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         'Continue',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline6!
//                             .copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
//                   child: Image.asset(
//                     'asset/image/cu.png',
//                     height: 50,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DotIndicator extends StatelessWidget {
//   const DotIndicator({
//     Key? key,
//     required this.isActive,
//   }) : super(key: key);
//
//   final bool isActive;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: 10,
//       width: 10,
//       decoration: BoxDecoration(
//         color: isActive ? Color.fromRGBO(164, 94, 217, 1) : Colors.grey[400],
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }
// }
//
// class Onboard {
//   final String title, image, describtion;
//
//   Onboard({
//     required this.title,
//     required this.image,
//     required this.describtion,
//   });
// }
//
// final List<Onboard> demo_data = [
//   Onboard(
//     title: 'Welcome To\nEduEval',
//     image: 'asset/image/frame.png',
//     describtion:
//     'This is an online tool that allows students\nto take tests and assessments\nin a virtual environment',
//   ),
//   Onboard(
//     title: 'Examination&\nQuizes',
//     image: 'asset/images/Group.png',
//     describtion: 'You can have your test any time and \neverywhere..',
//   ),
//   Onboard(
//     title: 'See Your\nStudy Progress',
//     image: 'asset/image/Illustration.png',
//     describtion:
//     'Edu Eval provides a variety of tools that help\nstudents track their completion of\nassignments and assessments.',
//   ),
// ];
//
// class onBoardingContent extends StatelessWidget {
//   const onBoardingContent({
//     Key? key,
//     required this.title,
//     required this.image,
//     required this.describtion,
//   }) : super(key: key);
//
//   final String title, image, describtion;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: 50),
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headline4!.copyWith(
//             fontFamily: 'Poppins-Bold',
//             color: Color.fromRGBO(88, 17, 142, 1),
//           ),
//         ),
//         SizedBox(height: 50),
//         Image.asset(
//           image,
//           height: _getImageHeight(context, image),
//         ),
//         SizedBox(height: 50),
//         Text(
//           describtion,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             fontFamily: 'Poppins-Medium',
//             color: Color.fromRGBO(46, 5, 78, 1),
//           ),
//         ),
//       ],
//     );
//   }
//
//   double _getImageHeight(BuildContext context, String image) {
//     double height = 0;
//     if (image.isNotEmpty) {
//       try {
//         height = MediaQuery.of(context).size.height / 2;
//       } catch (e) {
//         print(e);
//       }
//     }
//     return height;
//   }
// }













//
//
//
//
//
//
// import 'package:flutter/material.dart';
//
// class OnBoarding extends StatefulWidget {
//   const OnBoarding({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoarding> createState() => _OnBoardingState();
// }
//
// class _OnBoardingState extends State<OnBoarding> {
//   late PageController _pageController;
//   int _pageIndex=0;
//   @override
//   void initState() {
//     _pageController=PageController(initialPage: 0);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index){
//                     setState(() {
//                       _pageIndex=index;
//                     });
//                   },
//                   itemCount: demo_data.length,
//                   itemBuilder:(context,index)=> onBoardingContent(
//                     title:demo_data[index].title,
//                     image: demo_data[index].image,
//                     describtion:demo_data[index].describtion,
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   ...List.generate(demo_data.length, (index) => Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: DotIndicator(isActive: index==_pageIndex,),
//                   )),
//                   const Spacer(),
//                   SizedBox(
//                     height: 40,
//                     width: 150,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.ease);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.purple[300],
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
//                       child: Text('Continue',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DotIndicator extends StatelessWidget {
//   const DotIndicator({
//     super.key, this.isActive=false,
//   });
//   final bool isActive;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: 10,
//       width: 10,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.purple[300]:Colors.purple[200],
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }
// }
// class Onboard{
//   final String title,image,describtion;
//
//   Onboard({required this.title, required this.image, required this.describtion});
// }
// final List<Onboard> demo_data=[
//   Onboard(
//       title:' Welcome To\nEduEval',
//       image: 'asset/image/frame.png',
//       describtion: 'This is an online tool that allows student\nto take tests and assessments\nin a virtual environment'),
//   Onboard(
//       title:' Examination&\nQuizes' ,
//       image: 'asset/image/Group.png',
//       describtion: 'You can have your test any time and \nevery where..'),
//   Onboard(
//       title:' See Your\nStudy Progress' ,
//       image: 'asset/image/Illustration.png',
//       describtion: 'Edu Eval provide with a variety tools that help\nstudents to track their completion of\nassignments and assessments,'),
// ];
// class onBoardingContent extends StatelessWidget {
//   const onBoardingContent({
//     super.key, required this.title, required this.image, required this.describtion,
//   });
//   final String title,image,describtion;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Spacer(),
//         Text(title,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.purple[300]),
//         ),
//         const Spacer(),
//         Image.asset(image,height: 200,),
//         const Spacer(),
//         Text(describtion,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.purple),
//         ),
//         const Spacer(),
//       ],
//     );
//   }
// }