import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:crm/model/contacts.dart';
import 'package:crm/screen/contactDetail/contactDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'charts/tabs.dart';
import 'home_background.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _avatarList = createContactSampleData();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePageBackground(
            screenHeight: MediaQuery.of(context).size.height,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Hello, Tim Horton',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0x99FFFFFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.settings,
                            size: 18,
                            color: Color(0x99FFFFFF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      children: <Widget>[
                        Text(
                          'Upcoming',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          upcommingCard(context),
                          upcommingCard(context),
                          upcommingCard(context),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 250,
                      child: ChartTabBar(),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          'Recently Viewed',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[850],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 90,
                      padding: EdgeInsets.only(top: 8),
                      child: ListView.builder(
                        itemCount: _avatarList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final _person = _avatarList[index];
                          return Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context, CupertinoPageRoute(builder: (_) => ContactDetail())),
                                child: Container(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(_person.avatar),
                                        maxRadius: 28,
                                        // child: Text(
                                        //   'RM',
                                        //   style: TextStyle(
                                        //     fontSize: 22,
                                        //   ),
                                        // ),
                                      ),
                                      Text(_person.name),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget upcommingCard(BuildContext context) {
    return Align(
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: 190,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              offset: new Offset(0.0, 1.0),
              blurRadius: 1.0,
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Meeting",
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 10,
              ),
              child: CircleAvatar(
                // backgroundColor: Colors.blue.shade100,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                maxRadius: 28,
                // child: Text(
                //   'RM',
                //   style: TextStyle(
                //     fontSize: 22,
                //   ),
                // ),
              ),
            ),
            Text(
              "Rogers McDonald",
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.grey[800],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "2020-03-16",
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 26.0,
                  width: 26.0,
                  child: IconButton(
                    padding: new EdgeInsets.all(0.0),
                    icon: Icon(Icons.navigate_next),
                    color: Colors.grey[800],
                    iconSize: 26,
                    onPressed: () {
                      print("object");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
