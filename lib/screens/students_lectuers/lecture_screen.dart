import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/students_lectuers/cubit/cubit.dart';
import 'package:quiz_app_new/screens/students_lectuers/cubit/states.dart';
import '../../conctant.dart';
import '../pdf_view.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class Lecture extends StatelessWidget {
  const Lecture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>StudentLectureCubit()..getAllLectures(),
      child: BlocConsumer<StudentLectureCubit,StudentLectureStates>(
        listener: (context,state){},
        builder:  (context,state){
          var cubit = StudentLectureCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: myColor,
            ),
            body: ConditionalBuilder(
              condition: state is ! GetAllStudentLectureLoadingState,
              fallback: (context)=>Center(
                child: CircularProgressIndicator(
                  color: myColor,
                ),
              ),
              builder: (context){
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const  SizedBox(
                        height: 20,
                      ),
                      Text('Lectures',
                          style: TextStyle(
                              color: kPrimartColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      const  SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return   InkWell(
                              onTap: (){
                                // print(cubit.allLectures[index]["pdf"]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (_) =>   PDFViewerCachedFromUrl(
                                      url: '${cubit.allLectures[index]["pdf"]}',
                                      name: '${cubit.allLectures[index]["title"]}',
                                      onPressed: (){
                                        cubit.downloadFile(
                                            "${cubit.allLectures[index]["pdf"]}",
                                            "${cubit.allLectures[index]["title"]}");
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: pageLec(title: '${cubit.allLectures[index]["title"]}'));
                        },
                        separatorBuilder: (context,index){
                          return SizedBox(height: 2,);
                        },
                        itemCount: cubit.allLectures.length,
                      ),
                    ],
                  ),
                );
              },
            ),

          );
        },

      ),
    );
  }
}

// ignore: camel_case_types
class pageLec extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const pageLec({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding,
        right: kDefaultPadding,
      ),
      width: size.width,
      child: Column(children: <Widget>[
        Container(
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
      ]),
    );
  }
}
