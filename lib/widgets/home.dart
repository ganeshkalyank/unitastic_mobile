import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitastic_mobile/widgets/quote.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SvgPicture.asset(
              'assets/images/collegestudents.svg',
              semanticsLabel: 'College Students',
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'A one-stop solution for all your university needs',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 75,
                  child: Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                    thickness: 4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Unitastic is a collection of tools and utilities that will '
                'help you get through your university life with ease. From '
                'calculating your SGPA to finding out number of classes you '
                'can skip, Unitastic has it all.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Unitastic also provides you with all the materials you need for '
                  'your university life, be it notes, previous question papers,'
                  ' or even textbooks.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const QuoteWidget(),
          const SizedBox(height: 16.0),
          SvgPicture.asset(
            'assets/images/library.svg',
            semanticsLabel: 'Library',
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Materials',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Get all the materials you need for your university life, '
                  'be it notes, previous question papers, or even textbooks.\n'
                  '\nContent in Unitastic is curated from students and teachers '
                  'belonging to various departments and schools across the '
                  'university.\n\nYou can also contribute to Unitastic by '
                  'uploading your own materials.\n\nIf you find any discrepancies '
                  'in the content, you can report it to us using the feedback '
                  'form and we will take care of it.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SvgPicture.asset(
              'assets/images/calculator.svg',
              semanticsLabel: 'Calculator',
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Utilities',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Calculate your SGPA, CGPA, find out how many classes you can skip,'
                  ' and much more with Unitastic\'s utilities.\n\nUnitastic '
                  'utilities are designed to make your university life easier by'
                  ' simplifying and bringing together all the tools you need in '
                  'one place.\n\nIf you have any suggestions for new utilities, '
                  'you can let us know using the feedback form.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
