import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/layout/cubit/cubit.dart';
import 'package:quiz_app_new/screens/student_home/cubit/states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
 import '../../Sh/shared_pref.dart';
import '../../core/toast/toast_states.dart';
import '../../models/fav_model.dart';
import '../fav/cubit/cubit.dart';
import '../layout/nav_bar.dart';
import '../../conctant.dart';
import '../student_exams/examas.dart';
import '../students_lectuers/lecture_screen.dart';
import '../test_bank/test_bank.dart';
import 'cubit/cubit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    StudentHomeCubit.get(context).getAllVideos();
    super.initState();
  }
  String? urlVideo;
  YoutubePlayerController? controller;
  g({
    required String url,
  }){
    final videoId = YoutubePlayer.convertUrlToId("$url");
    controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<StudentHomeCubit,StudentHomeStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var cubit = StudentHomeCubit.get(context);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.only(right: 20),
              //   child: IconButton(
              //     onPressed: () {
              //       Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(
              //           builder: (BuildContext context) => const StudentProfile(),
              //         ),
              //       );
              //     },
              //     icon: const Icon(
              //       Icons.account_circle,
              //       color: kPrimartColor,
              //       size: 50,
              //     ),
              //     constraints: const BoxConstraints(minWidth: 0),
              //   ),
              // ),
              const TitleWithMoreBtn(
                title: 'WELCOME',
              ),
              const SizedBox(height: 10),
              if(cubit.studentProfileModel!=null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConditionalBuilder(
                      condition: state is ! GetStudentProfileDataLoadingState,
                      fallback: (context)=>Center(
                        child: CircularProgressIndicator(
                          color: myColor,
                        ),
                      ),
                      builder: (context){
                        return Padding(
                          padding:const EdgeInsets.only(left: kDefaultPadding / 4),
                          child: Text(
                            cubit.studentProfileModel!.name!=null ?
                            "${cubit.studentProfileModel!.name}" :
                            'Shimaa Ahmed',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20,bottom: 20),
                      child: IconButton(
                        onPressed: () {
                          NavBarCubit.currentIndex=2;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const Layout(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.account_circle,
                          color: kPrimartColor,
                          size: 50,
                        ),
                        constraints: const BoxConstraints(minWidth: 0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimartColor.withOpacity(0.23)),
                    ]),
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: kPrimartColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: const Icon(
                            Icons.search,
                            color: kPrimartColor,
                          )),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              const TitleWithMoreBtn(
                title: 'Categories',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) => const TextBankScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 40,
                                color: kPrimartColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/test-bank.png',
                                width: 40,
                                height: 42,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                              const Text(
                                'Test Bank',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) => const Examas()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimartColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/exam_h.png',
                                width: 40,
                                height: 42,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                              const Text(
                                'Exams',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) => const Lecture()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimartColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/image/lec.png',
                                width: 40,
                                height: 42,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: kDefaultPadding / 2),
                              Text(
                                'Lecture',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TitleWithMoreBtn(
                title: 'Recomended Courses',
              ),
              const SizedBox(height: 15),
              StreamBuilder<QuerySnapshot<FavouriteModel>>(
                  stream: FirebaseFirestore.instance
                      .collection("AllUsers")
                      .doc(SharedPreferencesHelper.getData(key: "uId"))
                      .collection("favourite")
                      .withConverter<FavouriteModel>(
                    fromFirestore: (snapshot, options) {
                      print(snapshot.data());
                      return FavouriteModel.fromFirestore(snapshot.data()!);
                    },
                    toFirestore: (task, options) {
                      return task.toFirestore();
                    },
                  ).snapshots(),
                  builder: (buildContext, snapshot) {
                    return  cubit.allVideos.length==0 ?
                    Center(
                      child: CircularProgressIndicator(
                        color: myColor,
                      ),
                    )    :
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)
                        {
                          g(url: "${cubit.allVideos[index]["url"]}");
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width*0.7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: myColor,
                                    width: 5,
                                  ),
                                ),
                                child: YoutubePlayer(
                                  controller: controller!,
                                  showVideoProgressIndicator: true,
                                  bottomActions: [
                                    CurrentPosition(),
                                    ProgressBar(
                                      isExpanded: true,
                                      colors: ProgressBarColors(
                                        handleColor: Colors.white,
                                        playedColor: myColor,
                                      ),
                                    ),
                                    RemainingDuration(),
                                    PlaybackSpeedButton(),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  if(FavCubit.get(context).favList.any((element) =>element.id == cubit.allVideos[index]["id"])){
                                    ToastConfig.showToast(
                                      msg: "this product already in fav ..",
                                      toastStates: ToastStates.Success,
                                    );
                                    // cubit.add(DeleteProductFromFavorite(id:  widget.model.productId,));
                                  }else{
                                    FavCubit.get(context).addToFav(
                                        favouriteModel: FavouriteModel(
                                          videoUrl: cubit.allVideos[index]["url"],
                                          title: cubit.allVideos[index]["title"],
                                          userId: SharedPreferencesHelper.getData(key: "uId"),
                                          id:cubit.allVideos[index]["id"],
                                        )
                                    );
                                    ToastConfig.showToast(
                                      msg: "this product is added to fav ..",
                                      toastStates: ToastStates.Success,
                                    );

                                  }

                                },
                                icon:
                                FavCubit.get(context).favList.any((element) =>element.id == cubit.allVideos[index]["id"]) ?
                                Icon(Icons.favorite,
                                  size: 30,
                                  color:
                                  Colors.red,
                                ):
                                Icon(Icons.favorite_border,
                                  size: 30,
                                  color:
                                  Colors.red,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context,index){
                          return SizedBox(width: 30,);
                        },
                        itemCount: cubit.allVideos.length,
                      ),
                    );
                  }

              ),

              // ConditionalBuilder(
              //   condition: state is  GetAllVidoesSuccessState,
              //   fallback: (context)=>Center(
              //     child: CircularProgressIndicator(
              //       color: myColor,
              //     ),
              //   ),
              //   builder: (context){
              //     return SizedBox(
              //       height: 200,
              //       child: ListView.separated(
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (context,index)
              //         {
              //           g(url: "${cubit.allVideos[index]["url"]}");
              //           return   Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 color: myColor,
              //                 width: 5,
              //               ),
              //             ),
              //             child: YoutubePlayer(
              //               controller: controller!,
              //               showVideoProgressIndicator: true,
              //               bottomActions: [
              //                 CurrentPosition(),
              //                 ProgressBar(
              //                   isExpanded: true,
              //                   colors: ProgressBarColors(
              //                     handleColor: Colors.white,
              //                     playedColor: myColor,
              //                   ),
              //                 ),
              //                 RemainingDuration(),
              //                 PlaybackSpeedButton(),
              //               ],
              //             ),
              //           );
              //         },
              //         separatorBuilder: (context,index){
              //           return SizedBox(width: 20,);
              //         },
              //         itemCount: 10,
              //       ),
              //     );
              //   },
              //
              // )
            ],
          ),
        );
      } ,

    );
  }
}

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(children: <Widget>[
        TitleWithCustomUnderLine(text: title),
        const Spacer(),
      ]),
    );
  }
}

class TitleWithCustomUnderLine extends StatelessWidget {
  const TitleWithCustomUnderLine({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: const TextStyle(fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: kPrimartColor,
              ),

            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(right: kDefaultPadding / 4),
                height: 7,
                color: kPrimartColor.withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}

class RecomandCourse extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RecomandCourse({
    // this.image,
//required this.ico,
    required this.title,
    required this.image,
    required this.press,
  });
  final String title;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
        right: kDefaultPadding,
      ),
      width: size.width * 0.4,
      child: Column(children: <Widget>[
        Image.asset(image),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Lecture()));
          },

          // onTap: (){press;},

          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimartColor.withOpacity(0.23)),
                ]),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '$title\n',
                          style: Theme.of(context).textTheme.labelLarge),
                    ]),
                  ),
                  const Spacer(),
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
