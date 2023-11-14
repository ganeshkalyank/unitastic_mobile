import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitastic_mobile/pages/semester.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialsWidget extends StatefulWidget {
  const MaterialsWidget({super.key});

  @override
  State<MaterialsWidget> createState() => _MaterialsWidgetState();
}

class _MaterialsWidgetState extends State<MaterialsWidget> {
  late Future<List<Map<String,dynamic>>> _materials;

  Future<List<Map<String,dynamic>>> _getMaterials() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime lastUpdated = DateTime.parse(
      prefs.getString('semesterLastUpdated') ?? '2000-01-01 00:00:00.000',
    );
    bool isDirty = DateTime.now().difference(lastUpdated).inHours > 24;

    final db = FirebaseFirestore.instance;
    final semestersRef = db.collection('semesters');
    QuerySnapshot<Map<String, dynamic>> semesters;
    semesters = await semestersRef.orderBy('name').get(
      const GetOptions(source: Source.cache),
    );
    if (semesters.size == 0 || isDirty) {
      semesters = await semestersRef.orderBy('name').get(
        const GetOptions(source: Source.server),
      );
      prefs.setString('semesterLastUpdated', DateTime.now().toString());
    }
    final List<Map<String,dynamic>> materials = [];
    for (var semester in semesters.docs) {
      final semesterData = semester.data();
      materials.add({
        'id': semester.id,
        'name': semesterData['name'],
        'description': semesterData['description'],
      });
    }
    return materials;
  }

  @override
  void initState() {
    super.initState();
    _materials = _getMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: _materials,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              );
            }
            if (snapshot.hasError || snapshot.data!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/error.svg',
                        width: 300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error fetching data!',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Select Semester',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final semester = snapshot.data![index];
                      return Card(
                        surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          title: Text(
                            semester['name'],
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          subtitle: semester['description']!=null && semester['description']!=''?Text(
                            semester['description'],
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ) : null,
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SemesterPage(
                                  semesterid: semester['id'],
                                ),
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
          },
      ),
    );
  }
}
