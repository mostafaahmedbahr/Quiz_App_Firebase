import 'package:flutter/material.dart';

import 'conctant.dart';
import 'create new exam.dart';
import 'showExamResult.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 0.9),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: kPrimartColor,
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  color: kPrimartColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 130,
              decoration: BoxDecoration(
                  color: kTextColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimartColor.withOpacity(0.23)),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 30.0,
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundImage: NetworkImage(
                              'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Admin Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      const Text(
                        'Code : 0Xffff',
                        style: TextStyle(
                          color: Color.fromRGBO(235, 235, 235, 1),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => createNewexam()));
                  },
                  child: buildContainer('Create Exam',
                      'https://www.iitms.co.in/college-erp/img/online-exam-icon.png'),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const StudentScore()));
                  },
                  child: buildContainer('Student Score',
                      'https://cdn1.iconfinder.com/data/icons/school-224/512/A_Exam-512.png'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.8),
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                buildListTile('My Account', 'Make change to your account ',
                        () {}, Icons.person_2_outlined),
                buildListTile(
                    'Log Out',
                    'Further secure your account for safety ',
                        () {},
                    Icons.logout)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainer(String str, String url) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      height: 80,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 50,
                color: kPrimartColor.withOpacity(0.23)),
          ]),
      child: Column(children: [
        Image(
          image: NetworkImage(url),
          color: const Color.fromRGBO(248, 170, 36, 1),
          height: 40,
          width: 40,
        ),
        Text(
          str,
          style: const TextStyle(
            fontSize: 18,
            // fontWeight: FontWeight.bold,
            color: Color.fromRGBO(99, 9, 167, 1),
          ),
        ),
      ]),
    );
  }

  ListTile buildListTile(String titletext, String subtext, fun, IconData i) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.purple[50],
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            i,
            color: const Color.fromRGBO(88, 17, 142, 0.8),
          ),
        ),
      ),
      title: Text(
        titletext,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtext,
        style: const TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(171, 171, 171, 1),
        ),
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: fun,
    );
  }
}
