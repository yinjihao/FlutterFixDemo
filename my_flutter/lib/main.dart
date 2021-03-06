import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }
}

//控件
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordState();
  }
}

class RandomWordState extends State<RandomWords> {
  //数组
  final _suggestions = <WordPair>[];

  //样式
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  //
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      //对于每个建议的单词都会调用一个itemBuilder，然后将单词对添加到ListTitle行中
      //在偶数行，改函数会为单词添加一个ListTitleRow
      //在奇数行，会增加一个下划线
      itemBuilder: (context, i) {
        //在每一列之前，添加一个1像素的分割线widget，如果是偶数
        if (i.isOdd) {
          return new Divider();
        }
        //
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    var alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var wordPair = new WordPair.random();
    Text mTextView = new Text(wordPair.asPascalCase);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("FlutterDemo-单词对"),
        ),
        body: _buildSuggestions());
  }
}
