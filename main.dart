import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const AfriConnectApp());

class AfriConnectApp extends StatefulWidget {
  const AfriConnectApp({super.key});

  @override
  State<AfriConnectApp> createState() => _AfriConnectAppState();
}

class _AfriConnectAppState extends State<AfriConnectApp> {
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriConnect',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppStrings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16865B)),
        scaffoldBackgroundColor: const Color(0xFFF5F8F6),
      ),
      home: HomePage(
        locale: _locale,
        onLocaleChanged: (value) => setState(() => _locale = value),
      ),
    );
  }
}

class AppStrings {
  AppStrings(this.locale);
  final Locale locale;
  static AppStrings of(BuildContext context) =>
      AppStrings(Localizations.localeOf(context));
  static const LocalizationsDelegate<AppStrings> delegate = _StringsDelegate();

  bool get fr => locale.languageCode == 'fr';
  String get tagline => fr ? 'Connecter l’Afrique' : 'Connecting Africa';
  String get welcome => fr ? 'Bienvenue sur AfriConnect' : 'Welcome to AfriConnect';
  String get intro => fr
      ? 'Des services utiles, réunis au même endroit.'
      : 'Useful services, all in one place.';
  String get country => fr ? 'Pays' : 'Country';
  String get language => fr ? 'Langue' : 'Language';
  String get explore => fr ? 'Découvrir les services' : 'Explore services';
  String get footer => fr
      ? 'Ensemble, créons des opportunités en Afrique.'
      : 'Together, creating opportunities across Africa.';
  String get selectCountry => fr ? 'Choisir un pays' : 'Choose a country';
  String get marketplace => fr ? 'Marché' : 'Marketplace';
  String get jobs => fr ? 'Emplois' : 'Jobs';
  String get delivery => fr ? 'Livraison' : 'Delivery';
  String get education => fr ? 'Éducation' : 'Education';
  String get health => fr ? 'Santé' : 'Health';
  String get community => fr ? 'Communauté' : 'Community';
}

class _StringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _StringsDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);
  @override
  Future<AppStrings> load(Locale locale) async => AppStrings(locale);
  @override
  bool shouldReload(_StringsDelegate old) => false;
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String country = 'Nigeria';

  static const countries = [
    'Nigeria',
    'Ghana',
    'Cameroon',
    'Côte d’Ivoire',
    'Senegal',
    'Mali',
  ];

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final services = [
      _Service(s.marketplace, 'Find and offer products', 'Acheter et vendre', Icons.storefront_rounded, const Color(0xFFE4F3EA)),
      _Service(s.jobs, 'Discover opportunities', 'Trouver des opportunités', Icons.work_rounded, const Color(0xFFFFEEDB)),
      _Service(s.delivery, 'Send and receive items', 'Envoyer et recevoir', Icons.local_shipping_rounded, const Color(0xFFE4EFFB)),
      _Service(s.education, 'Learn new skills', 'Apprendre de nouvelles compétences', Icons.school_rounded, const Color(0xFFF0E8FA)),
      _Service(s.health, 'Find health information', 'Informations de santé', Icons.health_and_safety_rounded, const Color(0xFFFFE8E8)),
      _Service(s.community, 'Connect with people', 'Créer des liens', Icons.groups_rounded, const Color(0xFFFFF4D8)),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F8F6),
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF16865B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.public_rounded, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text('AfriConnect', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Locale>(
                value: widget.locale,
                items: const [
                  DropdownMenuItem(value: Locale('en'), child: Text('EN')),
                  DropdownMenuItem(value: Locale('fr'), child: Text('FR')),
                ],
                onChanged: (value) {
                  if (value != null) widget.onLocaleChanged(value);
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D704B), Color(0xFF21A36D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.tagline.toUpperCase(),
                          style: const TextStyle(color: Colors.white70, letterSpacing: 1.4, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 18),
                      Text(s.welcome,
                          style: const TextStyle(color: Colors.white, fontSize: 28, height: 1.15, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 10),
                      Text(s.intro, style: const TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 22),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _selector(
                            label: s.country,
                            child: DropdownButton<String>(
                              value: country,
                              dropdownColor: Colors.white,
                              underline: const SizedBox(),
                              isDense: true,
                              items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                              onChanged: (v) => setState(() => country = v ?? country),
                            ),
                          ),
                          _selector(
                            label: s.language,
                            child: DropdownButton<Locale>(
                              value: widget.locale,
                              underline: const SizedBox(),
                              isDense: true,
                              items: const [
                                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                                DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
                              ],
                              onChanged: (v) {
                                if (v != null) widget.onLocaleChanged(v);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(s.explore, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF173B2C))),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 760 ? 3 : constraints.maxWidth >= 480 ? 2 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 145,
                      ),
                      itemBuilder: (context, index) {
                        final item = services[index];
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Color(0xFFE6ECE8)),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item.title} — coming soon')),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(color: item.tint, borderRadius: BorderRadius.circular(13)),
                                    child: Icon(item.icon, color: const Color(0xFF176B4A), size: 25),
                                  ),
                                  const Spacer(),
                                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                                  const SizedBox(height: 3),
                                  Text(widget.locale.languageCode == 'fr' ? item.frDescription : item.enDescription,
                                      style: const TextStyle(color: Color(0xFF68756E), fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(s.footer, textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF718078), fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selector({required String label, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF627168))),
          child,
        ],
      ),
    );
  }
}

class _Service {
  const _Service(this.title, this.enDescription, this.frDescription, this.icon, this.tint);
  final String title;
  final String enDescription;
  final String frDescription;
  final IconData icon;
  final Color tint;
}
