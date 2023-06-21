import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app_new/screens/students_lectuers/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';


class StudentLectureCubit extends Cubit<StudentLectureStates> {
  StudentLectureCubit() : super(StudentLectureInitState());

  static StudentLectureCubit get(context) => BlocProvider.of(context);

  List allLectures = [];
  getAllLectures()
  async {
    emit(GetAllStudentLectureLoadingState());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("lectures_pdf").get();
    FirebaseFirestore.instance.collection("lectures_pdf").get().then((value)
    {
      allLectures = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(allLectures);
      emit(GetAllStudentLectureSuccessState());
    }).catchError((error)
    {
      print("error in get all lectures pdf data ${error.toString()}");
      emit(GetAllStudentLectureErrorState());
    });
  }


  ge(){
    // firebase_storage.ListResult result = ;
  }

  Future downloadFile(Reference ref , BuildContext context) async
  {
    final url = ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = File("${tempDir.path}/${ref.name}");
    await Dio().download("$url", path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Download ${ref.name}")),
    );

  }



  Future<String?> downloadFile222(String url) async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/my_file.pdf';
      await  Dio().download(url, filePath);
      print("Ddddddd");
      return filePath;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }


  Future<void> downloadFileExample() async {
    //First you get the documents folder location on the device...
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //Here you'll specify the file it should be saved as
    File downloadToFile = File('${appDocDir.path}/downloaded-pdf.pdf');
    //Here you'll specify the file it should download from Cloud Storage
    String fileToDownload = 'lectures_pdf/';

    //Now you can try to download the specified file, and write it to the downloadToFile.
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(fileToDownload)
          .writeToFile(downloadToFile);
    } on  FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print('Download error: $e');
    }
  }


  final Uri _url = Uri.parse('https://firebasestorage.googleapis.com/v0/b/exam-app-6c063.appspot.com/o/lectures_pdf%2FMostafa_Ahmed_Flutter_Developer.pdf');
  Future<void> launchUrl22() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  static launchPdf(String string) async {
    var url = Uri.parse(string);
    await canLaunchUrl(url)
        ? launchUrl(url, mode: LaunchMode.externalApplication)
        : print("رقم خطأ");
  }

}
