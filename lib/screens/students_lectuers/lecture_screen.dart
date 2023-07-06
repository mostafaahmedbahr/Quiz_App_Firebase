
 import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/students_lectuers/cubit/cubit.dart';
import 'package:quiz_app_new/screens/students_lectuers/cubit/states.dart';
import '../../conctant.dart';


class Lecture extends StatefulWidget {
  const Lecture({Key? key}) : super(key: key);

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  late Future <ListResult> futureFiles;
  @override
  void initState() {
    futureFiles = FirebaseStorage.instance.ref("/lectures_pdf").listAll();
    super.initState();
  }
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
            body: FutureBuilder<ListResult>(
              future: futureFiles,
              builder: (context , snapShot){
                if(snapShot.hasData){
                  final files = snapShot.data!.items;

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
                            final file = files[index];
                            return   InkWell(
                                onTap: (){
                                  StudentLectureCubit.launchPdf(
                                      "${cubit.allLectures[index]["pdf"]}"
                                  );
                                  // print(cubit.allLectures[index]["pdf"]);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute<dynamic>(
                                  //     builder: (_) =>   PDFViewerCachedFromUrl(
                                  //       url: '${cubit.allLectures[index]["pdf"]}',
                                  //       name: '${cubit.allLectures[index]["title"]}',
                                  //       onPressed: () async {
                                  //
                                  //         // FileDownloader.downloadFile(
                                  //         //     url: "https://firebasestorage.googleapis.com/v0/b/exam-app-6c063.appspot.com/o/lectures_pdf%2Fa0944f9e-0567-4b0f-91c5-799848465131.pdf?alt=media&token=12aabacc-cbf5-451b-bdb1-99aa00c442b0",
                                  //         //     name: "nnnnnn",
                                  //         //     onProgress: (String? fileName, double progress) {
                                  //         //       print('FILE fileName HAS PROGRESS $progress');
                                  //         //     },
                                  //         //     onDownloadCompleted: (String path) {
                                  //         //       print('FILE DOWNLOADED TO PATH: $path');
                                  //         //     },
                                  //         //     onDownloadError: (String error) {
                                  //         //       print('DOWNLOAD ERROR: $error');
                                  //         //     });
                                  //         // cubit.downloadFileExample();
                                  //         // cubit.downloadFile(file , context);
                                  //         // cubit.downloadFile222("https://example.com/my_file.pdf");
                                  //       },
                                  //     ),
                                  //   ),
                                  // );
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
                }else if(snapShot.hasError){
                  return Center(
                    child: Text("Error .."),
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(
                      color: myColor,
                    ),
                  );
                }

              },
            ),
            // body: ConditionalBuilder(
            //   condition: state is ! GetAllStudentLectureLoadingState,
            //   fallback: (context)=>Center(
            //     child: CircularProgressIndicator(
            //       color: myColor,
            //     ),
            //   ),
            //   builder: (context){
            //     return SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: Column(
            //         children: [
            //           const  SizedBox(
            //             height: 20,
            //           ),
            //           Text('Lectures',
            //               style: TextStyle(
            //                   color: kPrimartColor,
            //                   fontSize: 25,
            //                   fontWeight: FontWeight.bold)),
            //           const  SizedBox(
            //             height: 20,
            //           ),
            //           ListView.separated(
            //             shrinkWrap: true,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemBuilder: (context,index){
            //               return   InkWell(
            //                   onTap: (){
            //                     // print(cubit.allLectures[index]["pdf"]);
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute<dynamic>(
            //                         builder: (_) =>   PDFViewerCachedFromUrl(
            //                           url: '${cubit.allLectures[index]["pdf"]}',
            //                           name: '${cubit.allLectures[index]["title"]}',
            //                           onPressed: (){
            //                             cubit.downloadFile(cubit.allLectures[index]["pdf"]);
            //                           },
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                   child: pageLec(title: '${cubit.allLectures[index]["title"]}'));
            //             },
            //             separatorBuilder: (context,index){
            //               return SizedBox(height: 2,);
            //             },
            //             itemCount: cubit.allLectures.length,
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),

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
