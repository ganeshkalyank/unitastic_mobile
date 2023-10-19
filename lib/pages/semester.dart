import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();
    DateTime lastUpdated = DateTime.parse(
        prefs.getString('semester_${widget.semesterid}_lastupdated')
            ?? '2000-01-01 00:00:00.000'
    );
    bool isDirty = DateTime.now().difference(lastUpdated).inHours > 24;

    final db = FirebaseFirestore.instance;
    final subjectsRef = db.collection('semesters').doc(widget.semesterid).collection('subjects');
    final departmentsRef = db.collection('semesters').doc(widget.semesterid).collection('depts');
    QuerySnapshot<Map<String, dynamic>> subjects;
    QuerySnapshot<Map<String, dynamic>> departments;

    if (isDirty) {
      subjects = await subjectsRef.orderBy('name').get(
        const GetOptions(source: Source.server),
      );
      departments = await departmentsRef.orderBy('name').get(
        const GetOptions(source: Source.cache),
      );
      if (subjects.size == 0) {
        departments = await departmentsRef.orderBy('name').get(
          const GetOptions(source: Source.server),
        );
      }
      await prefs.setString('semester_${widget.semesterid}_lastupdated', DateTime.now().toString());
    } else {
      subjects = await subjectsRef.orderBy('name').get(
        const GetOptions(source: Source.cache),
      );
      departments = await departmentsRef.orderBy('name').get(
        const GetOptions(source: Source.cache),
      );
      if (subjects.size == 0 && departments.size == 0) {
        subjects = await subjectsRef.orderBy('name').get(
          const GetOptions(source: Source.server),
        );
        if (subjects.size == 0) {
          departments = await departmentsRef.orderBy('name').get(
            const GetOptions(source: Source.server),
          );
        }
      }
    }

    if (subjects.size > 0) {
      return subjects.docs.map((subject) {
        final subjectData = subject.data();
        return {
          'id': subject.id,
          'name': subjectData['name'],
          'description': subjectData['description'],
          'url': subjectData['url'],
        };
      }).toList();
    } else {
      return departments.docs.map((department) {
        final departmentData = department.data();
        return {
          'id': department.id,
          'name': departmentData['name'],
          'description': departmentData['description'],
          'url': departmentData['url'],
        };
      }).toList();
    }
  }

  Future<String> _getTitle() async {
    final prefs = await SharedPreferences.getInstance();

    final db = FirebaseFirestore.instance;
    DateTime lastUpdated = DateTime.parse(
        prefs.getString('semester_${widget.semesterid}_lastupdated')
            ?? '2000-01-01 00:00:00.000'
    );
    bool isDirty = DateTime.now().difference(lastUpdated).inHours > 24;
    if (isDirty) {
      final subjectsRef = db.collection('semesters').doc(widget.semesterid).collection('subjects');
      final subjects = await subjectsRef.get(
        const GetOptions(source: Source.server),
      );
      if (subjects.size > 0) {
        return 'Select Subject';
      }
      return 'Select Department';
    } else {
      final subjectsRef = db.collection('semesters').doc(widget.semesterid).collection('subjects');
      var subjects = await subjectsRef.get(
        const GetOptions(source: Source.cache),
      );
      final departments = await db.collection('semesters').doc(widget.semesterid).collection('depts').get(
        const GetOptions(source: Source.cache),
      );
      if (subjects.size > 0) {
        return 'Select Subject';
      } else if (departments.size > 0) {
        return 'Select Department';
      } else if (subjects.size == 0 && departments.size == 0) {
        subjects = await subjectsRef.get(
          const GetOptions(source: Source.server),
        );
        if (subjects.size > 0) {
          return 'Select Subject';
        } else {
          return 'Select Department';
        }
      }
    }
    return 'Select Subject';
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
                              _openMaterial(subject['url']).catchError((e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(
                                          'No materials found for this course!',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
