
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  }

  runApp(const AfriConnectApp());
}

class AfriConnectApp extends StatelessWidget {
  const AfriConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriConnect',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16834A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
      ),
      home: const AfriHomePage(),
    );
  }
}

class AfriHomePage extends StatefulWidget {
  const AfriHomePage({super.key});

  @override
  State<AfriHomePage> createState() => _AfriHomePageState();
}

class _AfriHomePageState extends State<AfriHomePage> {
  String selectedCountry = 'Nigeria';
  String selectedLanguage = 'English';
  int selectedIndex = 0;

  final List<String> countries = [
    'Nigeria',
    'Ghana',
    'Cameroon',
    'Côte d’Ivoire',
    'Senegal',
    'Mali',
  ];

  final List<String> languages = [
    'English',
    'Français',
    'Deutsch',
  ];

  final List<Map<String, dynamic>> services = [
    {
      'icon': Icons.storefront,
      'title': 'Marketplace',
      'subtitle': 'Buy and sell products',
    },
    {
      'icon': Icons.work,
      'title': 'Jobs',
      'subtitle': 'Find employment',
    },
    {
      'icon': Icons.local_shipping,
      'title': 'Delivery',
      'subtitle': 'Transport and delivery',
    },
    {
      'icon': Icons.school,
      'title': 'Education',
      'subtitle': 'Learn new skills',
    },
    {
      'icon': Icons.health_and_safety,
      'title': 'Health',
      'subtitle': 'Health information',
    },
    {
      'icon': Icons.people,
      'title': 'Community',
      'subtitle': 'Connect with people',
    },
  ];

  String get greeting {
    switch (selectedLanguage) {
      case 'Français':
        return 'Bienvenue sur AfriConnect';
      case 'Deutsch':
        return 'Willkommen bei AfriConnect';
      default:
        return 'Welcome to AfriConnect';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(
              Icons.public,
              color: Color(0xFF16834A),
              size: 30,
            ),
            SizedBox(width: 8),
            Text(
              'AfriConnect',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications coming soon'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: selectedIndex == 0
          ? _home()
          : _simplePage(
              ['Home', 'Explore', 'Messages', 'Profile'][selectedIndex],
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _home() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF16834A),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Connecting people, businesses and opportunities across Africa.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Choose your country',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedCountry,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            items: countries.map((country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedCountry = value;
                });
              }
            },
          ),
          const SizedBox(height: 18),
          const Text(
            'Select language',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.language),
            ),
            items: languages.map((language) {
              return DropdownMenuItem<String>(
                value: language,
                child: Text(language),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedLanguage = value;
                });
              }
            },
          ),
          const SizedBox(height: 25),
          const Text(
            'Explore AfriConnect',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final service = services[index];

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${service['title']} - Coming soon!',
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        service['icon'] as IconData,
                        color: const Color(0xFF16834A),
                        size: 35,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        service['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        service['subtitle'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 25),
          const Text(
            'Our mission',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'AfriConnect brings African communities together. '
            'Our goal is to make business, education, jobs and '
            'everyday services easier to access.',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _simplePage(String title) {
    return Center(
      child: Text(
        '$title\nComing soon',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
