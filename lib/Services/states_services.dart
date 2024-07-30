
import 'dart:convert';

import 'package:covid_tracker/Services/Utities/app_url.dart';
import 'package:covid_tracker/model/world_statesmodel.dart';
import 'package:covid_tracker/model/worldstatesmodel.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  Future<WorldStatesmodel> fetchWorldStatesRecords () async{

    final response =  await http.get(Uri.parse(AppUrl.worldStatesapi));


    if(response.statusCode ==200){
      var data = jsonDecode(response.body.toString());
      return WorldStatesmodel.fromJson(data);
    }
    else{
      throw Exception('error');

    }

  }
  Future<List<dynamic>> countriesListApi () async{

    var data;
    final response =  await http.get(Uri.parse(AppUrl.countriesList));


    if(response.statusCode ==200){
      data = jsonDecode(response.body.toString());
      return data;
    }
    else{
      throw Exception('error');

    }

  }

}