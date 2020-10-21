import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/introView.dart';

class IntroductionViews extends StatefulWidget {
  final bool goToLogin;

  const IntroductionViews({Key key, this.goToLogin = true}) : super(key: key);

  @override
  _IntroductionViewsState createState() => _IntroductionViewsState();
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

class _IntroductionViewsState extends State<IntroductionViews> with SingleTickerProviderStateMixin {

  TabController tabController;

  int activeTab;

  bool done = false;
  

  @override
  void initState() { 
    
    super.initState();

    
    tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[

              IntroView(
                title: "Carte E-ZPASS",
                message: "Payez sans contrainte de petite monnaie ! Contrôlez vos dépenses ! Protégez vous contre les risques de vols et de faux billets avec la carte E-ZPASS",
                imageLink: 'assets/images/carte.png',
                buttonLabel: 'Commandez Votre Carte E-ZPASS',
                buttonAction: (){Navigator.pushNamed(context, '/website');},
              ),

              IntroView(
                title: "Terminal E-ZPASS",
                message: "Le Terminal E-ZPASS est un terminal de paiement performant au format amovible. Cet appareil de dernière génération permet aux commerçants d'accepter les paiements partout et à tout moment.",
                imageLink: 'assets/images/tpe.jpg',
                buttonLabel: 'Commandez Votre Terminal E-ZPASS',
                buttonAction: (){Navigator.pushNamed(context, '/website');},
              ),

              IntroView(
                title: "QR Code E-ZPASS",
                message: "E-Zpass est un moyen fiable d’envoyer et de recevoir de l’argent en utilisant notre plateforme de paiement. Il est fait facilement en utilisant un code QR. E-zpass encourage les utilisateurs  à utiliser le code QR dans les processus de paiement.",
                imageLink: 'assets/images/qrcode.png',
                buttonLabel: 'effectuer votre Payement',
                buttonAction: (){Navigator.pushNamed(context, '/website');},
              )

            ],),
          ),
          Container(padding: EdgeInsets.all(10.0),
            child: 
            
            activeTab != 2 ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(onPressed: (){setState(() {tabController.index = 2;});}, child: Text("Passer >>", style: TextStyle(color: Colors.red))),

                Theme(
                  data: ThemeData(
                    primarySwatch: Colors.green,
                    primaryColor: myWhite
                  ),
                  child: TabPageSelector(controller: tabController, color: Colors.blue.withOpacity(0), selectedColor: Colors.red.withOpacity(0.8),)
                  ),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.red), onPressed: pageSliding,),
                ) 

          ],)
          :
          Padding(
            padding: const EdgeInsets.only(bottom: 13.0),
            child: Center(child: IconButton(icon: Icon(Icons.play_circle_outline, color: Colors.red, size: 50,), onPressed: (){ widget.goToLogin ? Navigator.pushNamed(context, '/login') : Navigator.pushNamed(context, '/home');})),
          )
          ,
          
          )
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