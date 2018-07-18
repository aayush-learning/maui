import 'dart:math';

Map<String, List<String>> reply = {
  'Hi': ['Hello', 'How do you do?', 'Jolly good', 'How are you?'],
  'How do you do?': ['Doing fine', 'Doing good', 'Not OK'],
  'Where is your friend?': [
    'My friend has not come',
    'My friend is angry at me',
    'My friend does not like me'
  ],
  'You can call me Hoodie.': [
    'That is a wonderful name',
    'What is the meaning of the name?',
    'I like your name',
    'Do you like your name?'
  ]
};

List<String> oneLiners = [
  'Hello',
  'How are you?',
  'What is your name?',
  'Where do you live?',
  'What is your favorite book?',
  'What is your favorite color?',
  'How do you do?',
  'What is your friend\'s name?',
  'What are you doing?'
];

List<String> getPossibleReplies(String currentChat, int num) {
  print('getPossibleReplies: $currentChat ${reply[currentChat]}');
  print(reply['You can call me Hoodie.']);
  List<String> possibleReplies = reply[currentChat] ?? List<String>()
    ..shuffle();
  if (possibleReplies.length < num) {
    var rand = new Random();
    Set<String> set = Set<String>();
    while (set.length < num - possibleReplies.length) {
      set.add(oneLiners[rand.nextInt(oneLiners.length)]);
    }
    set.forEach((r) => possibleReplies.add(r));
  } else if (possibleReplies.length > num) {
    while (possibleReplies.length > num) {
      possibleReplies.removeLast();
    }
  }
  return possibleReplies;
}
