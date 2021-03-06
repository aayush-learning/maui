import 'dart:async';
import 'dart:convert';

import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:maui/db/entity/card_extra.dart';
import 'package:maui/db/entity/like.dart';
import 'package:maui/db/entity/quack_card.dart';
import 'package:maui/db/entity/tile.dart';
import 'package:maui/models/root_state.dart';
import 'package:maui/repos/card_extra_repo.dart';
import 'package:maui/repos/card_progress_repo.dart';
import 'package:maui/repos/card_repo.dart';
import 'package:maui/repos/collection_repo.dart';
import 'package:maui/repos/comment_repo.dart';
import 'package:maui/repos/like_repo.dart';
import 'package:maui/repos/tile_repo.dart';

class FetchComments implements AsyncAction<RootState> {
  final String cardId;
  CommentRepo commentRepo;

  FetchComments(this.cardId);

  @override
  Future<Computation<RootState>> reduce(RootState state) async {
    assert(commentRepo != null, 'commentRepo not injected');

    final comments =
        await commentRepo.getCommentsByParentId(cardId, TileType.card);

    return (RootState state) => RootState(
        user: state.user,
        collectionMap: state.collectionMap,
        cardMap: state.cardMap,
        progressMap: state.progressMap,
        likeMap: state.likeMap,
        tiles: state.tiles,
        templates: state.templates,
        commentMap: state.commentMap..[cardId] = comments);
  }
}
