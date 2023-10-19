import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unitastic_mobile/widgets/home.dart';
import 'package:unitastic_mobile/widgets/materials.dart';
import 'package:unitastic_mobile/widgets/more.dart';
import 'package:unitastic_mobile/widgets/utilities.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _access = false;

  final List<Widget> _widgets = [
    const HomeWidget(),
    const MaterialsWidget(),
    UtilitiesWidget(),
    const MoreWidget(),
  ];

  @override
  void initState() {
    super.initState();
    final db = FirebaseFirestore.instance;
    db.collection('env').doc('access').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _access = documentSnapshot['overall'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return _access ? Scaffold(
      appBar: AppBar(
        title: Text('Unitastic',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: PageView(
        controller: controller,
        children: _widgets,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          surfaceTintColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          iconTheme: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const IconThemeData(
                    color: Colors.white,
                  );
                }
                return Theme.of(context).iconTheme.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                );
            },
          ),
          indicatorColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
            controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.book),
              label: 'Materials',
            ),
            NavigationDestination(
              icon: Icon(Icons.calculate),
              label: 'Utilities',
            ),
            NavigationDestination(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        ),
      ),
    ) : Scaffold(
      appBar: AppBar(
        title: Text('Unitastic',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/error.svg',
              width: 300,
            ),
            const SizedBox(height: 16),
            Text('Under maintenance!',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}