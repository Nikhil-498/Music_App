// ignore_for_file: unused_import

import 'package:musicapp/Models/trendingItems.dart';
import 'package:musicapp/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MusicBloc {
  late final _repository = Repository();
  late final _musicFetcher = PublishSubject<trendingItems>();

  Stream<trendingItems> get allMusic => _musicFetcher.stream;

  fetchAllMusic() async {
    trendingItems itemModel = (await _repository.fetchAllMusic());
    _musicFetcher.sink.add(itemModel);
  }

  dispose() {
    _musicFetcher.close();
  }
}

final bloc = MusicBloc();
