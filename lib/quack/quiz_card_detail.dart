import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:maui/db/entity/quack_card.dart';
import 'package:maui/db/entity/quiz.dart';
import 'package:maui/quack/card_header.dart';
import 'package:maui/quack/header_app_bar.dart';
import 'package:maui/quack/quiz_selection.dart';
import 'package:maui/repos/card_repo.dart';

enum QuizItemStatus { selectable, correct, incorrect, unselectable }

typedef CanProceed(
    {List<QuizItem> quizItems,
    List<QuizItem> answers,
    List<QuizItem> startChoices,
    List<QuizItem> endChoices});

class QuizItem {
  int id;
  String text;
  QuizItemStatus status;
  bool isAnswer;
  int index;

  QuizItem({this.id, this.text, this.status, this.isAnswer, this.index});

  @override
  String toString() {
    return 'QuizItem{id: $id, text: $text, status: $status, isAnswer: $isAnswer, index: $index}';
  }
}

class QuizCardDetail extends StatefulWidget {
  final QuackCard card;
  final List<QuizItem> answers;
  final List<QuizItem> startChoices;
  final List<QuizItem> endChoices;
  final String parentCardId;
  final CanProceed canProceed;
  final bool resultMode;

  const QuizCardDetail(
      {Key key,
      this.card,
      this.answers,
      this.startChoices,
      this.endChoices,
      this.parentCardId,
      this.canProceed,
      this.resultMode})
      : super(key: key);

  @override
  QuizCardDetailState createState() {
    return new QuizCardDetailState();
  }
}

class QuizCardDetailState extends State<QuizCardDetail> {
  Quiz _quiz;
  List<QuizItem> _quizItems;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    _quiz = await CardRepo().getQuiz(widget.card.id);
    if (widget.answers == null) {
      int id = 0;
      int index = 0;
      _quizItems = _quiz.choices
          .map((s) => QuizItem(
              id: id++,
              text: s,
              status: QuizItemStatus.selectable,
              isAnswer: false,
              index: index++))
          .toList();
      index = 0;
      _quizItems.addAll(_quiz.answers.map((s) => QuizItem(
          id: id++,
          text: s,
          status: QuizItemStatus.selectable,
          isAnswer: true,
          index: index++)));
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    print(_quizItems);
    MediaQueryData media = MediaQuery.of(context);

    return Column(
      children: <Widget>[
        SizedBox(
          height: media.size.height / 4,
          child: CardHeader(
            card: widget.card,
            parentCardId: widget.parentCardId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownBody(
              data: widget.card.content ?? '',
              styleSheet: new MarkdownStyleSheet(
                  p: new TextStyle(fontSize: 16.0, color: Colors.black))),
        ),
        Expanded(
          child: _isLoading
              ? Center(
                  child: new SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: new CircularProgressIndicator(),
                  ),
                )
              : QuizSelection(
                  quiz: _quiz,
                  quizItems: _quizItems,
                  answers: widget.answers,
                  startChoices: widget.startChoices,
                  endChoices: widget.endChoices,
                  canProceed: widget.canProceed,
                  resultMode: widget.resultMode,
                ),
        )
      ],
    );
  }
}
