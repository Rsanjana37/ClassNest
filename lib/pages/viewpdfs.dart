import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;  
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Viewpdfs extends StatefulWidget {
  const Viewpdfs({super.key});

  @override
  State<Viewpdfs> createState() => _ViewpdfsState();
}

class _ViewpdfsState extends State<Viewpdfs> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  Future<void> listExample() async {  
  firebase_storage.ListResult result =  
  await firebase_storage.FirebaseStorage.instance.ref().child('Maths').listAll();  
  
  result.items.forEach((firebase_storage.Reference ref) {  
    print('Found file: $ref');  
  });  
  
  result.prefixes.forEach((firebase_storage.Reference ref) {  
    print('Found directory: $ref');  
  });  
}
Future<void> downloadURLExample(BuildContext context) async {  
  String downloadURL = await firebase_storage.FirebaseStorage.instance.ref('Maths/mathspdf1.pdf').getDownloadURL();  
  print(downloadURL);  

  // Navigate to the ViewPDF widget, passing the download URL
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Viewbook(filePath: downloadURL)),
  );
}
@override  
void initState() {  
  // TODO: implement initState  
  super.initState();    
  listExample();  
  downloadURLExample(context);  
  print("All done!");  
}

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

class Viewbook extends StatelessWidget {
  final String filePath;  // Use file path (local path or URL)

  const Viewbook({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View PDF'),
      ),
      body: PDFView(
        filePath: filePath, // Pass the local file path or URL directly here
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
      ),
    );
  }
}