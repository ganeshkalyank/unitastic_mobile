import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class RequiredSGPACalculator extends StatefulWidget {
  const RequiredSGPACalculator({super.key});

  @override
  State<RequiredSGPACalculator> createState() => _RequiredSGPACalculatorState();
}

class _RequiredSGPACalculatorState extends State<RequiredSGPACalculator> {
  double _cgpaGoal = 0;
  double _currentCGPA = 0;
  int _currentSemesterCredits = 0;
  int _creditsTillLastSemester = 0;
  double _requiredSGPA = 0.0000;

  void calculateRequiredSGPA(){
    double x = _cgpaGoal * (_currentSemesterCredits + _creditsTillLastSemester);
    double y = _currentCGPA * _creditsTillLastSemester;
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
      name: 'calculated_sgpa',
      parameters: {
        'cgpaGoal': _cgpaGoal,
        'currentCGPA': _currentCGPA,
        'currentCredits': _currentSemesterCredits,
        'pastCredits': _creditsTillLastSemester,
        'sgpa': _requiredSGPA,
      }
    );
    setState(() {
      _requiredSGPA = ((x - y) / _currentSemesterCredits);
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
          'Required SGPA Calculator',
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
              Text(
                'Required SGPA Calculator',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Calculate required SGPA for achieving a target CGPA.',
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
                decoration: const InputDecoration().applyDefaults(
                  Theme.of(context).inputDecorationTheme,
                ).copyWith(
                  labelText: 'CGPA Goal',
                ),
                onChanged: (value) {
                  setState(() {
                    _cgpaGoal = double.parse(value);
                  });
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration().applyDefaults(
                  Theme.of(context).inputDecorationTheme,
                ).copyWith(
                  labelText: 'Current CGPA',
                ),
                onChanged: (value) {
                  setState(() {
                    _currentCGPA = double.parse(value);
                  });
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration().applyDefaults(
                  Theme.of(context).inputDecorationTheme,
                ).copyWith(
                  labelText: 'Current Semester Credits',
                ),
                onChanged: (value) {
                  setState(() {
                    _currentSemesterCredits = int.parse(value);
                  });
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration().applyDefaults(
                  Theme.of(context).inputDecorationTheme,
                ).copyWith(
                  labelText: 'Credits till Last Semester',
                ),
                onChanged: (value) {
                  setState(() {
                    _creditsTillLastSemester = int.parse(value);
                  });
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 32.0,
                thickness: 0.5,
              ),
              ElevatedButton(
                onPressed: calculateRequiredSGPA,
                child: Text(
                  'Calculate',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                _requiredSGPA >= 0 && _requiredSGPA <= 10 ?
                'Required SGPA is ${_requiredSGPA.toStringAsFixed(4)}' :
                'Not achievable',
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
