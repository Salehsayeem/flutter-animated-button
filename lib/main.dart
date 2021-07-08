import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List _todos = [];
  Future<void> _loadData() async {
    final url = 'https://jsonplaceholder.typicode.com/todos';
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final _loadedTodos = json.decode(response.body);
      setState(() {
        _todos = _loadedTodos;
      });
    } catch (err) {
      throw err;
    }
  }

  int currentIndex = 0;
  List listOfColors = [
    Container(
      color: Colors.amberAccent,
    ),
    Container(
      color: Colors.cyanAccent,
    ),
    Container(
      color: Colors.limeAccent,
    ),
    Container(
      color: Colors.pinkAccent,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Title Text'),
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.purple,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (BuildContext ctx, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: ListTile(
                // Render each todo
                leading: Text(_todos[index]['id'].toString()),
                title: Text(_todos[index]["title"]),
                trailing: _todos[index]["completed"]
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      )
                    : Icon(
                        Icons.circle,
                        color: Colors.yellow,
                      ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 1000),
        backgroundColor: Colors.black,
        curve: Curves.elasticInOut,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.purpleAccent,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.phone),
            title: Text('Phone'),
            activeColor: Colors.purpleAccent,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Message'),
            activeColor: Colors.purpleAccent,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.email),
            title: Text('Email'),
            activeColor: Colors.purpleAccent,
            inactiveColor: Colors.white,
          ),
        ],
      ),
    );

    //     listOfColors[currentIndex],
    // bottomNavigationBar: BottomNavyBar(
    //   animationDuration: Duration(milliseconds: 1000),
    //   backgroundColor: Colors.black,
    //   curve: Curves.elasticInOut,
    //   selectedIndex: currentIndex,
    //   onItemSelected: (index) {
    //     setState(() {
    //       currentIndex = index;
    //     });
    //   },
    //   items: [
    //     BottomNavyBarItem(
    //       icon: Icon(Icons.home),
    //       title: Text('Home'),
    //       activeColor: Colors.purpleAccent,
    //       inactiveColor: Colors.white,
    //     ),
    //     BottomNavyBarItem(
    //       icon: Icon(Icons.phone),
    //       title: Text('Phone'),
    //       activeColor: Colors.purpleAccent,
    //       inactiveColor: Colors.white,
    //     ),
    //     BottomNavyBarItem(
    //       icon: Icon(Icons.message),
    //       title: Text('Message'),
    //       activeColor: Colors.purpleAccent,
    //       inactiveColor: Colors.white,
    //     ),
    //     BottomNavyBarItem(
    //       icon: Icon(Icons.email),
    //       title: Text('Email'),
    //       activeColor: Colors.purpleAccent,
    //       inactiveColor: Colors.white,
    //     ),
    //   ],
    // ),
    //);
  }
}
