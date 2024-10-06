import 'package:flutter/material.dart';
import 'dart:math'; // For animation

// Use the local image asset path for textbooks
const String f1 = "lib/assets/Images/dbmsbook1.jpg";
const String f2 = "lib/assets/Images/dbmsbook2.jpg";

class DbmsPage extends StatefulWidget {
  const DbmsPage({super.key});

  @override
  State<DbmsPage> createState() => _DbmsPageState();
}

class _DbmsPageState extends State<DbmsPage> with SingleTickerProviderStateMixin {
  // TextBooks List
  final List<Map<String, String>> textBooks = [
    {
      "name": "Database System \nConcepts",
      "description": "Abraham Silberschatz,\nHenry F.Korth",
      "image": f1
    },
    {
      "name": "NoSQL",
      "description": "Martin Fowler",
      "image": f2
    },
  ];

  // Uploaded Files List
  List<String> uploadedFiles = [];
  bool isUploading = false; // Simulate upload process
  late AnimationController _controller;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for icon rotation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _iconAnimation = Tween<double>(begin: 0, end: pi * 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to simulate file upload
  Future<void> _uploadFile() async {
    setState(() {
      isUploading = true;
    });

    // Simulate file upload delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      uploadedFiles.add('File_${uploadedFiles.length + 1}.pdf');
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database Management System')),
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
                    return RecentTextBookCard(
                      subjectName: textBooks[index]["name"]!,
                      description: textBooks[index]["description"]!,
                      imageUrl: textBooks[index]["image"]!,
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),

              // Middle Section: Upload Files
              Text(
                "Upload Files",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  // Start icon animation
                  _controller.forward();
                  await _uploadFile();
                  // Reset icon animation
                  _controller.reset();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9D50BB), Color(0xFF6E48AA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(3, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _iconAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _iconAnimation.value,
                            child: child,
                          );
                        },
                        child: const Icon(
                          Icons.upload_file,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isUploading ? "Uploading..." : "Upload File",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Bottom Section: Uploaded Files
              Text(
                "Uploaded Files",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              uploadedFiles.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: uploadedFiles.length,
                      itemBuilder: (context, index) {
                        return UploadedFileCard(fileName: uploadedFiles[index]);
                      },
                    )
                  : const Text(
                      "No files uploaded yet.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// TextBook Card Widget (improved styling)
class RecentTextBookCard extends StatelessWidget {
  final String subjectName;
  final String description;
  final String imageUrl;

  RecentTextBookCard({
    required this.subjectName,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the opening of the PDF file here (currently empty)
        print('Opening PDF for $subjectName');
        // Future logic for opening the PDF
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(2, 4),
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

// Uploaded File Card Widget (Enhanced Visuals)
class UploadedFileCard extends StatelessWidget {
  final String fileName;

  UploadedFileCard({required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: const Icon(
            Icons.insert_drive_file,
            color: Colors.purple,
            size: 40,
          ),
          title: Text(
            fileName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text("PDF Document", style: TextStyle(color: Colors.grey)),
          trailing: const Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
