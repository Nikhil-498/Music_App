// ignore_for_file: unused_import, avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:musicapp/Bloc/music_detail_bloc.dart';
//export 'music_detail_bloc.dart';

class MusicDetailBlocProvider extends InheritedWidget {
  late final MusicDetailBloc bloc;

  MusicDetailBlocProvider({required Key key, required Widget child})
      : bloc = MusicDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MusicDetailBloc of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<MusicDetailBlocProvider>())!
        .bloc;
  }
}
