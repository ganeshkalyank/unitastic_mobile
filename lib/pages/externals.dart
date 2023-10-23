import 'package:flutter/material.dart';

class ExternalsCalculator extends StatefulWidget {
  const ExternalsCalculator({super.key});

  @override
  State<ExternalsCalculator> createState() => _ExternalsCalculatorState();
}

class _ExternalsCalculatorState extends State<ExternalsCalculator> {
  int _internalMarks = 0;

  final Map<String,int> cutoffs = {
    'S': 91,
    'A+': 86,
    'A': 75,
    'B': 66,
    'C': 55,
    'D': 50,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Expected Externals',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text (
                'Expected Externals',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Calculate the externals marks required to get each overall grade based on internal marks.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 32.0,
                thickness: 0.5,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration().applyDefaults(
                  Theme.of(context).inputDecorationTheme,
                ).copyWith(
                  labelText: 'Internal Marks',
                ),
                onChanged: (value) {
                  setState(() {
                    _internalMarks = int.parse(value);
                  });
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 32.0,
                thickness: 0.5,
              ),
              Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Grade',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Externals',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]
                  ),
                ] + cutoffs.entries.map((entry) {
                  return TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            entry.key,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (((entry.value - _internalMarks)*2) > 100) |
                            (((entry.value - _internalMarks)*2) < 0) |
                            (_internalMarks > 50) |
                            (_internalMarks < 0) ? 'NA' :
                            '${(entry.value - _internalMarks)*2}',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
