import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app_new/screens/students_lectuers/cubit/states.dart';


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

  Future<File?> downloadFile(String url, String name) async
  {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$name");
    try{
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      print("Ff");
      return file;
    }
    catch(e){
      return null;
    }
  }

}
