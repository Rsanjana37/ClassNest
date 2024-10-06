import 'package:flutter/material.dart';
import 'package:subjects/pages/geminiChatbot.dart';
import 'package:subjects/pages/homeCards.dart';
import 'package:subjects/pages/profile.dart';


class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void presshandler1(){
    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chatpage()),
                );
  }
  Widget activepage = const MyCards();
  String title = '';
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
     if (_selectedIndex == 0) {
      activepage = const MyCards();
      title = 'Home';
    }

    if (_selectedIndex == 2) {
      activepage = const MyProfile();
      title = 'Profile';
    }
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 211, 248),
        automaticallyImplyLeading: false,
        title: Text(title),
       ),
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        // backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        backgroundColor: Colors.purple[100],
        selectedFontSize: 15,
        unselectedFontSize: 11,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(onPressed: presshandler1, icon: const Icon(Icons.chat),),
            label: 'ChatBot',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    
        
      body: activepage,
    
    );
  }

 
}
