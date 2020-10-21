import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

class DebitHistory extends StatefulWidget {
  @override
  _DebitHistoryState createState() => _DebitHistoryState();
}

class _DebitHistoryState extends State<DebitHistory> {
  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final now = new DateTime.now();
    var formatter = new DateFormat.MMMM("en-US");
    //var dayFormatter = new DateFormat.EEEE();
    String formattedDate = formatter.format(now);
    //String formattedDay = dayFormatter.format(now);
    return Scaffold(
      appBar: DefaultAppBar(title: "Historique Débit Compte"),
      body: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(hv*30),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: Image(image: AssetImage('assets/images/bg.png'),fit: BoxFit.cover,),
              bottom: PreferredSize(
                preferredSize: null,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: RichText(text: TextSpan (text: '${now.day},', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        children: <TextSpan>[TextSpan(text: ' $formattedDate ${now.year}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400))])),
                    ),
                    SizedBox(height: hv*8),
                    TabBar(
                      indicatorColor: Colors.red,
                      isScrollable: true,
                      labelColor: Colors.white,
                      tabs: [
                        Tab(text: "SUNDAY, APRIL 19, 2020"),
                        Tab(text: "SUNDAY, APRIL 19, 2020"),
                        Tab(text: "SUNDAY, APRIL 19, 2020"),
                        Tab(text: "SUNDAY, APRIL 19, 2020"),
                        Tab(text: "SUNDAY, APRIL 19, 2020"),
                        Tab(text: "SUNDAY, APRIL 19, 2020"),
                      ],
                    ),
                  ],
                ),
              ),
              title: Text('Débit Compte', style: TextStyle(fontSize: 22)),
              centerTitle: true,
            ),
          ),
          body: TabBarView(
            children: [
              ListView(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow( 
                      color: Colors.black45.withOpacity(0.1),
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      spreadRadius: 5.0)
                  ],
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 7, left: 7, right: 7, bottom: 2),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        Text("17H33min", style: TextStyle(fontSize: 18, color: Colors.black45)), 
                        Text("Montant", style: TextStyle(fontSize: 18, color: Colors.black45))
                      ],),
                    ),
                    Divider(thickness: 1, height: 1),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          Text("Donataire", style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold)),
                          SizedBox(height: 3),
                          Text("BDAADA51", style: TextStyle(fontSize: 14, color: Colors.black45))
                        ],),
                      ),

                      Row(children: <Widget>[
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          Text("Bénéficier", style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold)),
                          SizedBox(height: 3),
                          Text("FBBDCDBE", style: TextStyle(fontSize: 14, color: Colors.black45))
                        ],),

                        
                        Container(
                          decoration: BoxDecoration(
                          border: Border(left: BorderSide(width: 1.0, color: Colors.black26))
                        ),
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Text("4000F", style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
                        )
                      ],),

                      

                    ]),
                  ],)
                )
              ],),
              Center(child: Text("Historique Transactions vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
              Center(child: Text("Historique Transactions vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
              Center(child: Text("Historique Transactions vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
              Center(child: Text("Historique Transactions vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
              Center(child: Text("Historique Transactions vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}