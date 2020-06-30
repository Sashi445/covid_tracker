import 'package:covidtracker/services/get_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class WorldWideStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDetails appData = Provider.of<AppDetails>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appData.appName),
      ),
      body: FutureBuilder(
        future: appData.getWorldData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            WorldDataList _worldDataList = snapshot.data;
            return StatsBuilder(data: _worldDataList.list,);
          }else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}

class StatsBuilder extends StatelessWidget {
  List<WorldData> data;
  StatsBuilder({this.data});
  @override
  Widget build(BuildContext context) {
    Comparator<WorldData> casesComparator = (a,b) => a.infected.compareTo(b.infected);
    data.sort(casesComparator);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: data.length,
          itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                )
              ]
            ),
            child: ListTile(
              subtitle: Text('Number of deaths : ' + '${data.elementAt(data.length - index - 1).deceased}'),
              title: Text(data.elementAt(data.length - index - 1).country, style: GoogleFonts.varelaRound(fontSize: 20),),
              leading: Text('${index + 1}', style: TextStyle(fontSize: 25),),
              trailing: Text('${data.elementAt(data.length - index - 1).infected}', style: TextStyle(fontSize: 17),),
            ),
          );
          }
      ),
    );
  }
}

