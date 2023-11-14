import 'package:flutter/material.dart';
import 'package:unitastic_mobile/pages/cgpa.dart';
import 'package:unitastic_mobile/pages/externals.dart';
import 'package:unitastic_mobile/pages/requiredsgpa.dart';
import 'package:unitastic_mobile/pages/sgpa.dart';
import 'package:unitastic_mobile/pages/skippability.dart';

class UtilitiesWidget extends StatelessWidget {
  UtilitiesWidget({super.key});

  final List<Map<String,dynamic>> utilities = [
    {
      'name': 'SGPA Calculator',
      'widget': const SGPACalculator(),
    },
    {
      'name': 'CGPA Calculator',
      'widget': const CGPACalculator(),
    },
    {
      'name': 'Required SGPA',
      'widget': const RequiredSGPACalculator(),
    },
    {
      'name': 'Expected Externals',
      'widget': const ExternalsCalculator(),
    },
    {
      'name': 'Class Skippability',
      'widget': const SkippabilityCalculator(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Utilities',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16.0),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: utilities.length,
            itemBuilder: (context, index) {
              return Card(
                surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
                color: Theme.of(context).colorScheme.primaryContainer,
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
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => utilities[index]['widget']!,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
