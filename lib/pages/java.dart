import 'package:flutter/material.dart';
import 'package:subjects/pages/viewpdfs.dart'; 

//local image asset path for textbooks
const String j1 = "lib/assets/Images/javabook1.jpg";
const String j2 = "lib/assets/Images/javabook2.jpg";

class JavaPage extends StatefulWidget {
  const JavaPage({super.key});

  @override
  State<JavaPage> createState() => _JavaPageState();
}

class _JavaPageState extends State<JavaPage> with SingleTickerProviderStateMixin {
  // TextBooks List
  final List<Map<String, String>> textBooks = [
    {
      "name": "Java The Complete\nReference",
      "description": "Herbert Schildt",
      "image": j1,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Java%2FJava_The_Complete_Reference_Ninth_Editio.pdf?alt=media&token=33bebf96-2a0c-4f42-a32a-0eb1301f7397"
    },
    {
      "name": "Core Java Volume-I\nFundamentals",
      "description": "Cay S. Horstmann, GaryCornell",
      "image": j2,
      "url":"https://firebasestorage.googleapis.com/v0/b/subjects-73334.appspot.com/o/Java%2FJava_The_Complete_Reference_Ninth_Editio.pdf?alt=media&token=33bebf96-2a0c-4f42-a32a-0eb1301f7397"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OOP using Java')),
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
