import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/views/anonymous_message.dart';
import 'package:help_me/views/appointment.dart';
import 'package:help_me/views/login.dart';
import 'package:help_me/views/scheduling.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    AnonymousMessage(),
    Appointment(),
    Scheduling(),
  ];
  List<String> itemsMenuPopUp = ["Logout"];
  AccountController accountController = new AccountController();
  _onSeledtedMenuPopUp(String value) async {
    switch (value) {
      case "Logout":
        if (await accountController.singOut())
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help-me"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle),
            onSelected: _onSeledtedMenuPopUp,
            itemBuilder: (context) {
              return itemsMenuPopUp.map((e) {
                return PopupMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.user,
                    text: 'Chat ',
                  ),
                  GButton(
                    icon: LineIcons.bookmark,
                    text: 'Agendamento',
                  ),
                  GButton(
                    icon: LineIcons.video_camera,
                    text: 'Consulta',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
