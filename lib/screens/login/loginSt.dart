import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/core/toast/toast.dart';
import 'package:quiz_app_new/screens/login/login_cubit/states.dart';
import '../../conctant.dart';
import '../../core/toast/toast_states.dart';
 import '../layout/nav_bar.dart';
import 'login_cubit/cubit.dart';

class LoginSt extends StatefulWidget {

  const LoginSt({super.key});

  @override
  State<LoginSt> createState() => _LoginStState();
}

class _LoginStState extends State<LoginSt> {
  Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);

  Color pColor = const Color.fromRGBO(164, 94, 217, 1);

// ignore: non_constant_identifier_names
  final TextEditingController eController = TextEditingController();

  final TextEditingController pController = TextEditingController();

  final TextEditingController cController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if(state is LoginSuccessState){
          ToastConfig.showToast(
              msg: "Welcome In Our App",
              toastStates: ToastStates.Success,
          );
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Layout()));
        }
      },
      builder:  (context,state){
        var formKey = GlobalKey<FormState>();
        var cubit = LoginCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            backgroundColor:  myColor,
          ),
          backgroundColor: const Color.fromRGBO(241, 241, 241, 0.9),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 190, top: 40),
                        child: CircleAvatar(
                          radius: 57,
                          backgroundColor: Color.fromRGBO(255, 232, 104, 0.9),
                        ),
                      ),
                      Positioned(
                          top: 80,
                          left: 48,
                          child: buildText(
                              str: 'Welcome Back!',
                              fontSize: 24,
                              myColor: myColor,
                              alignment: TextAlign.center))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(
                        str: 'Email',
                        fontSize: 20,
                        myColor: myColor,
                      ),
                      buildTextFormField('Enter your email', eController, p , "Please Enter Your Email"),
                      buildText(str: 'password', fontSize: 20, myColor: myColor),
                      buildTextFormField('Enter your password', pController, p , "Please Enter Your password"),
                      ConditionalBuilder(
                        condition: state is !LoginLoadingState,
                        fallback: (context)=>Center(
                          child: CircularProgressIndicator(
                            color: myColor,
                          ),
                        ),
                        builder: (context){
                          return buildElevatedButton(context, 'Sign in',
                                (){
                              // eController.text = "m2@gmail.com";
                              // pController.text = "123456";
                              if(formKey.currentState!.validate()){
                                cubit.login(
                                  email: eController.text,
                                  password: pController.text,
                                );
                              }
                            },
                          );
                        },

                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding buildElevatedButton(BuildContext context, String str,  void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: p,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: onPressed
        //     () {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (_) => const Cerved()));
        // }
        ,
        child: Text(
          str,
          style: const TextStyle(
              fontSize: 25, color: Color.fromRGBO(241, 241, 241, 1)),
        ),
      ),
    );
  }

  Padding buildTextFormField(String str, TextEditingController con, Color c,String validate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: con,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            return validate;
          }
          return null;
        },
        cursorColor: myColor,
        decoration: InputDecoration(
          hoverColor: c,
          hintText: str,
          hintStyle: TextStyle(color: c),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: c, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
            BorderSide(color: Color.fromRGBO(99, 9, 167, 1), width: 2),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class buildText extends StatelessWidget {
  const buildText({
    super.key,
    TextAlign alignment = TextAlign.start,
    required this.str,
    required this.fontSize,
    required this.myColor,
  });

  final Color myColor;
  final String str;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        str,
        style: TextStyle(
          color: const Color(0xFF6309A7),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
