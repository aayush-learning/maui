import 'package:flutter/material.dart';
import 'package:maui/components/drawing_list.dart';
import 'package:maui/components/topic_button.dart';
import 'package:maui/loca.dart';
import 'package:maui/db/entity/quack_card.dart';
import 'package:maui/repos/collection_repo.dart';
import 'package:maui/screens/drawing_list_screen.dart';

class ActivityListView extends StatefulWidget {
  final String topicId;
  const ActivityListView({Key key, this.topicId}) : super(key: key);

  @override
  _ActivityListViewState createState() {
    return new _ActivityListViewState();
  }

  showModes(BuildContext context, String game) {
    Navigator.of(context).pushNamed('/categories/$game');
  }
}

class _ActivityListViewState extends State<ActivityListView> {
  List<Card> _dataActivity;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    setState(() => _isLoading = true);
    _dataActivity = await CollectionRepo()
        .getCardsInCollectionByType(widget.topicId, CardType.activity);

    print("object...category data is......$_dataActivity");
    print("data of the ${_dataActivity}");
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    print(media);
    if (_isLoading) {
      return new SizedBox(
        width: 20.0,
        height: 20.0,
        child: new CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: new AppBar(
          title: new Text(
        widget.topicId,
      )),
      body: new GridView.count(
        key: new Key('Category_page'),
        primary: true,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        crossAxisCount: media.size.height > media.size.width ? 3 : 2,
        children: _dataActivity
            .map((a) => TopicButton(
                  text: a.text,
                  image: a.image,
                  onPress: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                        return DrawingListScreen(
                          activityId: a.id,
                        );
                      })),
                ))
            .toList(growable: false),
      ),
    );
  }
}
