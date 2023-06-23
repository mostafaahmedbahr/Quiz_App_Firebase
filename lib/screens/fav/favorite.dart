
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/models/fav_model.dart';
import 'package:quiz_app_new/screens/fav/cubit/cubit.dart';
import 'package:quiz_app_new/screens/fav/cubit/states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Sh/shared_pref.dart';
import '../../conctant.dart';
import '../../core/constants.dart';
import '../../core/toast/toast.dart';
import '../student_home/cubit/cubit.dart';
import 'no_fav.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String? urlVideo;
  late YoutubePlayerController controller;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  kTextColor,
        title: Text('favorite'),
        centerTitle: true,
        leading: Text(""),
      ),
      body: StreamBuilder<QuerySnapshot<FavouriteModel>>(
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
          print(snapshot);
          if (snapshot.hasError) {
            print("error = ${snapshot.error.toString()}");
            // execute if has errors
            return const Text('error');
          } else if (snapshot.connectionState ==
              ConnectionState.waiting) {
            // execute if data is loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = snapshot.data?.docs
              .map((element) => element.data())
              .toList();
          fv = data;
          print(fv);
          print("1111111111111111111");
          print(fv.length);
          return data!.isEmpty
              ? const NoFav()
              : Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: ListView.builder(
            itemBuilder: (_, index) {
              g(url: "${StudentHomeCubit.get(context).allVideos[index]["url"]}");
              return  Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    YoutubePlayer(
                      controller: controller,
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
                    IconButton(
                        onPressed: (){
                          FirebaseFirestore.instance
                              .collection("AllUsers")
                              .doc(SharedPreferencesHelper.getData(key: "uId"))
                              .collection("favourite")
                              .doc("${StudentHomeCubit.get(context).allVideos[index]["id"]}")
                              .delete();
                        },
                        icon: Icon(Icons.close,
                        color: Colors.red,
                        size: 35,
                        ),
                    ),
                  ],
                ),
              );
            },
            itemCount: data.length,
          ),
          );
        },
      ),
    );
  }
}
