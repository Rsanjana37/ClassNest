import 'package:flutter/material.dart';
import 'package:subjects/pages/viewpdfs.dart';

//local image asset path for textbooks
const String f1 = "lib/assets/Images/daabook1.jpg";
const String f2 = "lib/assets/Images/daabook2.jpg";
const String f3 = "lib/assets/Images/daabook3.webp";

class DaaPage extends StatefulWidget {
  const DaaPage({super.key});

  @override
  State<DaaPage> createState() => _DaaPageState();
}

class _DaaPageState extends State<DaaPage> with SingleTickerProviderStateMixin {
  // TextBooks List
  final List<Map<String, String>> textBooks = [
    {
      "name": "Introduction to the\nDesign and Analysis\nof Algorithms",
      "description": "Anany Levitin",
      "image": f1,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Daa%2Fdaapdf1.pdf?alt=media&token=45edb3d4-b562-440c-bc77-791f479245d4"
    },
    {
      "name": "Computer Algorithms",
      "description": "Ellis Horowitz, Shani",
      "image": f2,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Daa%2Fdaapdf2.pdf?alt=media&token=8997ea65-6df4-470e-b150-6a77d234e92b"
    },
    {
      "name": "Introduction to \nAlgorithms",
      "description": "Thomas H.Cormen, \nCharles E.Leiserson",
      "image": f3,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Daa%2Fdaapdf3.pdf?alt=media&token=df56bea0-92de-42f4-9a0d-93d6a3635dc2"
    },
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DAA')),
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
                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>viewpdfs(textBooks[index]["url"]!)));
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
