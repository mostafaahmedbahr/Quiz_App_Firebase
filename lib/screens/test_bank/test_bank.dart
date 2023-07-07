import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/test_bank/cubit/states.dart';
import 'cubit/cubit.dart';

class TextBankScreen extends StatefulWidget {
  const TextBankScreen({super.key});

  @override
  TextBankScreenState createState() => TextBankScreenState();
}

class TextBankScreenState extends State<TextBankScreen> {





  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>TestBankCubit()..getAllQuestionsTestBank(),
      child: BlocConsumer<TestBankCubit,TestBankStates>(
        listener:(context,state){},
        builder: (context,state){
          var cubit = TestBankCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: myColor,
            ),
            body: ConditionalBuilder(
              condition: state is ! GetAllTestBankQuestionsLoadingState,
              fallback: (context)=>Center(
                child: CircularProgressIndicator(
                  color: myColor,
                ),
              ),
              builder: (context){
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: cubit.allQuestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: 300,
                        width: 400,
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Q${index + 1}. ',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(248, 170, 36, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${cubit.allQuestions[index]["question"]}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(99, 9, 167, 1),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text('a) ${cubit.allQuestions[index]["answers"][0]}'),
                            Text('b) ${cubit.allQuestions[index]["answers"][1]}'),
                            Text('c) ${cubit.allQuestions[index]["answers"][2]}'),
                            Text('d) ${cubit.allQuestions[index]["answers"][3]}'),
                            const Padding(padding: EdgeInsets.all(10)),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color.fromRGBO(99, 9, 167, 0.8)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              onPressed: (){
                                cubit.changeStateChangeVis(index);
                                print(index);
                                // cubit.changeVis();
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View Answer',
                                    style: TextStyle(
                                        color: Color.fromRGBO(164, 94, 217, 0.7)),
                                  ), // <-- Text
                                 SizedBox(
                                    width: 5,
                                  ),
                                 Icon(
                                    // <-- Icon
                                    Icons.expand_more,
                                    size: 35.0,
                                    color: Color.fromRGBO(164, 94, 217, 0.7),
                                  ),
                                ],
                              ),
                            ),
                           const  SizedBox(
                              height: 10,
                            ),
                            if(cubit.selectedContract == index)
                            // if (cubit.isVisible)
                              Container(
                                height: 30,
                                margin: const EdgeInsets.only(left: 20),
                                padding: const EdgeInsets.only(top: 8),
                                child: Text('${cubit.allQuestions[index]["correct_answer"]}'),
                              ) ,
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}