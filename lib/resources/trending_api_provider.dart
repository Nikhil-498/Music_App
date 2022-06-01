// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:musicapp/Models/trendingItems.dart';
import 'package:musicapp/Models/lyrics.dart';

class trendingAPIProvider {
  Client client = Client();

  fetchMusicList() async {
    print("entered");
    final response = await client.get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=444234d4b553280713b979e8cde4a89d"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      //print(trendingItems.fromJson(json.decode(response.body)));
      // If the call to the server was successful, parse the JSON
      return trendingItems.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  fetchLyrics(int track_id) async {
    final response = await client.get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$track_id&apikey=444234d4b553280713b979e8cde4a89d"));
    //print('Results ${response.body.toString()}');

    if (response.statusCode == 200) {
      return lyrics.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
