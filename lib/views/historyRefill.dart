import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

class RefillHistory extends StatefulWidget {
  @override
  _RefillHistoryState createState() => _RefillHistoryState();
}

class _RefillHistoryState extends State<RefillHistory> {
  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final now = new DateTime.now();
    var formatter = new DateFormat.MMMM("en-US");
    //var dayFormatter = new DateFormat.EEEE();
    String formattedDate = formatter.format(now);
    //String formattedDay = dayFormatter.format(now);
    return Scaffold(
      appBar: DefaultAppBar(title: "Historique Recharge"),
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
                      dragStartBehavior: DragStartBehavior.down,
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
              title: Text('Recharge', style: TextStyle(fontSize: 22)),
              centerTitle: true,
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text("Historique Transactions vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
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