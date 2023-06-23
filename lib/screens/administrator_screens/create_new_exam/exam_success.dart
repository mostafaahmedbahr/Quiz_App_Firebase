import 'package:flutter/material.dart';
import '../admin_home/admin_home.dart';
 import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class SuccesExam extends StatefulWidget {
  const SuccesExam({Key? key}) : super(key: key);

  @override
  State<SuccesExam> createState() => _SuccesExamState();
}

class _SuccesExamState extends State<SuccesExam> {
  Color p = const Color.fromRGBO(164, 94, 217, 1);

  Color y = const Color.fromRGBO(253, 190, 82, 1);

  Color m = const Color.fromRGBO(99, 9, 167, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(alignment: AlignmentDirectional.center, children: [
                buildContainer(167, 167, p),
                buildContainer(135, 135, y),
                CachedNetworkImage(
                  imageUrl: "https://cdn3.iconfinder.com/data/icons/faticons/32/done-01-512.png",
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ]),
              Text('Thank You!',
                  style: TextStyle(
                      color: m, fontSize: 35, fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: AlignmentDirectional.center,
                  child: Text("Your Exam is successfully Created",
                      style: TextStyle(color: m, fontSize: 30))),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: p,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>  AdminHome()));
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromRGBO(241, 241, 241, 1)),
                  ),
                ),
              )
            ]));
  }

  Container buildContainer(double h, double w, Color c) {
    return Container(
      height: h,
      width: w,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(90), color: c),
    );
  }
}