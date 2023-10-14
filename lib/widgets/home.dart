import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/collegestudents.svg',
              semanticsLabel: 'College Students',
              width: 250,
            ),
            const SizedBox(height: 16),
            Text(
              'A one-stop solution for all your university needs',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
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
            const SizedBox(height: 16),
            Text('Unitastic is a collection of tools and utilities that will '
                'help you get through your university life with ease. From '
                'calculating your SGPA to finding out number of classes you '
                'can skip, Unitastic has it all.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Unitastic also provides you with all the materials you need for '
                  'your university life, be it notes, previous question papers,'
                  ' or even textbooks.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
