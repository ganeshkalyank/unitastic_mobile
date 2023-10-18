import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Quote {
  final String content;
  final String author;

  const Quote({required this.content, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: json['content'],
      author: json['author'],
    );
  }
}

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({super.key});

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  late Future<Quote> _quote;

  Future<Quote> _getQuote() async {
    final response = await http.get(Uri.parse('https://api.quotable.io/random?tags=inspirational'));
    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(response.body));
    } else {
      return const Quote(content: 'Error', author: 'Error');
    }
  }

  @override
  void initState() {
    super.initState();
    _quote = _getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Random Thought',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          FutureBuilder<Quote> (
              future: _quote,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.data!.content == 'Error') {
                  return const Text('Error');
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        snapshot.data!.content,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '- ${snapshot.data!.author}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                );
              }
          ),
        ],
      ),
    );
  }
}

