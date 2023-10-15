import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SemesterPage extends StatefulWidget {
  const SemesterPage({super.key, required this.semesterid});

  final String semesterid;

  @override
  State<SemesterPage> createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  late Future<List<Map<String,dynamic>>> _materials;
  late Future<String> _title;

  Future<List<Map<String,dynamic>>> _getMaterials() async {
    final db = FirebaseFirestore.instance;
    final subjectsRef = db.collection('semesters').doc(widget.semesterid).collection('subjects');
    final subjects = await subjectsRef.orderBy('name').get();
    final departmentsRef = db.collection('semesters').doc(widget.semesterid).collection('depts');
    final departments = await departmentsRef.orderBy('name').get();
    final List<Map<String,dynamic>> materials = [];
    if (subjects.size > 0) {
      for (var subject in subjects.docs) {
        final subjectData = subject.data();
        materials.add({
          'id': subject.id,
          'name': subjectData['name'],
          'description': subjectData['description'],
          'url': subjectData['url'],
        });
      }
    } else {
      for (var department in departments.docs) {
        final departmentData = department.data();
        materials.add({
          'id': department.id,
          'name': departmentData['name'],
          'description': departmentData['description'],
          'url': departmentData['url'],
        });
      }
    }
    return materials;
  }

  Future<String> _getTitle() async {
    final db = FirebaseFirestore.instance;
    final semestersRef = db.collection('semesters').doc(widget.semesterid).collection('subjects');
    final semester = await semestersRef.get();
    if (semester.size > 0) {
      return 'Select Subject';
    }
    return 'Select Department';
  }

  Future<void> _openMaterial(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _materials = _getMaterials();
    _title = _getTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.tertiary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Unitastic',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: _materials,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                );
              }
              if (snapshot.hasError || snapshot.data!.isEmpty) {
                return Center(
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
                );
              }
              return Column(
                children: [
                  FutureBuilder(
                    future: _title,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return Text(
                        snapshot.data.toString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final subject = snapshot.data![index];
                      return Card(
                        surfaceTintColor: Colors.white,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          title: Text(
                            subject['name'],
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          subtitle: subject['description'] != null && subject['description'] != '' ? Text(
                            subject['description'],
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ) : null,
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          onTap: () {
                            try {
                              _openMaterial(subject['url']);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'No materials found for this subject',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
        ),
      ),
    );
  }
}
