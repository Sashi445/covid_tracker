
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppDetails{
  
  final String appName = "COVID tracker";

  final List<String> safetyMeasures = [
    'Stay Home',
    'Keep a safe distance',
    'Wash hands often',
    'Cover your cough',
  ];
  
  Future getData() async{
    final result = await http.get('https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true');
    if(result.statusCode == 200){
      String response = result.body;
      Map<String, dynamic> jsonData = json.decode(response);
      return OverView.fromJson(jsonData);
    }return null;
  }

  Future<WorldDataList> getWorldData() async{
    final result = await http.get('https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true');
    if(result.statusCode == 200){
      String response  = result.body;
      return WorldDataList.fromJson(json.decode(response));
    }return null;
  }

}

class WorldDataList{
  List<WorldData> list;
  WorldDataList({this.list});
  factory WorldDataList.fromJson(List<dynamic> data){
    List<WorldData> _worldData = data.map((e) => WorldData.fromJson(e)).toList();
    return WorldDataList(
      list: _worldData
    );
  }
}


class WorldData{
  int infected;
  int deceased;
  String country;
  WorldData({ this.deceased, this.country, this.infected});

  factory WorldData.fromJson(Map<String, dynamic> data){
    return WorldData(
      infected: data['infected'],
      deceased: data['deceased'],
      country: data['country']
    );
  }
}

class OverView{
  int activeCases;
  int recovered;
  int deaths;
  int totalCases;
  List<RegionData> regionData;
  OverView({this.totalCases, this.recovered, this.activeCases, this.deaths, this.regionData});
  
  factory OverView.fromJson(Map<String, dynamic> data){
    List<dynamic> _rd = data['regionData'];
    List<RegionData> _regionData = _rd.map((e) => RegionData.fromJson(e)).toList();
    return OverView(
      activeCases: data['activeCases'],
      recovered: data['recovered'],
      deaths: data['deaths'],
      totalCases: data['totalCases'],
      regionData: _regionData
    );
  }
  
}


class RegionData{
  String region;
  int totalInfected;
  int recovered;
  int deceased;
  int totalCases;

  RegionData({this.deceased, this.recovered, this.region, this.totalCases, this.totalInfected});

  factory RegionData.fromJson(Map<String, dynamic> data){
    return RegionData(
      region: data['region'],
      totalCases: data['totalCases'],
      recovered: data['recovered'],
      deceased: data['deceased'],
      totalInfected: data['totalInfected']
    );
  }

}