// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';
import 'package:musicapp/Models/lyrics.dart';

import 'trending_api_provider.dart';
import 'package:musicapp/Models/trendingItems.dart';

class Repository {
  late final musicApiProvider = trendingAPIProvider();

  fetchAllMusic() => musicApiProvider.fetchMusicList();
  fetchLyrics(int track_id) => musicApiProvider.fetchLyrics(track_id);
}
