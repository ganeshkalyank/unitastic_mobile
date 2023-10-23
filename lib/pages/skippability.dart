import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SkippabilityCalculator extends StatefulWidget {
  const SkippabilityCalculator({super.key});

  @override
  State<SkippabilityCalculator> createState() => _SkippabilityCalculatorState();
}

class _SkippabilityCalculatorState extends State<SkippabilityCalculator> {
  int _credits = 0;
  int _skipped = 0;
  int _skippable = 0;

  void calculateSkippable() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
      name: 'calculated_attendance',
      parameters: {
        'credits': _credits,
        'bunked': _skipped,
        'canBunk': _skippable,
      }
    );
    setState(() {
      _skippable = ((_credits * 16 * 0.2) - _skipped).floor();
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
          'Skippability Calculator',
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
                'Skippability Calculator',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Calculate the number of classes you can skip based on your credits.',
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
                  labelText: 'Credits',
                ),
                onChanged: (value) {
                  setState(() {
                    _credits = int.parse(value);
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
                  labelText: 'Skipped',
                ),
                onChanged: (value) {
                  setState(() {
                    _skipped = int.parse(value);
                  });
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 32.0,
                thickness: 0.5,
              ),
              ElevatedButton(
                  onPressed: calculateSkippable,
                  child: Text(
                    'Calculate',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
              ),
              const SizedBox(height: 16.0),
              Text(
                _skippable > 0 ? 'You can skip $_skippable classes' :
                'You cannot skip any classes',
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
