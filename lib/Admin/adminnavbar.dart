import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swiminit/Admin/pool_managers.dart';
import 'package:swiminit/Admin/pool_status.dart';
import 'package:swiminit/Admin/pending_dues.dart';
import 'package:swiminit/Admin/search.dart';
import 'package:swiminit/Admin/edit_swimmer_details.dart';
import 'package:swiminit/Admin/send_mail.dart';
import 'package:swiminit/Admin/admin_drawer_file.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/quaterly_reports.dart';
import 'package:swiminit/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.pool_managers;
  @override
  Widget build(BuildContext context) {
    var container;
    bool isClosed = false;
    String text = "Pool Managers";
    if (currentPage == DrawerSections.pool_managers) {
      container = ViewPoolManagers();
      text = "Pool Managers";
    } else if (currentPage == DrawerSections.pool_status) {
      container = PoolStatusPage(); //Does admin need this
      text = "Pool Status";
    } else if (currentPage == DrawerSections.pending_dues) {
      container = PendingDuesPage();
      text = "Pending Dues";
    } else if (currentPage == DrawerSections.search) {
      container = SearchPage(); //Wtf is this
      text = "Search";
    } else if (currentPage == DrawerSections.edit_swimmer_details) {
      container = EditSwimmerPage();
      text = "Edit swimmer details";
    } else if (currentPage == DrawerSections.send_mail) {
      _contact();
      container = ViewPoolManagers(); // Just open gmail
      text = "Pool Managers";
    } else if (currentPage == DrawerSections.reports) {
      container = QuarterlyReports();
      text = "Reports";
    } else if (currentPage == DrawerSections.log_out) {
      Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyApp()));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xFF14839F),
        title: Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [MyHeaderDrawer(), MyDrawerList()],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Pool Managers", Icons.dashboard_outlined,
              currentPage == DrawerSections.pool_managers ? true : false),
          menuItem(2, "Pool Status", Icons.people_alt_outlined,
              currentPage == DrawerSections.pool_status ? true : false),
          menuItem(3, "Pending Dues", Icons.event,
              currentPage == DrawerSections.pending_dues ? true : false),
          menuItem(4, "Search", Icons.notes,
              currentPage == DrawerSections.search ? true : false),
          menuItem(
              5,
              "Edit Swimmer Details",
              Icons.settings_outlined,
              currentPage == DrawerSections.edit_swimmer_details
                  ? true
                  : false),
          menuItem(6, "Send Mail", Icons.notifications_outlined,
              currentPage == DrawerSections.send_mail ? true : false),
          menuItem(7, "Reports", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.reports ? true : false),
          menuItem(8, "Log out", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.log_out ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Color(0x3614839F) : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.pool_managers;
            } else if (id == 2) {
              currentPage = DrawerSections.pool_status;
            } else if (id == 3) {
              currentPage = DrawerSections.pending_dues;
            } else if (id == 4) {
              currentPage = DrawerSections.search;
            } else if (id == 5) {
              currentPage = DrawerSections.edit_swimmer_details;
            } else if (id == 6) {
              currentPage = DrawerSections.send_mail;
            } else if (id == 7) {
              currentPage = DrawerSections.reports;
            } else if (id == 8) {
              currentPage = DrawerSections.log_out;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(17.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 17),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  pool_managers,
  pool_status,
  pending_dues,
  search,
  edit_swimmer_details,
  send_mail,
  reports,
  log_out
}

void _contact() async {
  final url = 'mailto:pavithra.rajan01@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
