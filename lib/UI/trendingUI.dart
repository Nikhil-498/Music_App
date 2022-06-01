// ignore_for_file: file_names, camel_case_types, unused_import

import 'package:flutter/material.dart';
//import 'package:musicapp/Bloc/music_bloc.dart';
import 'package:musicapp/UI/detailsUI.dart';
import 'package:musicapp/Models/trendingItems.dart';
import 'package:musicapp/BLoc/music_bloc.dart';
import 'package:musicapp/BLoc/music_detail_bloc_provider.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:getwidget/getwidget.dart';

class trendingUI extends StatefulWidget {
  const trendingUI({Key? key}) : super(key: key);

  @override
  _trendingUIState createState() => _trendingUIState();
}

class _trendingUIState extends State<trendingUI> {
  late ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    bloc.fetchAllMusic();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMusic();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Trending',
          style: TextStyle(color: Colors.black),
        )),
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
                ? startListing()
                : const Text(
                    'No Internet Connection',
                  ),
          );
        },
        child: Container(),
      ),
    );
  }

  Widget startListing() {
    bloc.fetchAllMusic();
    return StreamBuilder(
      stream: bloc.allMusic,
      builder: (context, AsyncSnapshot<trendingItems> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<trendingItems> snapshot) {
    return ListView.builder(
        controller: _controller,
        itemCount: snapshot.data?.results.length,
        itemBuilder: (BuildContext context, int index) {
          return InkResponse(
            key: null,
            child: Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Flexible(
                    child: Icon(
                      Icons.library_music,
                      color: Colors.black26,
                      size: 28,
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: GFListTile(
                      title: Text(snapshot.data!.results[index].track_name),
                      subTitle: Text(snapshot.data!.results[index].album_name),
                    ),
                    flex: 7,
                  ),
                  Flexible(
                    child: ListTile(
                      trailing: Text(snapshot.data!.results[index].artist_name),
                    ),
                    flex: 3,
                  ),
//                ListTile(
//                  leading: Icon(Icons.library_music),
//                  title: Text(snapshot.data.results[index].track_name),
//                  subtitle: Text(snapshot.data.results[index].album_name),
//                  trailing: Text(snapshot.data.results[index].artist_name),
//                ),
                ],
              ),
//            child: Text(snapshot.data.results[index].album_name),
            ),
            onTap: () => openDetailPage(snapshot.data!, index),
          );
        });
  }

  openDetailPage(trendingItems data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MusicDetailBlocProvider(
          key: const Key('0'),
          child: detailsUI(
              artist_name: data.results[index].artist_name,
              track_name: data.results[index].track_name,
              album_name: data.results[index].album_name,
              explicit: data.results[index].explicit,
              track_rating: data.results[index].track_rating,
              track_id: data.results[index].track_id),
        );
      }),
    );
  }
}
