import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:maui/actions/save_drawing.dart';
import 'package:maui/db/entity/card_progress.dart';
import 'package:maui/db/entity/tile.dart';
import 'package:maui/db/entity/card_extra.dart';
import 'package:maui/db/entity/quack_card.dart';
import 'package:maui/db/entity/user.dart';
import 'package:maui/models/root_state.dart';
import 'package:maui/repos/card_progress_repo.dart';
import 'package:maui/repos/card_repo.dart';
import 'package:tahiti/tahiti.dart';
import 'package:maui/repos/card_extra_repo.dart';
import 'package:maui/repos/tile_repo.dart';
import 'package:maui/state/app_state_container.dart';

class DrawingWrapper extends StatefulWidget {
  final String activityId;
  final String drawingId;
  final String template;

  const DrawingWrapper(
      {Key key, @required this.activityId, this.drawingId, this.template})
      : super(key: key);

  @override
  DrawingWrapperState createState() {
    return new DrawingWrapperState();
  }
}

class DrawingWrapperState extends State<DrawingWrapper> {
  bool _isLoading = true;
  Tile _drawing;
  Map<String, dynamic> _jsonMap;
  QuackCard _activity;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    _activity = await CardRepo().getCard(widget.activityId);

    if (widget.drawingId != null) {
      _drawing = await TileRepo().getTile(widget.drawingId);
      _jsonMap = json.decode(_drawing.content);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      User user = AppStateContainer.of(context).state.loggedInUser;
      await CardProgressRepo().upsert(CardProgress(
          cardId: widget.activityId,
          userId: user.id,
          updatedAt: DateTime.now()));
    });
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return new Center(
          child: new SizedBox(
        width: 20.0,
        height: 20.0,
        child: new CircularProgressIndicator(),
      ));
    }
    return Scaffold(
      body: ActivityBoard(
        json: _jsonMap,
        template: widget.template,
        title: _activity.title,
        saveCallback: ({Map<String, dynamic> jsonMap}) =>
            Provider.dispatch<RootState>(context,
                SaveDrawing(cardId: widget.activityId, jsonMap: jsonMap)),
      ),
    );
  }
}
