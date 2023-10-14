import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitastic_mobile/pages/semester.dart';

class MaterialsWidget extends StatefulWidget {
  const MaterialsWidget({super.key});

  @override
  State<MaterialsWidget> createState() => _MaterialsWidgetState();
}

class _MaterialsWidgetState extends State<MaterialsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Select Semester',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('semesters').orderBy('name').snapshots(),
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
                  DocumentSnapshot semester = snapshot.data!.docs[index];
                  final semesterData = semester.data() as Map<String, dynamic>;
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
                      subtitle: semesterData.containsKey('description') && semester['description']!=''?Text(
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
                              semesterid: semester.id,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
