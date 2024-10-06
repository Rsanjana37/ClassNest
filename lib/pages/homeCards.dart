import 'package:flutter/material.dart';
import 'package:subjects/pages/daa.dart';
import 'package:subjects/pages/dbms.dart';
import 'package:subjects/pages/fds.dart';
import 'package:subjects/pages/java.dart';
import 'package:subjects/pages/maths.dart';
class MyCards extends StatelessWidget {
  const MyCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purple[50],
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildSubjectCard(
              "Fourier Series and Number Theory", 
              "MA23312", 
              Colors.purple[100]!, 
              () {
                // Navigate to Maths page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MathsPage()),
                );
              },
            ),
            buildSubjectCard(
              "Computer Architecture", 
              "CS23311", 
              Colors.purple[200]!, 
              () {
                // Handle navigation for Computer Architecture page
                print("Navigate to Computer Architecture Page");
              },
            ),
            buildSubjectCard(
              "Design and Analysis of Algorithms", 
              "CS23331", 
              Colors.purple[300]!, 
              () {
                // Navigate to DAA page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DaaPage()),
                );
              },
            ),
            buildSubjectCard(
              "Database Management Systems", 
              "CS23332", 
              Colors.purple[400]!, 
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DbmsPage()),
                );
              },
            ),
            buildSubjectCard(
              "OOPS using JAVA", 
              "CS23333", 
              Colors.purple[500]!, 
              () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JavaPage()),
                );
              },
            ),
            buildSubjectCard(
              "Fundamentals of Data Science", 
              "CS23334", 
              Colors.purple[600]!, 
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FdsPage()),
                );
              },
            ),
          ],
        ),
      );
  }
  Widget buildSubjectCard(String subject, String code, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                code,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}