import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({super.key});

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  String _version = '';
  String _buildNumber = '';

  Future<void> _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Text(
              'Thanks for using Unitastic!',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Please consider providing your feedback or contributing materials.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: InkWell(
                    onTap: () {
                      _openUrl('https://unitastic.netlify.app/feedback').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.feedback,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Feedback',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: InkWell(
                    onTap: () {
                      _openUrl('https://unitastic.netlify.app/contribute').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_link,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Contribute',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Divider(
              color: Theme.of(context).colorScheme.tertiary,
              thickness: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Useful Links',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    'Student Web Interface',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl('https://webstream.sastra.edu/sastrapwi/').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
              ),
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    'Parent Web Interface',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl('https://webstream.sastra.edu/sastraparentweb/').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
              ),
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    'Hostel Leave Portal',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl('https://biometric.sastra.edu/').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
              ),
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    'Academic Calendar',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl('https://www.sastra.edu/downloads/menu/Academics/Academic_Calender_2023_24_TPJ.pdf').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Archives',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Card (
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    'Materialbase',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl('https://materialbase.github.io').catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Could not open URL!',
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
              ),
              Card(
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    'Materialhub',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl('https://linktr.ee/materialhub').catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    'Could not open URL!',
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
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Crafted with ❤️ by Harshitha',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'v$_version+$_buildNumber',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
