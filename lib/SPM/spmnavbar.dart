import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swiminit/SPM/edit_receipt_details.dart';
import 'package:swiminit/SPM/entry.dart';
import 'package:swiminit/SPM/log_out.dart';
import 'package:swiminit/SPM/pending_dues.dart';
import 'package:swiminit/SPM/pool_status.dart';
import 'package:swiminit/SPM/registration.dart';
import 'package:swiminit/SPM/search.dart';
import 'package:swiminit/SPM/spm_drawer_file.dart';
import 'package:google_fonts/google_fonts.dart';

class SPMNavBar extends StatelessWidget {
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
  var currentPage = DrawerSections.entry;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.entry) {
      container = EntryPage();
    } else if (currentPage == DrawerSections.pool_status) {
      container = PoolStatusPage();
    } else if (currentPage == DrawerSections.search) {
      container = SearchPage();
    } else if (currentPage == DrawerSections.registration) {
      container = RegistrationPage();
    } else if (currentPage == DrawerSections.edit_receipt_details) {
      container = EditReceiptPage();
    } else if (currentPage == DrawerSections.pending_dues) {
      container = PendingDuesPage();
    } else if (currentPage == DrawerSections.log_out) {
      container = LogOutPage();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xFF14839F),
        title: Text(
          'Entry',
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
          menuItem(1, "Entry", Icons.dashboard_outlined,
              currentPage == DrawerSections.entry ? true : false),
          menuItem(2, "Pool Status", Icons.people_alt_outlined,
              currentPage == DrawerSections.pool_status ? true : false),
          menuItem(3, "Search", Icons.event,
              currentPage == DrawerSections.search ? true : false),
          menuItem(4, "Registration", Icons.notes,
              currentPage == DrawerSections.registration ? true : false),
          menuItem(
              5,
              "Edit Receipt Details",
              Icons.settings_outlined,
              currentPage == DrawerSections.edit_receipt_details
                  ? true
                  : false),
          menuItem(6, "Pending Dues", Icons.notifications_outlined,
              currentPage == DrawerSections.pending_dues ? true : false),
          menuItem(7, "Log out", Icons.privacy_tip_outlined,
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
              currentPage = DrawerSections.entry;
            } else if (id == 2) {
              currentPage = DrawerSections.pool_status;
            } else if (id == 3) {
              currentPage = DrawerSections.search;
            } else if (id == 4) {
              currentPage = DrawerSections.registration;
            } else if (id == 5) {
              currentPage = DrawerSections.edit_receipt_details;
            } else if (id == 6) {
              currentPage = DrawerSections.pending_dues;
            } else if (id == 7) {
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
  entry,
  pool_status,
  search,
  registration,
  edit_receipt_details,
  pending_dues,
  log_out
}
