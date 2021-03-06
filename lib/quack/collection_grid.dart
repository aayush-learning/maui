import 'package:flutter/material.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:maui/models/root_state.dart';
import 'package:maui/quack/card_summary.dart';
import 'package:maui/db/entity/quack_card.dart';

class CollectionGrid extends StatelessWidget {
  final String cardId;
  final CardType cardType;

  CollectionGrid({key, @required this.cardId, @required this.cardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Connect<RootState, List<QuackCard>>(
        convert: (state) => state.collectionMap[cardId]
            .map((id) => state.cardMap[id])
            .where((c) => c.type == cardType)
            .toList(growable: false),
        where: (prev, next) => next != prev,
        builder: (cardList) {
          return SizedBox(
            height: media.size.width / 3.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CardSummary(
                    card: cardList[index],
                    index: index,
                    parentCardId: cardId,
                  ),
              itemCount: cardList.length,
              itemExtent: media.size.width / 3.5,
            ),
          );
        });
  }
}
