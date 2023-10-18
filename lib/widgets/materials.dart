import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitastic_mobile/pages/semester.dart';

class MaterialsWidget extends StatefulWidget {
  const MaterialsWidget({super.key});

  @override
  State<MaterialsWidget> createState() => _MaterialsWidgetState();
}

class _MaterialsWidgetState extends State<MaterialsWidget> {
  late Future<List<Map<String,dynamic>>> _materials;

  Future<List<Map<String,dynamic>>> _getMaterials() async {
    final db = FirebaseFirestore.instance;
    final semestersRef = db.collection('semesters');
    final semesters = await semestersRef.orderBy('name').get();
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
                        surfaceTintColor: Colors.white,
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
