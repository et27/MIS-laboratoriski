import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatelessWidget {
  final List<Exam> exams = [
    Exam(name: "Програмирање на видео игри", dateTime: DateTime(2025, 11, 17, 9, 0), rooms: ["215"]),
    Exam(name: "Вовед во науката за податоци", dateTime: DateTime(2025, 11, 29, 14, 0), rooms: ["113"]),
    Exam(name: "Мобилни информациски системи", dateTime: DateTime(2025, 11, 18, 10, 0), rooms: ["200аб"]),
    Exam(name: "Мобилни платформи и програмирање", dateTime: DateTime(2025, 11, 19, 13, 0), rooms: ["лаб 2"]),
    Exam(name: "Имплементација на системи со слободен и отворен код", dateTime: DateTime(2025, 11, 20, 9, 0), rooms: ["лаб 2"]),
    Exam(name: "Оперативни системи", dateTime: DateTime(2025, 11, 21, 12, 0), rooms: ["117"]),
    Exam(name: "Веб програмирање", dateTime: DateTime(2025, 11, 22, 15, 0), rooms: ["200аб"]),
    Exam(name: "Алгоритми и податочни структури", dateTime: DateTime(2025, 11, 23, 11, 0), rooms: ["215"]),
    Exam(name: "Софтверски квалитет и тестирање", dateTime: DateTime(2025, 11, 24, 14, 0), rooms: ["лаб 13"]),
    Exam(name: "Интегрирани системи", dateTime: DateTime(2025, 11, 10, 10, 0), rooms: ["117"]),
  ];

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: Text("Распоред за испити - 221223"),
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExamDetailScreen(exam: exams[index]),
                ),
              );
            },
            child: ExamCard(exam: exams[index]),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          "Вкупно испити: ${exams.length}",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
