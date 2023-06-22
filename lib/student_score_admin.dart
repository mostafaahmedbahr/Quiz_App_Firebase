import 'package:flutter/material.dart';

import 'screens/administrator_screens/admin_home/admin_home.dart';
class Data {
  final String studentName;
  final int studentNumber;
  final String studentScore;

  Data({
    required this.studentName,
    required this.studentNumber,
    required this.studentScore,
  });
}

class ExamRes extends StatefulWidget {
  const ExamRes({
    Key? key,
  }) : super(key: key);

  @override
  State<ExamRes> createState() => _ExamResState();
}

class _ExamResState extends State<ExamRes> {
  List<Data> studentData = [
    Data(
      studentName: 'Shimaa Ahmed',
      studentNumber: 11,
      studentScore: '40 / 80',
    ),
    Data(
      studentName: 'Samar Ali',
      studentNumber: 12,
      studentScore: '50 / 80',
    ),
    Data(
      studentName: 'Rahma Magdi',
      studentNumber: 13,
      studentScore: '60 /80',
    ),
    Data(
      studentName: 'Asmaa Maher',
      studentNumber: 14,
      studentScore: '60 / 80',
    ),
  ];
  Color myColor = const Color.fromRGBO(88, 17, 142, 0.8);
  Color pColor = const Color.fromRGBO(164, 94, 217, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AdminHome()));
                },
                icon: const Icon(Icons.arrow_back),
                color: myColor,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'Exams Rseults',
                  style: TextStyle(
                    color: myColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getList() {
    List<Widget> child = studentData
        .map(
          (item) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 90,
          decoration: BoxDecoration(
              color: pColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: myColor.withOpacity(0.23)),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                  Text(
                    item.studentName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    item.studentNumber.toString(),
                    style: const TextStyle(
                      color: Color.fromRGBO(235, 235, 235, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(248, 170, 36, 1)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const Text(
                        "Score",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        item.studentScore,
                        style: TextStyle(
                          fontSize: 20,
                          color: myColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    )
        .toList();
    return child;
  }
}
