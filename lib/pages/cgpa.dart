import 'package:flutter/material.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({super.key});

  @override
  State<CGPACalculator> createState() => _CGPACalculatorState();
}

class _CGPACalculatorState extends State<CGPACalculator> {
  final List<Map<String,dynamic>> _semesters = [];
  String _cgpa = '0.0000';

  void calculateCGPA() {
    double totalCredits = 0;
    double totalPoints = 0;
    for (var semester in _semesters) {
      totalCredits += semester['credits'];
      switch (semester['grade']) {
        case 'S':
          totalPoints += 10 * semester['credits'];
          break;
        case 'A+':
          totalPoints += 9 * semester['credits'];
          break;
        case 'A':
          totalPoints += 8 * semester['credits'];
          break;
        case 'B':
          totalPoints += 7 * semester['credits'];
          break;
        case 'C':
          totalPoints += 6 * semester['credits'];
          break;
        case 'D':
          totalPoints += 5 * semester['credits'];
          break;
        case 'F':
          totalPoints += 0 * semester['credits'];
          break;
      }
    }
    setState(() {
      _cgpa = (totalPoints / totalCredits).toStringAsFixed(4);
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
          'CGPA Calculator',
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
                'CGPA Calculator',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Calculate your CGPA based on SGPA and credits.',
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
                    _semesters.add({
                      'credits': 0,
                      'grade': 'S',
                    });
                  });
                },
                child: Text(
                  'Add Semester',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _semesters.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Text(
                        'Semester ${index+1}',
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
                                  _semesters[index]['credits'] = int.parse(value);
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
                              value: _semesters[index]['grade'],
                              onChanged: (value) {
                                setState(() {
                                  _semesters[index]['grade'] = value!;
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
                                  _semesters.removeAt(index);
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
                onPressed: calculateCGPA,
                child: Text(
                  'Calculate CGPA',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Your CGPA is $_cgpa',
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
