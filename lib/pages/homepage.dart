import 'package:flutter/material.dart';
import 'package:subjects/pages/Myhome.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget activepage= const MyHome();
  int _selectedIndex = 0;

  void pressHandler1() {
    
  }

  void pressHandler2() {
   
  }

  void pressHandler3() {
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: activepage,
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(31, 146, 53, 157),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: IconButton(
              onPressed: pressHandler1,
              icon: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: IconButton(
              onPressed: pressHandler2,
              icon: Icon(Icons.chat),
            ),
            label: 'ChatBot',
          ),
          NavigationDestination(
            icon: IconButton(
              onPressed: pressHandler3,
              icon: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
        
      
    );
    
  }
}