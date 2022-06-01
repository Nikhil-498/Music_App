// ignore_for_file: camel_case_types, non_constant_identifier_names, no_logic_in_create_state, avoid_unnecessary_containers, unnecessary_string_interpolations, unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicapp/BLoc/music_detail_bloc_provider.dart';
import 'package:musicapp/Bloc/music_detail_bloc.dart';
import 'package:musicapp/Models/lyrics.dart';
import 'package:flutter_offline/flutter_offline.dart';

class detailsUI extends StatefulWidget {
  late final String artist_name;
  late final String track_name;
  late final String album_name;
  late final String explicit;
  late final String track_rating;
  late final int track_id;

  detailsUI(
      {artist_name, track_name, album_name, explicit, track_rating, track_id});

  @override
  State<StatefulWidget> createState() {
    return detailsUIState(
        artist_name: artist_name,
        track_name: track_name,
        album_name: album_name,
        explicit: explicit,
        track_rating: track_rating,
        track_id: track_id);
  }
}

class detailsUIState extends State<detailsUI> {
  late final String artist_name;
  late final String track_name;
  late final String album_name;
  late final String explicit;
  late final String track_rating;
  late final int track_id;

  late MusicDetailBloc bloc;

  detailsUIState(
      {artist_name, track_name, album_name, explicit, track_rating, track_id});
  @override
  void didChangeDependencies() {
    bloc = MusicDetailBlocProvider.of(context);
    bloc.fetchTrailersById(track_id);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title:
            const Text("Track Details", style: TextStyle(color: Colors.black)),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Center(
            child: connected
                ? SafeArea(
                    child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$track_name',
                                  style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 20),
                              const Text(
                                'Artist',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$artist_name',
                                  style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 20),
                              const Text(
                                'Album Name',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$album_name',
                                  style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 20),
                              const Text(
                                'Explicit',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$explicit',
                                  style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 20),
                              const Text(
                                'Rating',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$track_rating',
                                  style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 20),
                              const Text(
                                'Lyrics',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0)),
                              StreamBuilder(
                                stream: bloc.movieTrailers,
                                builder: (context,
                                    AsyncSnapshot<Future<lyrics>> snapshot) {
                                  if (snapshot.hasData) {
                                    return FutureBuilder(
                                      future: snapshot.data,
                                      builder: (context,
                                          AsyncSnapshot<lyrics> itemSnapShot) {
                                        if (itemSnapShot.hasData) {
                                          if (itemSnapShot
                                              .data!.results.isNotEmpty) {
                                            return trailerLayout(
                                                itemSnapShot.data!);
                                          } else {
                                            return noTrailer(
                                                itemSnapShot.data!);
                                          }
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
                : const Text(
                    'No Internet Connection',
                  ),
          );
        },
        child: Container(),
      ),
    );
  }
}

Widget noTrailer(lyrics data) {
  return Center(
    child: Container(
      child: const Text("No trailer available"),
    ),
  );
}

Widget trailerLayout(lyrics data) {
  if (data.results.length > 1) {
    return Row(
      children: <Widget>[
        trailerItem(data, 0),
        trailerItem(data, 1),
      ],
    );
  } else {
    return Row(
      children: <Widget>[
        trailerItem(data, 0),
      ],
    );
  }
}

trailerItem(lyrics data, int index) {
  return Expanded(
    child: Column(
      children: <Widget>[
        Text(data.results[index].lyrics_body,
            style: const TextStyle(fontSize: 20)),
      ],
    ),
  );
}
