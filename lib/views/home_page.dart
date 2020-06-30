import 'package:covidtracker/services/get_data.dart';
import 'package:covidtracker/views/region_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AppDetails appData = Provider.of<AppDetails>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('${appData.appName}', style: GoogleFonts.varelaRound(fontSize: 25, color: Colors.white), ),
        centerTitle: true,
        actions: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image.network('https://cdn.countryflags.com/thumbs/india/flag-400.png', fit: BoxFit.contain,),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.indigo[900],
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('COVID tracker', style: GoogleFonts.varela(fontSize: 20, color: Colors.white),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('made with\t', style: TextStyle(color: Colors.white, fontSize: 20),),
                        Text('Crafted!!', style: GoogleFonts.pacifico(fontSize: 30, color: Colors.white),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.network('https://images.news.iu.edu/dams/jknpiqrusu_w768.jpg', fit: BoxFit.contain,),
            ),
            Column(
              children: appData.safetyMeasures.map((e) => ListTile(title: Center(child: Text('$e', style: GoogleFonts.varelaRound(fontSize: 18),)),)).toList(),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: appData.getData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            OverView overAllData = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async{
                await Future.delayed(Duration(seconds: 1));
                setState(() {
                });
              },
                child: OnBoardingPage(overView: overAllData,));
          }else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final OverView overView;
  OnBoardingPage({this.overView});

  @override
  Widget build(BuildContext context) {
    double _percent = (overView.recovered/overView.totalCases )*100;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'COVID cases across Various regions of India',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 25),),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3
                    )
                  ]
                ),
                height: 220,
                width: MediaQuery.of(context).size.width/2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total\nCases', style: GoogleFonts.varelaRound(fontSize: 30),),
                    SizedBox(height: 10,),
                    Text('${overView.totalCases}', style: TextStyle(fontSize: 40, color: Colors.red),)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 100,
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ActiveCases', style: GoogleFonts.varelaRound(fontSize: 18,),),
                              Text('${overView.activeCases}', style: TextStyle(fontSize: 20, color: Colors.orange),)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Recovered', style: GoogleFonts.varelaRound(fontSize: 18),),
                              Text('${overView.recovered}', style: TextStyle(fontSize: 25, color: Colors.green),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          ListItem(
            title: "Deaths",
            count: overView.deaths,
          ),
          ListItem(
            title: 'Recovery percentage',
            count: _percent.toInt(),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3
                )
              ]
            ),
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegionStatsPage(data: overView.regionData,)
                ));
              },
              title: Text('RegionWise Stats', style: GoogleFonts.varelaRound(fontSize: 20),),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final int count;
  ListItem({this.title, this.count});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 3
          )
        ]
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(7),
      child: ListTile(
        title: Text(title, style: GoogleFonts.varelaRound(fontSize: 20,),),
        trailing: Text('$count', style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
