import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({required this.exam, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration diff = exam.dateTime.difference(DateTime.now());
    int days = diff.inDays;
    int hours = diff.inHours % 24;
    bool isPast = diff.isNegative;

    return Scaffold(
      appBar: AppBar(
        title: Text("Детали за испит"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: isPast ? Colors.grey[200] : Colors.lightBlue[50],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat("dd.MM.yyyy").format(exam.dateTime),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat("HH:mm").format(exam.dateTime),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.room, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          exam.rooms.join(", "),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isPast ? Colors.red[200] : Colors.green[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isPast
                            ? "Испитот е поминат"
                            : "До испитот останува: $days дена, $hours часа",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
