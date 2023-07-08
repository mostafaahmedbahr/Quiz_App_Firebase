import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/student_home/cubit/states.dart';
import 'package:quiz_app_new/screens/test_bank/cubit/states.dart';
import '../../../Sh/shared_pref.dart';
import '../../../models/student_profile_model.dart';
import '../../../models/test_bank_question_model.dart';



class TestBankCubit extends Cubit<TestBankStates> {
  TestBankCubit() : super(TestBankInitState());

  static TestBankCubit get(context) => BlocProvider.of(context);


  List allQuestions = [];
  TestBankQuestionModel? testBankQuestionModel;
  getAllQuestionsTestBank()
  async {
    emit(GetAllTestBankQuestionsLoadingState());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("TestBankQuestions").get();
    FirebaseFirestore.instance.collection("TestBankQuestions").get().then((value)
    {
      allQuestions = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(allQuestions);
      print(allQuestions[0]["answers "]);
      print("00000000001111111111");
      emit(GetAllTestBankQuestionsSuccessState());
    }).catchError((error)
    {
      print("error in get test questions bank data ${error.toString()}");
      emit(GetAllTestBankQuestionsErrorState());
    });
  }


  bool isVisible = false;

  changeVis()
  {
    isVisible = !isVisible;
    emit(ChangeVisState());
  }


  int? selectedContract;
  void changeStateChangeVis(int index) {
    if (selectedContract != index) {
      selectedContract = index;
    } else {
      selectedContract = -1;
    }
    emit(ChangeStateSuccess());
  }

}