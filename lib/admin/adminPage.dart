import 'package:flutter/material.dart';
import 'package:subjects/admin/fdsAdmin.dart';
import 'package:subjects/pages/daa.dart'; // Page for Design and Analysis of Algorithms
import 'package:subjects/pages/dbms.dart';
import 'package:subjects/pages/fds.dart';
import 'package:subjects/pages/java.dart';
import 'package:subjects/pages/maths.dart'; 
// Page for Fourier Series and Number Theory

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the crossAxisCount based on the width of the screen
          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;

          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.purple[50],
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      // Adjust the childAspectRatio to fill the height better
                      childAspectRatio: 0.8, // Play with this value to adjust card heights
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return buildSubjectCard(
                        subject['name'],
                        subject['code'],
                        subject['color'],
                        subject['onTap'],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                subject,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
    );
  }

  List<Map<String, dynamic>> get subjects => [
    {
      'name': "Fourier Series and Number Theory",
      'code': "MA23312",
      'color': Colors.purple[100]!,
      'onTap': () {
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(builder: (context) => MathsPage()),
        //);
      },
    },
    {
      'name': "Computer Architecture",
      'code': "CS23311",
      'color': Colors.purple[200]!,
      'onTap': () {
        print("Navigate to Computer Architecture Page");
      },
    },
    {
      'name': "Design and Analysis of Algorithms",
      'code': "CS23331",
      'color': Colors.purple[300]!,
      'onTap': () {
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(builder: (context) => DaaPage()),
        //);
      },
    },
    {
      'name': "Database Management Systems",
      'code': "CS23332",
      'color': Colors.purple[400]!,
      'onTap': () {
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(builder: (context) => DbmsPage()),
        //);
      },
    },
    {
      'name': "OOPS using JAVA",
      'code': "CS23333",
      'color': Colors.purple[500]!,
      'onTap': () {
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(builder: (context) => JavaPage()),
        //);
      },
    },
    {
      'name': "Fundamentals of Data Science",
      'code': "CS23334",
      'color': Colors.purple[600]!,
      'onTap': () {
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(builder: (context) => DataScienceAdminPage()),
        //);
      },
    },
  ];
}
