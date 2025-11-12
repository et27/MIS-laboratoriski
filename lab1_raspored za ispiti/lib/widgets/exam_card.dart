import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({required this.exam});

  @override
  Widget build(BuildContext context) {
    bool isPast = exam.dateTime.isBefore(DateTime.now());
    Color cardColor = isPast ? Colors.grey[300]! : Colors.lightBlue[100]!;

    return Card(
      color: cardColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exam.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text(DateFormat("dd.MM.yyyy HH:mm").format(exam.dateTime)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.room, size: 16),
                SizedBox(width: 4),
                Text(exam.rooms.join(", ")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
