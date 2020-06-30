import 'package:covidtracker/services/get_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionStatsPage extends StatelessWidget {

  final List<RegionData> data;
  RegionStatsPage({this.data});

  @override
  Widget build(BuildContext context) {
    Comparator<RegionData> casesComparator = (a,b)=> a.totalCases.compareTo(b.totalCases);
    data.sort(casesComparator);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return RegionDataElement(region: data.elementAt(data.length - index - 1), index: index + 1,);
        },
      )
    );
  }
}

class RegionDataElement extends StatelessWidget {
  final RegionData region;
  final int index;
  RegionDataElement({this.index, this.region});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3
          )
        ]
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Text('${index}', style: TextStyle(fontSize: 30),),
        title: Text('${region.region}', style: GoogleFonts.varelaRound(fontSize:20),),
        trailing: Text('${region.totalCases}'),
        subtitle: Text('Number of deaths : ' + '${region.deceased}'),
      ),
    );
  }
}

