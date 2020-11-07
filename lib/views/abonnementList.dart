import 'package:flutter/material.dart';
import 'package:smopaye_mobile/models/particulier.dart';
import 'package:smopaye_mobile/services/authService2.dart';


class AbonnementList extends StatefulWidget {
  @override
  _AbonnementListState createState() => _AbonnementListState();
}

class _AbonnementListState extends State<AbonnementList> {

  AuthService2 authService2;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abonnement'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: FutureBuilder(
          future: authService2.fetchAllProfilUser(),
          builder: (BuildContext context, AsyncSnapshot<List<Particulier>> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.active:
                //STILL WORKING
                return _loading();
                break;
              case ConnectionState.waiting:
               //STILL WORKING
                return _loading();
                break;
              case ConnectionState.none:
                //ERROR
                return _error('No Connection has been made');
                break;
              case ConnectionState.done:
                //COMPLETED
              if(snapshot.hasError){
                return _error(snapshot.error.toString());
              }
              if(snapshot.hasData){
                return _drawParticulierList(snapshot.data);
              }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _drawParticulierList(List<Particulier> particulier){
    return ListView.builder(
      itemCount: particulier.length,
      itemBuilder: (BuildContext context, int position){
        return InkWell(
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(particulier[position].firstname),
            ),
          ),
          onTap: (){

          },
        );
      },
    )
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
      child: CircularProgressIndicator(),
      ),
    );
  }
}
