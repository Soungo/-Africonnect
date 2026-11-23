import 'package:flutter/material.dart';

void main() => runApp(const AfriConnectApp());

class AfriConnectApp extends StatefulWidget {
  const AfriConnectApp({super.key});

  @override
  State<AfriConnectApp> createState() => _AfriConnectAppState();
}

class _AfriConnectAppState extends State<AfriConnectApp> {
  Locale locale = const Locale('en');

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AfriConnect',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16834A)),
          scaffoldBackgroundColor: const Color(0xFFF7F8F6),
        ),
        home: AfriHome(
          locale: locale,
          onLanguage: (value) => setState(() => locale = Locale(value)),
        ),
      );
}

class AfriHome extends StatefulWidget {
  const AfriHome({super.key, required this.locale, required this.onLanguage});
  final Locale locale;
  final ValueChanged<String> onLanguage;

  @override
  State<AfriHome> createState() => _AfriHomeState();
}

class _AfriHomeState extends State<AfriHome> {
  int tab = 0;
  String country = 'Nigeria';
  String search = '';

  bool get fr => widget.locale.languageCode == 'fr';
  String t(String en, String french) => fr ? french : en;

  final countries = const [
    ('Nigeria', '🇳🇬'),
    ('Ghana', '🇬🇭'),
    ('Cameroon', '🇨🇲'),
    ('Côte d’Ivoire', '🇨🇮'),
    ('Senegal', '🇸🇳'),
    ('Mali', '🇲🇱'),
  ];

  @override
  Widget build(BuildContext context) {
    final names = [
      t('Discover', 'Découvrir'),
      t('Marketplace', 'Marché'),
      t('Jobs', 'Emplois'),
      t('Community', 'Communauté'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          CircleAvatar(
            backgroundColor: Color(0xFF16834A),
            child: Icon(Icons.public, color: Colors.white),
          ),
          SizedBox(width: 10),
          Text('AfriConnect', style: TextStyle(fontWeight: FontWeight.w800)),
        ]),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: widget.onLanguage,
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'fr', child: Text('Français')),
            ],
          ),
        ],
      ),
      body: tab == 0 ? discover() : section(names[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.explore_outlined), label: t('Home', 'Accueil')),
          NavigationDestination(icon: const Icon(Icons.storefront_outlined), label: t('Market', 'Marché')),
          NavigationDestination(icon: const Icon(Icons.work_outline), label: t('Jobs', 'Emplois')),
          NavigationDestination(icon: const Icon(Icons.people_outline), label: t('Community', 'Communauté')),
        ],
      ),
    );
  }

  Widget discover() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t('Connecting people. Creating opportunities.',
                'Relier les personnes. Créer des opportunités.'),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(t(
            'One place for business, work and community across Africa.',
            'Un espace pour le commerce, le travail et la communauté en Afrique.',
          )),
          const SizedBox(height: 18),
          countryPicker(),
          const SizedBox(height: 14),
          TextField(
            onChanged: (value) => setState(() => search = value),
            decoration: InputDecoration(
              hintText: t('Search products, jobs or people', 'Rechercher des produits, emplois ou personnes'),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          const SizedBox(height: 22),
          Text(t('Explore AfriConnect', 'Explorer AfriConnect'),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          feature(Icons.storefront, 'Marketplace',
              t('Buy and sell goods and services', 'Acheter et vendre des produits et services'), 1),
          feature(Icons.work, t('Jobs & opportunities', 'Emplois et opportunités'),
              t('Find work and discover talent', 'Trouver un emploi et découvrir des talents'), 2),
          feature(Icons.people, 'Community',
              t('Connect with people around you', 'Créer des liens avec votre communauté'), 3),
          const SizedBox(height: 18),
          Text(t('Popular in $country', 'Populaire en $country'),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          demoTile(Icons.shopping_bag_outlined, 'Fresh local produce',
              'Example marketplace listing • Demo'),
          demoTile(Icons.work_outline, 'Community sales assistant',
              'Example job opportunity • Demo'),
          if (search.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(t('Demo search: ', 'Recherche démo : ') + search),
            ),
          const SizedBox(height: 20),
          Center(child: Text('AfriConnect • ${t('Connecting Africa', 'Connecter l’Afrique')}')),
        ],
      );

  Widget countryPicker() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(children: [
          const Icon(Icons.location_on_outlined, color: Color(0xFF16834A)),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: country,
                isExpanded: true,
                items: countries.map((item) => DropdownMenuItem(
                  value: item.$1, child: Text('${item.$2}  ${item.$1}'),
                )).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => country = value);
                },
              ),
            ),
          ),
        ]),
      );

  Widget feature(IconData icon, String title, String subtitle, int destination) =>
      Card(
        elevation: 0,
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFE5F4EA),
            child: Icon(icon, color: const Color(0xFF16834A)),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => setState(() => tab = destination),
        ),
      );

  Widget demoTile(IconData icon, String title, String subtitle) => Card(
        elevation: 0,
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFE5F4EA),
            child: Icon(icon, color: const Color(0xFF16834A)),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
        ),
      );

  Widget section(String title) {
    final market = tab == 1;
    final jobs = tab == 2;
    final icon = market ? Icons.storefront : jobs ? Icons.work_outline : Icons.people_outline;
    final description = market
        ? t('Discover products and services from local sellers.',
            'Découvrez les produits et services des vendeurs locaux.')
        : jobs
            ? t('Explore job opportunities and connect with employers.',
                'Découvrez des offres d’emploi et contactez les employeurs.')
            : t('Share ideas, ask questions and connect with your community.',
                'Partagez des idées, posez des questions et échangez avec votre communauté.');
    return ListView(padding: const EdgeInsets.all(20), children: [
      Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 14),
      Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE5F4EA),
              child: Icon(icon, color: const Color(0xFF16834A)),
            ),
            const SizedBox(height: 14),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text(
              t('Demo section — live listings will appear after the backend is connected.',
                  'Section démo — les annonces réelles apparaîtront après la connexion du serveur.'),
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ]),
        ),
      ),
    ]);
  }
}
