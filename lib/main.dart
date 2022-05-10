import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
// import './random_words.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
    // Constructor
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        /**
         * MaterialApp with Text
         */
        // return const MaterialApp(
        //     home: Text('Hello World')
        // );

        /**
         * MaterialApp with Text and TextStyle
         */
        // return MaterialApp(
        //     home: Text(
        //         'Hello World',
        //         style: TextStyle(
        //             fontSize: 30.5,
        //             color: Colors.green[400]
        //         )
        //     )
        // );

        /**
         * MaterialApp with Scaffold
         */
        // final wordPair = WordPair.random();
        return MaterialApp(
            theme: ThemeData(       
                primarySwatch: Colors.purple,
            ),
            // home: Scaffold(
            //     appBar: AppBar(
            //         title: const Text('WordPair Generator')
            //     ),
            //     body: Center(
            //         child: Text(wordPair.asPascalCase)
            //     ),
            // )
            home: const RandomWords()
        );
    }
}

///////////////////////////////////////////////////////////////

class RandomWords extends StatefulWidget {
    const RandomWords({Key? key}) : super(key: key);
    @override
    RandomWordsState createState() {
        return RandomWordsState();
    }
}

class RandomWordsState extends State<RandomWords> {
    final _randomWordPairs = <WordPair>[]; // List
    final _savedWordPairs = <WordPair>{};  // Set
    Widget _buildList() {
        // return ListView(
        //     padding: const EdgeInsets.all(8),
        //     children: <Widget>[
        //         Container(
        //             height: 50,
        //             color: Colors.amber[600],
        //             child: const Center(
        //                 child: Text('Entry A')
        //             )
        //         ),
        //         Container(
        //             height: 50,
        //             color: Colors.amber[500],
        //             child: const Center(
        //                 child: Text('Entry B')
        //             )
        //         ),
        //         Container(
        //             height: 50,
        //             color: Colors.amber[100],
        //             child: const Center(
        //                 child: Text('Entry C')
        //             )
        //         ),
        //     ]
        // );
        return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext context, int index) {
                if (index.isOdd) return const Divider();
                final idx = index ~/ 2;
                if (idx >= _randomWordPairs.length) {
                    _randomWordPairs.addAll(generateWordPairs().take(10));
                }
                return _buildRow(_randomWordPairs[idx]);
            }
        );
    }
    Widget _buildRow(WordPair wordPair) {
        final alreadySaved = _savedWordPairs.contains(wordPair);
        return ListTile(
            // title: const Text('Hello World'),
            title: Text(
                wordPair.asPascalCase, 
                style: const TextStyle(fontSize: 18)
            ),
            trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null
            ),
            onTap: () {
                setState(() {
                    if (alreadySaved) {
                        _savedWordPairs.remove(wordPair);
                    } else {
                        _savedWordPairs.add(wordPair);
                    }
                });
            }
        );
    }
    void _pushSaved() {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) {
                    final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair wordPair) {
                        return ListTile(
                            title: Text(
                                wordPair.asPascalCase,
                                style: const TextStyle(
                                    fontSize: 16
                                )
                            )
                        );
                    });
                    final List<Widget> divided = ListTile.divideTiles(
                        context: context,
                        tiles: tiles
                    ).toList();
                    return Scaffold(
                        appBar: AppBar(
                            title: const Text('Saved WordPairs')
                        ),
                        body: ListView(
                            children: divided
                        )
                    );
                }
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('WordPair Generator'),
                actions: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.list),
                        onPressed: _pushSaved
                    )
                ]
            ),
            // body: const Center(
            //     child: Text('Hello World'),
            // ),
            body: _buildList()
        );
    }
}
