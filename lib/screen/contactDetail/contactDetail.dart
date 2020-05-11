import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crm/bloc/person_detail_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class ContactDetail extends StatefulWidget {
  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> with SingleTickerProviderStateMixin {
  CharacterScreenBloc _bloc;
  int _current = 0;
  int _selectedIndex = 0;
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    _bloc = CharacterScreenBloc();
  }

  void setCurrentDot(index) {
    setState(() {
      _current = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                StreamBuilder<double>(
                  stream: _bloc.barOffsetStream,
                  initialData: 200,
                  builder: (context, snapshot) {
                    return SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverSafeArea(
                        sliver: _sliverAPPBar(snapshot, innerBoxIsScrolled),
                        top: false,
                      ),
                    );
                  },
                ),
              ];
            },
            body: Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _summaryCard(_tabController, setCurrentDot, _current),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _notesTab(_tabController),
                        _notesTab(_tabController),
                        _notesTab(_tabController),
                        _notesTab(_tabController),
                        _notesTab(_tabController),
                      ],
                    ),
                  ),
                  _activitesTab(),
                  Text("!!!"),
                ],
              ),
            )),
          ),
        ),
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

  Widget _sliverAPPBar(snapshot, innerBoxIsScrolled) {
    return SliverAppBar(
      forceElevated: innerBoxIsScrolled,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TabBar(
          isScrollable: true,
          controller: _tabController,
          unselectedLabelColor: Colors.grey[400],
          labelColor: Color(0xFF3baee7),
          tabs: [
            Tab(
              text: "SUMMARY",
            ),
            Tab(
              text: "NOTES",
            ),
            Tab(
              text: "ACTIVITES",
            ),
            Tab(
              text: "History",
            ),
          ],
        ),
      ),
      expandedHeight: 230.0,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      title: LayoutBuilder(builder: (context, constraints) {
        return AnimatedOpacity(
          opacity: snapshot.data <= 213 ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: Text(
            "Roger McDonald",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: LayoutBuilder(builder: (context, constraints) {
          if (snapshot.data != constraints.biggest.height) {
            print(constraints.biggest.height);
            _bloc.changeBarOffset(constraints.biggest.height);
          }
          return Container();
        }),
        background: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=3'),
                    maxRadius: 22,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Roger McDonald",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Client",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.settings,
                    size: 22,
                    color: Colors.black38,
                  ),
                ],
              ),
              Container(
                height: 110,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.grey[300],
                ),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Market",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    "Automobile Industry",
                                    style: TextStyle(
                                        color: Colors.black87, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Profile Created:",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Text(
                                  "May 11, 2019",
                                  style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(color: Colors.black),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Risk Tolerance",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    "High",
                                    style: TextStyle(
                                        color: Colors.black87, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Language",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Text(
                                  "English",
                                  style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 20),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

Widget _activitesTab() {
  return Align(
    alignment: Alignment.topCenter,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GFButtonBadge(
                onPressed: () {},
                text: "Completed",
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
                color: Colors.green,
                icon: GFBadge(
                  child: Text("1"),
                  textColor: GFColors.DARK,
                  size: GFSize.MEDIUM,
                  color: Colors.white,
                ),
              ),
              GFButtonBadge(
                onPressed: () {},
                text: "In Process",
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
                color: Colors.blue,
                icon: GFBadge(
                  child: Text("1"),
                  textColor: GFColors.DARK,
                  size: GFSize.MEDIUM,
                  color: Colors.white,
                ),
              ),
              GFButtonBadge(
                onPressed: () {},
                text: "Not Started",
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
                color: Colors.orange,
                icon: GFBadge(
                  child: Text("2"),
                  textColor: GFColors.DARK,
                  size: GFSize.MEDIUM,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Card(
            child: GFListTile(
                avatar: GFAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=10')),
                titleText: 'Internal Prep Meeting',
                subTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Internal Meeting",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      "Date: 2020-02-01 - 2020-02-03",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                icon: Icon(Icons.check_circle, color: Colors.green)),
          ),
          Card(
            child: GFListTile(
                avatar: GFAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=11')),
                titleText: 'Annual Review Prep Work',
                subTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Portfolio Review",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      "Date: 2020-02-01 - 2020-02-03",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                icon: Icon(Icons.cached, color: Colors.blue)),
          ),
          Card(
            child: GFListTile(
                avatar: GFAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=12')),
                titleText: 'Initial Meeting with Client',
                subTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Meeting",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      "Date: 2020-02-01 - 2020-02-03",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                icon: Icon(
                  Icons.error,
                  color: Colors.orange,
                )),
          ),
          Card(
            child: GFListTile(
                avatar: GFAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=09')),
                titleText: 'Account Review',
                subTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Portfolio Review",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      "Date: 2020-02-01 - 2020-02-03",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                icon: Icon(
                  Icons.error,
                  color: Colors.orange,
                )),
          ),
          Card(
            child: GFListTile(
                avatar: GFAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=19')),
                titleText: 'Account Review',
                subTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Portfolio Review",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      "Date: 2020-02-01 - 2020-02-03",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                icon: Icon(
                  Icons.error,
                  color: Colors.orange,
                )),
          ),
        ],
      ),
    ),
  );
}

Widget _notesTab(_tabController) {
  return Align(
    alignment: Alignment.topCenter,
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=6'),
                  maxRadius: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Henry Cook',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      '2020-02-12',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () => _tabController.animateTo(1),
              child: Icon(
                Icons.settings,
                size: 18,
                color: Colors.black38,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue[50],
                ),
                child: Text(
                  "2020-02-21: To create the AnimationController in a State that only uses a single AnimationController, mix in this class, then pass vsync: this to the animation controller constructor.",
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _summaryCard(_tabController, setCurrentDot, _current) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        CarouselSlider(
          height: 147,
          viewportFraction: 1.0,
          onPageChanged: setCurrentDot,
          items: [
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        'Review Roger\'s financial goal performance',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Period: 2020-02-21 ~ 2020-02-22',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Status: Not Started',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('DONE'),
                          onPressed: () {/* ... */},
                        ),
                        FlatButton(
                          child: Text(
                            'DISMISS',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        'Account Review',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Period: 2020-02-01 ~ 2020-02-02',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Status: Not Started',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('DONE'),
                          onPressed: () {/* ... */},
                        ),
                        FlatButton(
                          child: Text(
                            'DISMISS',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        'Internal Prep Meeting',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Period: 2020-02-11 ~ 2020-02-12',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Status: Not Started',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('DONE'),
                          onPressed: () {/* ... */},
                        ),
                        FlatButton(
                          child: Text(
                            'DISMISS',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            [1, 2, 3],
            (index, url) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4)),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Card(
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Contact (Primary)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => _tabController.animateTo(1),
                    child: Text(
                      'See Detail',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            "rogersMcd@gmail.com",
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Phone",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            "(416) 222-5566",
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Address",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            "220 Yonge St, Toronto, ON M5B 2H1",
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Card(
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => _tabController.animateTo(1),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[50],
                      ),
                      child: Text(
                        "2020-02-21: To create the AnimationController in a State that only uses a single AnimationController, mix in this class, then pass vsync: this to the animation controller constructor.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[50],
                      ),
                      child: Text(
                        "2020-02-12: This mixin only supports vending a single ticker. If you might have multiple AnimationController objects over the lifetime of the State, use a full TickerProviderStateMixin instead.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Card(
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Contact History',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => _tabController.animateTo(1),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[50],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.message,
                                size: 18,
                                color: Colors.black38,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "2020-02-05",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "(16 days ago) via message",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            size: 18,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "2020-01-05",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "(1 month ago) via calling",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.group,
                            size: 18,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "2020-01-03",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "(1 month ago) via meeting",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}
