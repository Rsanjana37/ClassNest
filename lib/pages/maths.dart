import 'package:flutter/material.dart';
import 'dart:math'; // For animation..not needed for now
const String m1 = "lib/assets/Images/mathsbook1.jpg";
const String m2 = "lib/assets/Images/mathsbook2.jpg";
const String m3 = "lib/assets/Images/mathsbook3.jpg";
const String m4 = "lib/assets/Images/mathsbook4.jpg";

class MathsPage extends StatefulWidget {
  const MathsPage({super.key});

  @override
  State<MathsPage> createState() => _MathsPageState();
}
class _MathsPageState extends State<MathsPage> with SingleTickerProviderStateMixin {
  // TextBooks List
  final List<Map<String, String>> textBooks = [
    {
      "name": "Advanced Engineering\nMathematics",
      "description": "Erwin Kreyszig",
      "image": m1
    },
    {
      "name": "Transforms and Partial\nDifferential Equations",
      "description": "Veerarajan. T",
      "image": m2
    },
    {
      "name": "Discrete and\nCombinatorial\nMathematics",
      "description": "Grimaldi, R.P and Ramana, B.V",
      "image": m3
    },
    {
      "name": "Elementary Number\nTheory with \nApplications",
      "description": "Koshy.T",
      "image": m4
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FS & NT')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section: TextBooks
              Text(
                "TextBooks",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: textBooks.length,
                  itemBuilder: (context, index) {
                    return TextBookCard(
                      subjectName: textBooks[index]["name"]!,
                      description: textBooks[index]["description"]!,
                      imageUrl: textBooks[index]["image"]!,
                      onTap: () {
                       //this on tap should be unique for each textbook- displaying pdf from firebase
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              // Middle Section: Upload Files...yet to do
            ]
    ),
      )
    )
    );
  }
}
class TextBookCard extends StatelessWidget {
  final String subjectName;
  final String description;
  final String imageUrl;
  final VoidCallback onTap; //parameter we pass
  TextBookCard({
    required this.subjectName,
    required this.description,
    required this.imageUrl,
    required this.onTap, // Require onTap callback
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, //unique onTap callback(firebase)
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subjectName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}