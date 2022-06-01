// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print

class lyrics {
  List<_Result> _results = [];

  lyrics.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['message']['body']['lyrics']['lyrics_body'].length);
    List<_Result> temp = [];

    _Result result = _Result(parsedJson['message']['body']['lyrics']);
    temp.add(result);

    _results = temp;
  }

  List<_Result> get results => _results;
}

class _Result {
  late String lyrics_body;

  _Result(result) {
    lyrics_body = result['lyrics_body'];
    print(lyrics_body);
  }
}
