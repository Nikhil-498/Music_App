// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, file_names

class trendingItems {
  late List<_Result> _results = [];

  trendingItems.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['message']['body']['track_list'].length);
    List<_Result> temp = [];
    for (int i = 0;
        i < parsedJson['message']['body']['track_list'].length;
        i++) {
      _Result result =
          _Result(parsedJson['message']['body']['track_list'][i]['track']);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Result> get results => _results;
}

class _Result {
  late String track_name;
  late int track_id;
  late String album_name;
  late String artist_name;
  late String explicit;
  late String track_rating;

  _Result(result) {
    track_name = result['track_name'];
    album_name = result['album_name'];
    artist_name = result['artist_name'];
    track_id = result['track_id'];
    explicit = result['explicit'] == 1 ? 'True' : 'False';
    track_rating = result['track_rating'].toString();
  }
}
