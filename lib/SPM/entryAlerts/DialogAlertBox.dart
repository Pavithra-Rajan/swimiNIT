import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiminit/SPM/spmnavbar.dart';

class CustomAlertDialogBox extends StatefulWidget {
  const CustomAlertDialogBox({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  _CustomAlertDialogBoxState createState() => _CustomAlertDialogBoxState();
}

class _CustomAlertDialogBoxState extends State<CustomAlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffd9f3fa),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF070417),
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              fontSize: 14.5,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: RawMaterialButton(
                  child: Text(
                    "Ok",
                    style: GoogleFonts.rubik(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF070417),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SPMNavBar()),
                    );
                  }

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
