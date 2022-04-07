import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable/expandable.dart';
import 'package:swiminit/SPM/exit_class.dart';
import 'package:swiminit/SPM/PoolStatusSwimmer.dart';
import 'package:swiminit/SPM/pool_status_class.dart';
import 'package:swiminit/SPM/pool_start_service.dart';
import 'package:swiminit/SPM/spmnavbar.dart';
import 'package:swiminit/SPM/swimmer_exit.dart';

class PoolStatusPage extends StatefulWidget {
  const PoolStatusPage({Key? key}) : super(key: key);

  @override
  State<PoolStatusPage> createState() => _PoolStatusPageState();
}

class _PoolStatusPageState extends State<PoolStatusPage>
{
  Future<ExitSwimmers>? _exitswimmers;
  List<PoolStatusSwimmer> persons = [];
  void remove(int a){
    setState(() {
      persons.clear();
    });
  }

Future confirmExit(String rno) async{
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0,0 ),
          child: AlertDialog(
            content: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text('Confirm swimmer exit?', style: GoogleFonts.poppins(color: Color(0xFF149F88), fontSize: 16),),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF149F88), // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(100,45),
                  ),
                  child: Text('OK'),
                  onPressed: () async {
                    await proceedExit(rno).then((value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SPMNavBar())));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF149F88), // background
                    onPrimary: Colors.white, // foreground
                    minimumSize: Size(100,45),
                  ),
                  child: Text('Go back'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SPMNavBar()));
                  },
                ),
              ),
            ],
          ),
        );
    },
  );
}

Future proceedExit(String rno) async{
  var now = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
  String datetime = dateFormat. format(now);
  final splitted=datetime.split(" ");
  String endtime='${splitted[0]};${splitted[1]}';
  final _exitswimmers= await PoolExitServices.exitSwimmers(rno,endtime);
  var i=0;
  for(var items in persons)
  {
    if(items.rollno==rno)
    {
      break;
    }
    i++;
  }
  remove(i);
}

  Widget buildCard(PoolStatusSwimmer p) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Color(0xFF93C6D3),
          shadowColor: Color(0xFF93C6D3),
          margin: EdgeInsets.zero,
          clipBehavior: Clip.none,
          child: ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  color: Color(0xFF93C6D3),
                  shadowColor: Color(0xFF93C6D3),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(-0.98,1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(p.profileImg)
                                    )
                                )
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment(-0.35, 1),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(40, 6, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[

                                  Text(p.name,
                                    //textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text('Entered at '+p.enteredAt,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                                  ),

                                ],
                              ),
                            )
                        ),
                        Align(
                            alignment: Alignment(1,1),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(p.rollno,
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                                  )

                                  // Text(p.rollno,
                                  //   style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                                  // )
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              collapsed: Container(),
              expanded:
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                alignment: Alignment(0,0),
                child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFDF4759), // background
                        onPrimary: Colors.white, // foreground
                        minimumSize: Size(175,35),
                      ),
                      child: Text('Exit',style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),),
                      onPressed: () async {
                        confirmExit(p.rollno);
                      },
                    )),
              )
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child:Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child:FutureBuilder(
                future: PoolStatusServices.getSwimmers(),
                builder: (context, data){
                  if(data.hasError){
                    return Center(child: Text("${data.error}"));
                  }
                  else if(data.hasData){
                    var swimmers= data.data as LiveSwimmers;
                    persons=[];
                    for(var items in swimmers.visits)
                    {
                      persons.add(PoolStatusSwimmer(items.swimmer.name, 'lib/Resources/pic-1.png', items.swimmer.membershipId, items.visit.dateOfVisit, items.swimmer.dues.toString(),items.swimmer.emailId,items.swimmer.contact1,items.swimmer.contact2)
                      );
                    }
                    if(persons.isEmpty)
                    {
                        return Center(
                          child: Text("Pool is empty"),
                        );
                    }
                    else
                    {
                      return Column(
                        children: <Widget>[
                          Column(
                              children: persons.map((p) {
                                return buildCard(p);
                              }
                              ).toList()
                          )
                        ],
                      );
                    }
                    }
                  return Center(child: Text("Loading"));
                },
              )
          ),
        )
    );
  }
}
