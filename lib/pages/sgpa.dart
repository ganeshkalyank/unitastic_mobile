import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SGPACalculator extends StatefulWidget {
  const SGPACalculator({super.key});

  @override
  State<SGPACalculator> createState() => _SGPACalculatorState();
}

class _SGPACalculatorState extends State<SGPACalculator> {
  final List<Map<String,dynamic>> _subjects = [];
  String _sgpa = '0.0000';

  void calculateSGPA() {
    double totalCredits = 0;
    double totalPoints = 0;
    for (var subject in _subjects) {
      totalCredits += subject['credits'];
      switch (subject['grade']) {
        case 'S':
          totalPoints += 10 * subject['credits'];
          break;
        case 'A+':
          totalPoints += 9 * subject['credits'];
          break;
        case 'A':
          totalPoints += 8 * subject['credits'];
          break;
        case 'B':
          totalPoints += 7 * subject['credits'];
          break;
        case 'C':
          totalPoints += 6 * subject['credits'];
          break;
        case 'D':
          totalPoints += 5 * subject['credits'];
          break;
        case 'F':
          totalPoints += 0 * subject['credits'];
          break;
      }
    }
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
      name: 'calculated_sgpa',
      parameters: {
        'subjects': _subjects,
        'sgpa': _sgpa,
      }
    );
    setState(() {
      _sgpa = (totalPoints / totalCredits).toStringAsFixed(4);
    });
  }

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
          'SGPA Calculator',
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
                'SGPA Calculator',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Calculate your SGPA based on credits and expected grade.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 16.0,
                thickness: 0.5,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _subjects.add({
                      'credits': 0,
                      'grade': 'S',
                    });
                  });
                },
                child: Text(
                  'Add Subject',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Text(
                        'Subject ${index+1}',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration().applyDefaults(
                                  Theme.of(context).inputDecorationTheme
                              ).copyWith(
                                labelText: 'Credits',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _subjects[index]['credits'] = int.parse(value);
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration().applyDefaults(
                                  Theme.of(context).inputDecorationTheme
                              ).copyWith(
                                labelText: 'Grade',
                              ),
                              value: _subjects[index]['grade'],
                              onChanged: (value) {
                                setState(() {
                                  _subjects[index]['grade'] = value!;
                                });
                              },
                              items: ['S', 'A+', 'A', 'B', 'C', 'D', 'F',]
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  );
                              }).toList(),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _subjects.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  );
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 16.0,
                thickness: 0.5,
              ),
              ElevatedButton(
                  onPressed: calculateSGPA,
                  child: Text(
                    'Calculate SGPA',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Your SGPA is $_sgpa',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
