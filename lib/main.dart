
import 'package:flutter/material.dart';

void main() {
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
  int selectedIndex = 0;

  final List<Map<String, dynamic>> services = [
    {'name': 'Marketplace', 'icon': Icons.store, 'description': 'Buy and sell products'},
    {'name': 'Jobs', 'icon': Icons.work, 'description': 'Find jobs and employees'},
    {'name': 'Delivery', 'icon': Icons.local_shipping, 'description': 'Organize deliveries'},
    {'name': 'Education', 'icon': Icons.school, 'description': 'Learn and discover courses'},
    {'name': 'Health', 'icon': Icons.health_and_safety, 'description': 'Health information and support'},
    {'name': 'Community', 'icon': Icons.people, 'description': 'Connect with people'},
  ];

  final List<String> countries = [
    'Nigeria',
    'Ghana',
    'Cameroon',
    "Côte d’Ivoire",
    'Senegal',
    'Mali',
  ];

  String selectedCountry = 'Nigeria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AfriConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showMessage('Notifications coming soon'),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => _showMessage('Profile coming soon'),
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
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.chat_outlined), label: 'Messages'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _home() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Welcome to AfriConnect',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Connecting Africa through one platform'),
        const SizedBox(height: 20),
        const Text('Select your country'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedCountry,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.public),
          ),
          items: countries.map((country) {
            return DropdownMenuItem(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedCountry = value);
            }
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Explore our services',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...services.map((service) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade50,
                child: Icon(service['icon'], color: Colors.green),
              ),
              title: Text(
                service['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(service['description']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServicePage(
                      title: service['name'],
                      description: service['description'],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class ServicePage extends StatelessWidget {
  final String title;
  final String description;

  const ServicePage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 24),
            const Text(
              'This section is being developed.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

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
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                return DropdownMenuItem(
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
                return DropdownMenuItem(
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
              style: TextStyle(fontSize: 15, height: 1.5),
            ),

            const SizedBox(height: 25),
          ],
        ),
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
}
