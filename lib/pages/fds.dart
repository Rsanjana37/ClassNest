import 'package:flutter/material.dart';
import 'package:subjects/pages/viewpdfs.dart'; 
//local image asset path for textbooks
const String f1 = "lib/assets/Images/fdsbook1.jpg";
const String f2 = "lib/assets/Images/fdsbook2.png";

class FdsPage extends StatefulWidget {
  const FdsPage({super.key});

  @override
  State<FdsPage> createState() => _FdsPageState();
}

class _FdsPageState extends State<FdsPage> with SingleTickerProviderStateMixin {
  // TextBooks List
  final List<Map<String, String>> textBooks = [
    {
      "name": "Fundamentals of Data Science",
      "description": "Sanjeev J. Wagh",
      "image": f1,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Fds%2Ffdsbook1.pdf?alt=media&token=99af04d9-3892-4433-897e-b6164403e23d"
    },
    {
      "name": "Introducing Data Science",
      "description": "DavyCielen,Arno D.B.Meysman",
      "image": f2,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Fds%2Ffdsbook2.pdf?alt=media&token=013c66d9-1d12-4203-b7e0-21e92b0d4fbf"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FDS')),
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