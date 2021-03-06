import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '5e042589f0bdade46c96a1853d0af63e';
const apiUrl =
    'https://api.themoviedb.org/3/search/movie?api_key=${apiKey}&language=ja-JA&query=';
const posterUrl = 'http://image.tmdb.org/t/p/w300/';

class TMDBApiController {
  Future<List<Map<String, dynamic>>> getTMDBApi(String tittle) async {
    List<Map<String, dynamic>> _searchResults = [];
    http.Response response = await http.get(Uri.parse('$apiUrl$tittle'));
    Map<String, dynamic> responseArray = jsonDecode(response.body);
    List<dynamic> responseList = responseArray['results'];
    responseList.forEach((data) {
      _searchResults.add({
        'tittle': data['title'],
        'posterUrl': '$posterUrl${data['poster_path']}'
      });
    });
    return _searchResults;
  }
}
