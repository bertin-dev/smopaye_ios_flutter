import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/introView.dart';

import 'widgets/appBar.dart';

class Tutorial extends StatefulWidget {
  final bool goToLogin;

  const Tutorial({Key key, this.goToLogin = true}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

const MaterialColor myWhite = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

class _TutorialState extends State<Tutorial> with SingleTickerProviderStateMixin {

  TabController tabController;

  int activeTab;

  bool done = false;
  

  @override
  void initState() { 
    
    super.initState();

    
    tabController = TabController(length: 12, vsync: this);
tabController.addListener(_setActiveTabIndex);
    Timer(Duration(seconds: 5),
    (){
      if (tabController.index < tabController.length - 1) {
      setState(() {
        tabController.index += 1;
      });
      tabController.addListener((){
        print('my index is'+ tabController.index.toString());
      });
      
    }
    else {
      return;
    } 
    }
    )
    ;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Tutorial"),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[

              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Image.asset("assets/images/tutoriels/tutoriel_menu_slide.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/debit.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/historique.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/localisation.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/menuslide.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/numero.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/recette.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/recharge.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/retrait.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/solde.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/souscription.gif"),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tutoriels/abonnement.gif"),
              ),
              

            ],),
          ),
        ],
      )
    );
  }
  pageSliding (){
    if (tabController.index < tabController.length - 1) {
      setState(() {
        tabController.index += 1;
      });
      
    }
    else {
      setState(() {
        done = true;
      });
    } 
  }
void _setActiveTabIndex() {
    activeTab = tabController.index;
    setState(() {
      activeTab = tabController.index;
    });
}
  

}