// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, null_check_always_fails, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicapp/UI/detailsUI.dart';
import 'package:rxdart/rxdart.dart';
import 'package:musicapp/Models/lyrics.dart';
import 'package:musicapp/resources/repository.dart';

class MusicDetailBloc {
  final _repository = Repository();
  final _trackId = PublishSubject<int>();
  final _lyrics = BehaviorSubject<Future<lyrics>>();

  Function(int) get fetchTrailersById => _trackId.sink.add;
  Stream<Future<lyrics>> get movieTrailers => _lyrics.stream;

  MusicDetailBloc() {
    _trackId.stream.transform(_itemTransformer()).pipe(_lyrics);
  }

  dispose() async {
    _trackId.close();
    await _lyrics.drain();
    _lyrics.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer((Future<lyrics> trailer, int id, int index) {
      print(index);
      trailer = _repository.fetchLyrics(id);
      return trailer;
    }, null!);
  }
}
