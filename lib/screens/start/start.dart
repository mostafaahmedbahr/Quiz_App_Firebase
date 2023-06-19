import 'package:flutter/material.dart';
import '../../conctant.dart';
import '../login/loginSt.dart';
import '../../login_admin.dart';

class MyStartPage extends StatefulWidget {
  const MyStartPage({Key? key}) : super(key: key);

  @override
  MyStartPageState createState() => MyStartPageState();
}

class MyStartPageState extends State<MyStartPage> {
  Color _studentButtonColor =Colors.white;
  Color _studentTextColor =  kTextColor;
  Color _adminButtonColor = Colors.white;
  Color _adminTextColor = kTextColor;

  void _updateButtonColor(String buttonType) {
    setState(() {
      if (buttonType == 'student') {
        _studentButtonColor = kTextColor;
        _studentTextColor = Colors.white;
        _adminButtonColor = Colors.white;
        _adminTextColor = kTextColor;
      } else if (buttonType == 'admin') {
        _studentButtonColor = Colors.white;
        _studentTextColor = kTextColor;
        _adminButtonColor = kTextColor;
        _adminTextColor = Colors.white;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asset/image/Objects.png',
                        width: 343,
                        height: 231,
                      ),
                      const SizedBox(height: 73),
                      ElevatedButton(
                        onPressed: () {
                          _updateButtonColor('student');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginSt ()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _studentButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(315, 60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'As Student',
                            style: TextStyle(
                              fontSize: 20,
                              color: _studentTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      ElevatedButton(
                        onPressed: () {
                          _updateButtonColor('admin');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginAd()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _adminButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(315, 60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            ' As Administrator',
                            style: TextStyle(
                              fontSize: 20,
                              color: _adminTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}