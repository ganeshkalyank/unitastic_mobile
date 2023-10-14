import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SemesterPage extends StatefulWidget {
  const SemesterPage({super.key, required this.semesterid});

  final String semesterid;

  @override
  State<SemesterPage> createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {

  getStream() {
    final db = FirebaseFirestore.instance;
    final deptsRef = db.collection('semesters').doc(widget.semesterid).collection('depts');
    final subjectsRef = db.collection('semesters').doc(widget.semesterid).collection('subjects');
    if (widget.semesterid == 'L2VjryF74kls5LR4ZiYU' || widget.semesterid == 'fE8kQXlfVFbD9SpU25Qt') {
      return subjectsRef.orderBy('name').snapshots();
    } else {
      return deptsRef.orderBy('name').snapshots();
    }
  }

  _openMaterial(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
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
        child: Column(
          children: [
            Text(
              widget.semesterid == 'L2VjryF74kls5LR4ZiYU' ||
              widget.semesterid == 'fE8kQXlfVFbD9SpU25Qt'
                  ? 'Select Subject' : 'Select Department',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder(
                stream: getStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentSnapshot subject = snapshot.data!.docs[index];
                      final subjectData = subject.data() as Map<String, dynamic>;
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
                          subtitle: subjectData.containsKey('description') && subject['description']!=''?Text(
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
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
