import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final Gemini gemini=Gemini.instance;
  List<ChatMessage> messages=[];
  ChatUser myuser=ChatUser(id: '0',firstName: 'Me');
  ChatUser geminiUser=ChatUser(id: '1',firstName: 'ChatBot');
  Future<void> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    // Get the file path
    String? filePath = result.files.single.path;

    if (filePath != null) {
      print(filePath);
      _extractText(filePath);
      
    } else {
      print("File is null");
    }
  } else {
    // User canceled the picker
    print("No file selected");
  }
}
  Future<List<int>> _readDocumentData(String name) async {
    final File file = File(name);
    print("HI");
    return await file.readAsBytes();
  //final ByteData data = await rootBundle.load(name);
   
  //print(data);
  //return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
  Future<void> _extractText( String path)async{
    PdfDocument document =
    PdfDocument(inputBytes: await _readDocumentData(path));
    PdfTextExtractor extractor = PdfTextExtractor(document);
    String text = extractor.extractText();
    pdfText(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ChatBot",style: TextStyle(color: Color.fromARGB(255, 248, 244, 244)),),backgroundColor: Color.fromARGB(255, 139, 151, 241),),
      body: BuildUI(),
    );
  }

  Widget BuildUI(){
    return DashChat(inputOptions: InputOptions(trailing: [IconButton.filledTonal(onPressed: sendImage , icon: Icon(Icons.image)),IconButton.filledTonal(onPressed:() async { await pickFile();}, icon: Icon(Icons.file_upload))] ),
     currentUser: myuser, onSend: sendMessage, messages: messages,);
  }
  void sendMessage(ChatMessage chatMessage) {
  setState(() {
    messages = [chatMessage, ...messages];
  });

  try {
    // Combine all previous messages into a single string
    String conversationHistory = messages.reversed
        .map((message) => "${message.user.firstName}: ${message.text}")
        .join("\n");
    String question = chatMessage.text;
    
    // Include the current question in the conversation history
    String fullInput = "$conversationHistory $question";

    gemini.streamGenerateContent(fullInput).listen((event) {
      ChatMessage? lastMessage = messages.firstOrNull;
      if (lastMessage != null && lastMessage.user == geminiUser) {
        lastMessage = messages.removeAt(0);
        String? response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
        lastMessage.text += response;
        setState(() {
          messages = [lastMessage!, ...messages];
        });
      } else {
        String? response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
          isMarkdown: true,
        );
        setState(() {
          messages = [message, ...messages];
        });
      }
    });
  } catch (e) {
    print(e);
  }
}
  void sendImage() async{
      ImagePicker picker=ImagePicker();
      XFile? file=await picker.pickImage(source: ImageSource.gallery,
      );
      if (file!=null){
        ChatMessage chatMessage=ChatMessage(
          user: myuser, 
          createdAt: DateTime.now(),
          text: "Describe?",
          medias: [ChatMedia(
            url:file.path , fileName: "", type: MediaType.image),
            ]
          );
          sendMessage(chatMessage);
      }
  }
  void pdfText(String data) async{
      
      if (data!=""){
        ChatMessage chatMessage=ChatMessage(
          user: myuser, 
          createdAt: DateTime.now(),
          text: data,
          );
          sendMessage(chatMessage);
      }
  }
}