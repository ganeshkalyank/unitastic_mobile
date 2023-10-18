import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilitiesWidget extends StatelessWidget {
  UtilitiesWidget({super.key});

  final List<Map<String,String>> utilities = [
    {
      'name': 'SGPA Calculator',
      'url': 'https://unitastic.netlify.app/sgpa',
    },
    {
      'name': 'CGPA Calculator',
      'url': 'https://unitastic.netlify.app/cgpa',
    },
    {
      'name': 'Required SGPA',
      'url': 'https://unitastic.netlify.app/targetcgpa',
    },
    {
      'name': 'Expected Externals',
      'url': 'https://unitastic.netlify.app/externals',
    },
    {
      'name': 'Class Skippability',
      'url': 'https://unitastic.netlify.app/attendance',
    }
  ];

  Future<void> _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Utilities',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: utilities.length,
            itemBuilder: (context, index) {
              return Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    utilities[index]['name']!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl(utilities[index]['url']!);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Note',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Calculators are currently under the process of being '
                  'implemented natively in the app.\n\nUntil then, the above '
                  'buttons will take you to the web version of the calculators.',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
