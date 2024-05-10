import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class BiblePage extends StatefulWidget {
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  late Map<String, List<int>> _booksAndChapters = {};
  late String _selectedBook = '';

  Future<void> _fetchBooksAndChapters() async {
    final response = await http.get(Uri.parse('https://www.abibliadigital.com.br/api/books'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _booksAndChapters = Map.fromIterable(data,
          key: (book) => book['name'],
          value: (book) => List<int>.generate(book['chapters'], (index) => index + 1),
        );
      });
    } else {
      setState(() {
        _booksAndChapters = {'Failed to fetch books': []};
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBooksAndChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Book:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _booksAndChapters.length,
              itemBuilder: (context, index) {
                final bookName = _booksAndChapters.keys.elementAt(index);
                return ListTile(
                  title: Text(bookName),
                  onTap: () {
                    setState(() {
                      _selectedBook = bookName;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(book: _selectedBook),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final String book;

  DetailPage({required this.book});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late List<Map<String, dynamic>> _verses = [];

  Future<void> _fetchVerses() async {
    final response = await http.get(Uri.parse('https://www.abibliadigital.com.br/api/verses/nvi/gn/1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _verses = List<Map<String, dynamic>>.from(data['verses']);
      });
    } else {
      setState(() {
        _verses = [
          {
            'number': 1,
            'text': 'Failed to fetch verses ${widget.book}',
          }
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchVerses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Verses:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _verses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${_verses[index]['number']}. ${_verses[index]['text']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
