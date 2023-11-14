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
  final List<Map<String, String>> _usefulLinks = [
    {
      'title': 'Student Web Interface',
      'url': 'https://webstream.sastra.edu/sastrapwi/',
    },
    {
      'title': 'Parent Web Interface',
      'url': 'https://webstream.sastra.edu/sastraparentweb/',
    },
    {
      'title': 'Hostel Leave Portal',
      'url': 'https://biometric.sastra.edu/',
    },
    {
      'title': 'Academic Calendar',
      'url': 'https://www.sastra.edu/downloads/menu/Academics/Academic_Calender_2023_24_TPJ.pdf',
    },
  ];

  final List<Map<String, String>> _archives = [
    {
      'title': 'Materialbase',
      'url': 'https://materialbase.github.io',
    },
    {
      'title': 'Materialhub',
      'url': 'https://linktr.ee/materialhub',
    },
  ];

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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
                color: Theme.of(context).colorScheme.primaryContainer,
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
                                        color: Theme.of(context).colorScheme.primary,
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
                surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
                color: Theme.of(context).colorScheme.primaryContainer,
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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _usefulLinks.length,
            itemBuilder: (context, index) {
              return Card(
                surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
                color: Theme.of(context).colorScheme.primaryContainer,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    _usefulLinks[index]['title']!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl(_usefulLinks[index]['url']!).catchError((e) {
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
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Archives',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _archives.length,
            itemBuilder: (context, index) {
              return Card(
                surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
                color: Theme.of(context).colorScheme.primaryContainer,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    _archives[index]['title']!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    _openUrl(_archives[index]['url']!).catchError((e) {
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
              );
            },
          ),
          // const SizedBox(height: 16),
          /*const Text(
            'Crafted with ❤️ by Bathula Harshitha',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),*/
          const SizedBox(height: 16),
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
