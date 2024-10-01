import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

Future<storage.UploadTask?> uploadFile(File file) async {
  try {
     storage.Reference ref =storage.FirebaseStorage.instance.ref().child('Maths').child('Textbooks.pdf');  

    print("Uploading...");
    UploadTask uploadTask = ref.putData(await file.readAsBytes());
    await uploadTask.whenComplete(() {
      print("Upload complete!");
    });

    return Future.value(uploadTask);
  } catch (e) {
    print('Error during upload: $e');
    return null; 
  }
}

class Maths extends StatefulWidget {
  @override
  State<Maths> createState() => _MathsState();
}

class _MathsState extends State<Maths> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maths Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Open the document picker
            final path = await FlutterDocumentPicker.openDocument();
            print('Picked file path: $path');

            if (path != null) {
              File file = File(path);
              storage.UploadTask? task = await uploadFile(file);

              if (task != null) {
                print("File uploaded successfully!");
              } else {
                print("File upload failed.");
              }
            }
          },
          child: const Text("Upload File"),
        ),
      ),
    );
  }
}
