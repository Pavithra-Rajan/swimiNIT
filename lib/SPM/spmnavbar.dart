import 'package:flutter/material.dart';
import 'package:swiminit/SPM/search.dart';
import 'package:swiminit/SPM/edit_receipt_details.dart';
import 'package:swiminit/SPM/entry.dart';
import 'package:swiminit/Admin/pool_status.dart';
import 'package:swiminit/SPM/registration.dart';
import 'package:swiminit/SPM/spm_drawer_file.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class SPMNavBar extends StatelessWidget {
  const SPMNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.entry;

  @override
  Widget build(BuildContext context) {
    Widget container = Container();
    String text = "Entry";
    if (currentPage == DrawerSections.entry) {
      container = EntryPage();
      text = "Entry";
    } else if (currentPage == DrawerSections.poolStatus) {
      container = PoolStatusPage();
      text = "Pool Status";
    } else if (currentPage == DrawerSections.search) {
      container = SearchPage();
      text = "Search";
    } else if (currentPage == DrawerSections.registration) {
      container = RegistrationPage();
      text = "Registration";
    } else if (currentPage == DrawerSections.editReceiptDetails) {
      container = EditReceiptPage();
      text = "Edit Receipt Details";
    } else if (currentPage == DrawerSections.logOut) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyApp()));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xFF14839F),

        title: Text(text,

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
      resizeToAvoidBottomInset: false,
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Entry", Icons.dashboard_outlined,
              currentPage == DrawerSections.entry ? true : false),
          menuItem(2, "Pool Status", Icons.people_alt_outlined,
              currentPage == DrawerSections.poolStatus ? true : false),
          menuItem(3, "Search", Icons.event,
              currentPage == DrawerSections.search ? true : false),
          menuItem(4, "Registration", Icons.notes,
              currentPage == DrawerSections.registration ? true : false),
          menuItem(5, "Edit Receipt Details", Icons.settings_outlined,
              currentPage == DrawerSections.editReceiptDetails ? true : false),
          menuItem(6, "Log out", Icons.privacy_tip_outlined,
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
              currentPage = DrawerSections.entry;
            } else if (id == 2) {
              currentPage = DrawerSections.poolStatus;
            } else if (id == 3) {
              currentPage = DrawerSections.search;
            } else if (id == 4) {
              currentPage = DrawerSections.registration;
            } else if (id == 5) {
              currentPage = DrawerSections.editReceiptDetails;
            } else if (id == 6) {
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
  entry,
  poolStatus,
  search,
  registration,
  editReceiptDetails,
  logOut
}
