
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

String _api_key  ='8767e6a8f4117ff149f1fb513e439f11';
String _baseUrl  ='api.themoviedb.org';
String _language = 'es-ES';

List<Movie> onDisplayMovies = [];
List<Movie> popularMovies = [];

 MoviesProvider(){
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();

  }

  getOnDisplayMovies() async{
     var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
       'api_key': _api_key,
       'language': _language,
       'page': '1'
      });
  // Await the http get response, then decode the json-formatted response.
     final response = await http.get(url);
     final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
   
     print( nowPlayingResponse.results[1].title );
     onDisplayMovies = nowPlayingResponse.results;
     notifyListeners();

  }


  getPopularMovies() async{
     var url = Uri.https(_baseUrl, '/3/movie/popular', {
       'api_key': _api_key,
       'language': _language,
       'page': '1'
      });

  // Await the http get response, then decode the json-formatted response.
     final response = await http.get(url);
     final popularResponse = PopularResponse.fromJson(response.body);
     print(popularMovies[1]);
     popularMovies = [...popularMovies ,...popularResponse.results];
     notifyListeners();
  }

}