import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiminit/Admin/pool_managers.dart';
import 'package:swiminit/Admin/search.dart';
import 'package:swiminit/Admin/pending_dues.dart';
import 'package:swiminit/Admin/edit_swimmer_details.dart';
import 'package:swiminit/Admin/admin_drawer_file.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/Admin/quaterly_reports.dart';
import 'package:swiminit/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var currentPage = DrawerSections.poolManagers;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
  }
  @override
  Widget build(BuildContext context) {

    Widget container = Container();
    String text = "Pool Managers";

    if (currentPage == DrawerSections.poolManagers) {
      container = ViewPoolManagers();
      text = "Pool Managers";
    } else if (currentPage == DrawerSections.pendingDues) {
      container = PendingDuesPage();
      text = "Pending Dues";
    } else if (currentPage == DrawerSections.search) {
      container = Search(); //Search by membership ID and date
      text = "Search";
    } else if (currentPage == DrawerSections.editSwimmerDetails) {
      container = EditSwimmerPage();
      text = "Edit Swimmer Details";
    } else if (currentPage == DrawerSections.sendMail) {
      _contact();
      container = ViewPoolManagers();
      text = "Pool Managers";
      setState(() {
        currentPage = DrawerSections.poolManagers;
      });
    } else if (currentPage == DrawerSections.reports) {
      container = QuarterlyReports();
      text = "Reports";
    } else if (currentPage == DrawerSections.logOut) {
      Future.delayed(Duration.zero, () async {
        _signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())
        );
      });
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
          child: Column(
            children: [MyHeaderDrawer(), myDrawerList()],
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Pool Managers", Icons.dashboard_outlined,
              currentPage == DrawerSections.poolManagers ? true : false),
          menuItem(2, "Pending Dues", Icons.event,
              currentPage == DrawerSections.pendingDues ? true : false),
          menuItem(3, "Search", Icons.notes,
              currentPage == DrawerSections.search ? true : false),
          menuItem(4, "Edit Swimmer Details", Icons.settings_outlined,
              currentPage == DrawerSections.editSwimmerDetails ? true : false),
          menuItem(5, "Send Mail", Icons.notifications_outlined,
              currentPage == DrawerSections.sendMail ? true : false),
          menuItem(6, "Reports", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.reports ? true : false),
          menuItem(7, "Log out", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.logOut ? true : false),
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
              currentPage = DrawerSections.poolManagers;
            } else if (id == 2) {
              currentPage = DrawerSections.pendingDues;
            } else if (id == 3) {
              currentPage = DrawerSections.search;
            } else if (id == 4) {
              currentPage = DrawerSections.editSwimmerDetails;
            } else if (id == 5) {
              currentPage = DrawerSections.sendMail;
            } else if (id == 6) {
              currentPage = DrawerSections.reports;
            } else if (id == 7) {
              currentPage = DrawerSections.logOut;
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
  poolManagers,
  pendingDues,
  search,
  editSwimmerDetails,
  sendMail,
  reports,
  logOut
}

void _contact() async {
  String url = 'mailto:students@nitc.ac.in';
  if (await canLaunch(url)) {
      launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
