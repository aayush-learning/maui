import 'package:flutter/material.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:maui/actions/fetch_collections.dart';
import 'package:maui/app.dart';
import 'package:maui/middlewares/collections_middleware.dart';
import 'package:maui/models/root_state.dart';
import 'package:maui/repos/collection_repo.dart';
import 'package:maui/state/app_state_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void main() async {
  print('main');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('deviceId') == null) {
    prefs.setString('deviceId', Uuid().v4());
  }
  final initialState = RootState(collectionMap: {}, cardMap: {});
  final store = Store<RootState>(initialState);

  store.add(CollectionMiddleware(CollectionRepo()));
  store.dispatch(FetchCollections());

  runApp(Provider(
    store: store,
    child: AppStateContainer(
      child: MauiApp(),
    ),
  ));
}
