import 'package:flutter/material.dart';

void main() => runApp(const WanderlyApp());

// ───────────── Design tokens ─────────────
const midnight = Color(0xFF111827);
const offWhite = Color(0xFFF8FAFC);
const slate = Color(0xFF64748B);
const amber = Color(0xFFF59E0B);
const teal = Color(0xFF14B8A6);

bool dk(BuildContext c) => Theme.of(c).brightness == Brightness.dark;
Color surf(BuildContext c) => dk(c) ? const Color(0xFF172033) : Colors.white;
Color ink(BuildContext c) => dk(c) ? offWhite : midnight;
Color hair(BuildContext c) => dk(c) ? const Color(0x22FFFFFF) : const Color(0x14111827);
TextStyle serif(BuildContext c, double s) => TextStyle(
    fontFamily: 'Georgia',
    fontFamilyFallback: const ['Times New Roman', 'serif'],
    fontSize: s,
    fontWeight: FontWeight.w700,
    color: ink(c),
    height: 1.15);

ThemeData buildTheme(bool dark) {
  final cs = ColorScheme.fromSeed(
          seedColor: teal, brightness: dark ? Brightness.dark : Brightness.light)
      .copyWith(
          primary: dark ? teal : midnight,
          onPrimary: dark ? midnight : Colors.white,
          secondary: amber);
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
  const pad = EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: dark ? const Color(0xFF0B1220) : offWhite,
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(padding: pad, shape: shape)),
    outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(padding: pad, shape: shape)),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}

// ───────────── Data ─────────────
String img(String id) => 'https://images.unsplash.com/photo-$id?auto=format&fit=crop&w=900&q=75';
final covers = [
  img('1502602898657-3e91760cbb34'),
  img('1493976040374-85c8e12f0c0e'),
  img('1507525428034-b723cf961d3e'),
  img('1506905925346-21bda4d32df4'),
  img('1476514525535-07fb3b4ae5f1'),
  img('1523906834658-6e24ef2386f9'),
  img('1469474968028-56623f02e42e'),
  img('1531366936337-7c912a4589a7'),
  img('1501785888041-af3ef285b470'),
  img('1500530855697-b586d89ba3ee'),
];

const _m = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
const _wd = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
String fmt(DateTime d) => '${_m[d.month - 1]} ${d.day}, ${d.year}';
String range(Trip t) =>
    '${_m[t.start.month - 1]} ${t.start.day} – ${_m[t.end.month - 1]} ${t.end.day}, ${t.end.year}';

class Trip {
  String id, name, destination, country, cover, desc, companions;
  DateTime start, end;
  int photos;
  Trip({required this.id, required this.name, required this.destination, required this.country,
      required this.cover, required this.desc, required this.companions,
      required this.start, required this.end, required this.photos});
}

class Entry {
  String title, text, cover, trip;
  DateTime date;
  Entry(this.title, this.text, this.cover, this.trip, this.date);
}

class Place {
  String city, country, image;
  bool visited;
  Place(this.city, this.country, this.image, this.visited);
}

class AppState extends ChangeNotifier {
  bool dark = false;
  int page = 0;
  String query = '', name = 'Abhi';
  int uploaded = 0;

  final trips = <Trip>[
    Trip(id: '1', name: 'Paris in Spring', destination: 'Paris', country: 'France', cover: covers[0],
        desc: 'Café mornings, museum afternoons and golden-hour walks along the Seine.',
        companions: 'Maya, Arjun', start: DateTime(2026, 4, 10), end: DateTime(2026, 4, 17), photos: 142),
    Trip(id: '2', name: 'Kyoto in Bloom', destination: 'Kyoto', country: 'Japan', cover: covers[1],
        desc: 'Cherry blossoms, quiet temples and the best matcha of my life.',
        companions: 'Solo', start: DateTime(2025, 3, 28), end: DateTime(2025, 4, 6), photos: 236),
    Trip(id: '3', name: 'Amalfi Escape', destination: 'Positano', country: 'Italy', cover: covers[2],
        desc: 'Cliffside villages, lemon groves and long seaside dinners.',
        companions: 'Riya, Karan', start: DateTime(2025, 9, 2), end: DateTime(2025, 9, 9), photos: 118),
    Trip(id: '4', name: 'Swiss Alps Trek', destination: 'Interlaken', country: 'Switzerland', cover: covers[3],
        desc: 'Alpine trails, glacier lakes and the quietest sunrise I have seen.',
        companions: 'Dev', start: DateTime(2024, 7, 12), end: DateTime(2024, 7, 20), photos: 174),
    Trip(id: '5', name: 'Venice Weekend', destination: 'Venice', country: 'Italy', cover: covers[5],
        desc: 'Lost in the canals with no map and no plan.',
        companions: 'Maya', start: DateTime(2024, 2, 9), end: DateTime(2024, 2, 12), photos: 64),
    Trip(id: '6', name: 'Northern Lights', destination: 'Tromsø', country: 'Norway', cover: covers[7],
        desc: 'Chasing the aurora across the Arctic night.',
        companions: 'Arjun, Dev', start: DateTime(2026, 1, 15), end: DateTime(2026, 1, 21), photos: 98),
  ];

  final entries = <Entry>[
    Entry('The quiet streets of Gion', 'Woke up before sunrise and wandered the empty lanes. The whole district felt like it belonged to me for an hour.', covers[1], 'Kyoto in Bloom', DateTime(2025, 4, 2)),
    Entry('Lights over the fjord', 'Three hours of waiting in the cold, then the sky finally lit up green. Nobody spoke a word.', covers[7], 'Northern Lights', DateTime(2026, 1, 18)),
    Entry('A Seine-side sunset', 'Bought a baguette, found a bench, and watched the city turn gold.', covers[0], 'Paris in Spring', DateTime(2026, 4, 13)),
    Entry('Above the clouds', 'The final climb was brutal, the view was worth every step.', covers[3], 'Swiss Alps Trek', DateTime(2024, 7, 16)),
  ];

  final places = <Place>[
    Place('Paris', 'France', covers[0], true),
    Place('Kyoto', 'Japan', covers[1], true),
    Place('Positano', 'Italy', covers[2], true),
    Place('Interlaken', 'Switzerland', covers[3], true),
    Place('Venice', 'Italy', covers[5], true),
    Place('Tromsø', 'Norway', covers[7], true),
    Place('Santorini', 'Greece', covers[4], false),
    Place('Banff', 'Canada', covers[8], false),
  ];

  late final gallery = <String>[...covers];

  void _n() => notifyListeners();
  void go(int i) { page = i; _n(); }
  void search(String q) { query = q; page = 1; _n(); }
  void setDark(bool v) { dark = v; _n(); }
  void setName(String v) { name = v; _n(); }
  void saveTrip(Trip t) {
    final i = trips.indexWhere((e) => e.id == t.id);
    i < 0 ? trips.insert(0, t) : trips[i] = t;
    _n();
  }
  void deleteTrip(String id) { trips.removeWhere((e) => e.id == id); _n(); }
  void addEntry(Entry e) { entries.insert(0, e); _n(); }
  void deleteEntry(Entry e) { entries.remove(e); _n(); }
  void addPlace(Place p) { places.insert(0, p); _n(); }
  void togglePlace(Place p) { p.visited = !p.visited; _n(); }
  void removePlace(Place p) { places.remove(p); _n(); }
  void addPhoto() { uploaded++; gallery.insert(0, covers[uploaded % covers.length]); _n(); }

  int get totalPhotos => trips.fold(0, (a, t) => a + t.photos) + uploaded;
  Set<String> get countries =>
      {...trips.map((t) => t.country), ...places.where((p) => p.visited).map((p) => p.country)};
  Set<String> get cities =>
      {...trips.map((t) => t.destination), ...places.where((p) => p.visited).map((p) => p.city)};
}

final app = AppState();

// ───────────── App + Shell ─────────────
class WanderlyApp extends StatelessWidget {
  const WanderlyApp({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: app,
        builder: (c, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wanderly',
          theme: buildTheme(false),
          darkTheme: buildTheme(true),
          themeMode: app.dark ? ThemeMode.dark : ThemeMode.light,
          home: Shell(),
        ),
      );
}

const nav = [
  ('Dashboard', Icons.space_dashboard_outlined),
  ('My Trips', Icons.luggage_outlined),
  ('Travel Journal', Icons.menu_book_outlined),
  ('Explore', Icons.explore_outlined),
  ('Photo Gallery', Icons.photo_library_outlined),
  ('Destinations', Icons.place_outlined),
  ('Settings', Icons.settings_outlined),
];

class Shell extends StatelessWidget {
  Shell({super.key});
  Widget pageFor(int i) {
    switch (i) {
      case 1: return TripsPage();
      case 2: return JournalPage();
      case 3: return ExplorePage();
      case 4: return GalleryPage();
      case 5: return DestinationsPage();
      case 6: return SettingsPage();
      default: return Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: app,
        builder: (context, _) => LayoutBuilder(builder: (c, b) {
          final wide = b.maxWidth >= 900;
          final body = Column(children: [
            TopBar(wide),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: KeyedSubtree(key: ValueKey(app.page), child: pageFor(app.page)),
              ),
            ),
          ]);
          return Scaffold(
            drawer: wide ? null : Drawer(child: Sidebar(drawer: true)),
            body: wide
                ? Row(children: [SizedBox(width: 264, child: Sidebar()), Expanded(child: body)])
                : SafeArea(child: body),
          );
        }),
      );
}

class Sidebar extends StatelessWidget {
  final bool drawer;
  Sidebar({super.key, this.drawer = false});
  @override
  Widget build(BuildContext c) => Container(
        decoration: BoxDecoration(
            color: surf(c), border: drawer ? null : Border(right: BorderSide(color: hair(c)))),
        padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [teal, amber]),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.travel_explore_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Text('Wanderly', style: serif(c, 24)),
              ]),
            ),
            const SizedBox(height: 32),
            for (var i = 0; i < nav.length; i++) NavTile(i, drawer),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [midnight, Color(0xFF1F2A44)]),
                  borderRadius: BorderRadius.circular(18)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Next adventure?',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 4),
                const Text('Start planning your next trip.',
                    style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13)),
                const SizedBox(height: 12),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: amber, foregroundColor: midnight,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                  onPressed: () => showTripForm(c),
                  child: const Text('New trip'),
                ),
              ]),
            ),
          ]),
        ),
      );
}

class NavTile extends StatelessWidget {
  final int i;
  final bool drawer;
  NavTile(this.i, this.drawer, {super.key});
  @override
  Widget build(BuildContext c) {
    final sel = app.page == i;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        hoverColor: slate.withAlpha(25),
        onTap: () {
          app.go(i);
          if (drawer) Navigator.pop(c);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
              color: sel ? (dk(c) ? teal.withAlpha(60) : midnight) : Colors.transparent,
              borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            Icon(nav[i].$2, size: 21, color: sel ? Colors.white : slate),
            const SizedBox(width: 14),
            Text(nav[i].$1,
                style: TextStyle(fontWeight: FontWeight.w600, color: sel ? Colors.white : ink(c))),
          ]),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final bool wide;
  TopBar(this.wide, {super.key});
  @override
  Widget build(BuildContext c) => Container(
        height: 72,
        padding: EdgeInsets.symmetric(horizontal: wide ? 28 : 12),
        decoration: BoxDecoration(color: surf(c), border: Border(bottom: BorderSide(color: hair(c)))),
        child: Row(children: [
          if (!wide)
            Builder(
                builder: (c) => IconButton(
                    icon: const Icon(Icons.menu_rounded), onPressed: () => Scaffold.of(c).openDrawer())),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: TextField(
                  onSubmitted: app.search,
                  decoration: InputDecoration(
                    hintText: 'Search trips, places, memories…',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: slate.withAlpha(24),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
          PopupMenuButton<int>(
            tooltip: 'Notifications',
            icon: const Badge(smallSize: 8, child: Icon(Icons.notifications_none_rounded)),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 0, child: Text('Your Kyoto album is ready to share')),
              PopupMenuItem(value: 1, child: Text('1 year since your Swiss Alps trip')),
              PopupMenuItem(value: 2, child: Text('Weekly travel summary available')),
            ],
          ),
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(dk(c) ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () => app.setDark(!app.dark),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 18,
            backgroundColor: amber,
            child: Text(app.name.isEmpty ? '?' : app.name[0].toUpperCase(),
                style: const TextStyle(color: midnight, fontWeight: FontWeight.w800)),
          ),
        ]),
      );
}

// ───────────── Reusable widgets ─────────────
class Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsets pad;
  Panel({super.key, required this.child, this.pad = const EdgeInsets.all(22)});
  @override
  Widget build(BuildContext c) => Container(
        padding: pad,
        decoration: BoxDecoration(
          color: surf(c),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: hair(c)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(14), blurRadius: 24, offset: const Offset(0, 8))],
        ),
        child: child,
      );
}

class Lift extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  Lift({super.key, required this.child, this.onTap});
  @override
  State<Lift> createState() => _LiftState();
}

class _LiftState extends State<Lift> {
  bool h = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: (_) => setState(() => h = true),
        onExit: (_) => setState(() => h = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, h ? -5 : 0, 0),
            child: widget.child,
          ),
        ),
      );
}

Widget photo(String url, {BoxFit fit = BoxFit.cover}) => Image.network(url,
    fit: fit,
    loadingBuilder: (c, w, p) => p == null ? w : Container(color: slate.withAlpha(30)),
    errorBuilder: (c, e, s) => Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [teal, amber])),
        child: const Icon(Icons.landscape_rounded, color: Colors.white)));

class Grid extends StatelessWidget {
  final List<Widget> kids;
  final double min, gap;
  Grid(this.kids, {super.key, this.min = 280, this.gap = 20});
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (c, b) {
        final cols = ((b.maxWidth + gap) / (min + gap)).floor().clamp(1, 8);
        final w = (b.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(spacing: gap, runSpacing: gap, children: [for (final k in kids) SizedBox(width: w, child: k)]);
      });
}

class Split extends StatelessWidget {
  final Widget a, b;
  Split(this.a, this.b, {super.key});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (c, bc) => bc.maxWidth >= 860
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 3, child: a), const SizedBox(width: 20), Expanded(flex: 2, child: b)])
            : Column(children: [a, const SizedBox(height: 20), b]),
      );
}

class PageWrap extends StatelessWidget {
  final List<Widget> children;
  PageWrap(this.children, {super.key});
  @override
  Widget build(BuildContext c) {
    final narrow = MediaQuery.of(c).size.width < 700;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: ListView(padding: EdgeInsets.all(narrow ? 16 : 32), children: children),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title, sub;
  final Widget? trailing;
  Header(this.title, this.sub, {super.key, this.trailing});
  @override
  Widget build(BuildContext c) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 14,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: serif(c, 34)),
              const SizedBox(height: 6),
              Text(sub, style: const TextStyle(color: slate, fontSize: 15)),
            ]),
            if (trailing != null) trailing!,
          ],
        ),
      );
}

class Section extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  Section(this.title, {super.key, this.action, this.onAction});
  @override
  Widget build(BuildContext c) => Padding(
        padding: const EdgeInsets.only(top: 36, bottom: 16),
        child: Row(children: [
          Expanded(child: Text(title, style: serif(c, 22))),
          if (action != null) TextButton(onPressed: onAction, child: Text(action!)),
        ]),
      );
}

Widget info(BuildContext c, IconData i, String s) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), border: Border.all(color: hair(c)), color: slate.withAlpha(16)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(i, size: 16, color: teal), const SizedBox(width: 8), Text(s, style: const TextStyle(fontSize: 13)),
      ]),
    );

Widget field(String l, TextEditingController c, {int lines = 1}) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(controller: c, maxLines: lines, decoration: InputDecoration(labelText: l)),
    );

Widget sheet(BuildContext c, List<Widget> kids) => Dialog(
      backgroundColor: surf(c),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: kids),
        ),
      ),
    );

void toast(BuildContext c, String s) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(s)));

// ───────────── Charts ─────────────
class Bars extends StatelessWidget {
  final Map<String, num> data;
  final Color color;
  Bars(this.data, this.color, {super.key});
  @override
  Widget build(BuildContext c) {
    final mx = data.values.fold<num>(1, (a, b) => b > a ? b : a);
    return SizedBox(
      height: 190,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        for (final e in data.entries)
          Column(mainAxisSize: MainAxisSize.min, children: [
            Text('${e.value}', style: const TextStyle(fontSize: 12, color: slate)),
            const SizedBox(height: 4),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: e.value / mx),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (c, v, _) => Container(
                  width: 30, height: 120 * v + 4,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(9))),
            ),
            const SizedBox(height: 8),
            Text(e.key, style: const TextStyle(fontSize: 12)),
          ]),
      ]),
    );
  }
}

class HBars extends StatelessWidget {
  final Map<String, int> data;
  final Color color;
  HBars(this.data, this.color, {super.key});
  @override
  Widget build(BuildContext c) {
    final mx = data.values.fold<int>(1, (a, b) => b > a ? b : a);
    return Column(children: [
      for (final e in data.entries)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            SizedBox(width: 96, child: Text(e.key, overflow: TextOverflow.ellipsis)),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: e.value / mx),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (c, v, _) => ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                      value: v, minHeight: 10, backgroundColor: hair(c), valueColor: AlwaysStoppedAnimation(color)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text('${e.value}', style: const TextStyle(color: slate)),
          ]),
        ),
    ]);
  }
}

class LinePainter extends CustomPainter {
  final List<double> v;
  final Color color;
  LinePainter(this.v, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    if (v.length < 2) return;
    final mx = v.reduce((a, b) => a > b ? a : b);
    final pts = [
      for (var i = 0; i < v.length; i++)
        Offset(size.width * i / (v.length - 1), size.height - (v[i] / mx) * (size.height - 14) - 7)
    ];
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [color.withAlpha(90), color.withAlpha(0)])
              .createShader(Offset.zero & size));
    canvas.drawPath(
        path, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 3..strokeJoin = StrokeJoin.round);
    for (final p in pts) {
      canvas.drawCircle(p, 4.5, Paint()..color = Colors.white);
      canvas.drawCircle(p, 4.5, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.5);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter o) => true;
}

// ───────────── Trip UI ─────────────
class TripCard extends StatelessWidget {
  final Trip t;
  TripCard(this.t, {super.key});
  @override
  Widget build(BuildContext c) => Lift(
        onTap: () => showTripDetail(c, t),
        child: Panel(
          pad: EdgeInsets.zero,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: Stack(children: [
                AspectRatio(aspectRatio: 16 / 10, child: SizedBox.expand(child: photo(t.cover))),
                Positioned(
                  left: 12, top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black.withAlpha(120), borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.photo_camera_outlined, size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text('${t.photos}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.destination, style: serif(c, 21)),
                const SizedBox(height: 4),
                Text('${t.country}  ·  ${range(t)}', style: const TextStyle(color: slate, fontSize: 13)),
                const SizedBox(height: 10),
                Text(t.desc, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(height: 1.45)),
              ]),
            ),
          ]),
        ),
      );
}

void showTripDetail(BuildContext c, Trip t) {
  showDialog(
    context: c,
    builder: (d) => Dialog(
      backgroundColor: surf(c),
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            AspectRatio(aspectRatio: 16 / 9, child: SizedBox.expand(child: photo(t.cover))),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.name, style: serif(c, 28)),
                const SizedBox(height: 6),
                Text('${t.destination}, ${t.country}', style: const TextStyle(color: slate, fontSize: 15)),
                const SizedBox(height: 16),
                Wrap(spacing: 10, runSpacing: 10, children: [
                  info(c, Icons.calendar_today_outlined, range(t)),
                  info(c, Icons.schedule_rounded, '${t.end.difference(t.start).inDays + 1} days'),
                  info(c, Icons.photo_camera_outlined, '${t.photos} photos'),
                ]),
                if (t.companions.trim().isNotEmpty) ...[
                  const SizedBox(height: 18),
                  const Text('Travel companions', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, children: [
                    for (final p in t.companions.split(','))
                      if (p.trim().isNotEmpty)
                        Chip(avatar: CircleAvatar(child: Text(p.trim()[0])), label: Text(p.trim())),
                  ]),
                ],
                const SizedBox(height: 16),
                Text(t.desc, style: const TextStyle(height: 1.6)),
                const SizedBox(height: 24),
                Wrap(spacing: 10, runSpacing: 10, alignment: WrapAlignment.end, children: [
                  TextButton.icon(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    label: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                    onPressed: () {
                      app.deleteTrip(t.id);
                      Navigator.pop(d);
                    },
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(d);
                        showTripForm(c, t);
                      },
                      child: const Text('Edit')),
                  FilledButton(onPressed: () => Navigator.pop(d), child: const Text('Close')),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    ),
  );
}

void showTripForm(BuildContext c, [Trip? t]) =>
    showDialog(context: c, builder: (_) => TripForm(trip: t));

class TripForm extends StatefulWidget {
  final Trip? trip;
  TripForm({super.key, this.trip});
  @override
  State<TripForm> createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  late TextEditingController n, d, co, cp, ds;
  late DateTime s, e;
  late String cover;
  @override
  void initState() {
    super.initState();
    final t = widget.trip;
    n = TextEditingController(text: t?.name);
    d = TextEditingController(text: t?.destination);
    co = TextEditingController(text: t?.country);
    cp = TextEditingController(text: t?.companions);
    ds = TextEditingController(text: t?.desc);
    s = t?.start ?? DateTime.now();
    e = t?.end ?? DateTime.now().add(const Duration(days: 5));
    cover = t?.cover ?? covers[0];
  }

  Future<void> pick(bool isStart) async {
    final r = await showDatePicker(
        context: context, initialDate: isStart ? s : e, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (r == null) return;
    setState(() {
      if (isStart) {
        s = r;
        if (e.isBefore(s)) e = s;
      } else {
        e = r.isBefore(s) ? s : r;
      }
    });
  }

  void save() {
    if (n.text.trim().isEmpty || d.text.trim().isEmpty) {
      toast(context, 'Please add a trip name and destination');
      return;
    }
    app.saveTrip(Trip(
      id: widget.trip?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      name: n.text.trim(), destination: d.text.trim(), country: co.text.trim(),
      cover: cover, desc: ds.text.trim(), companions: cp.text.trim(),
      start: s, end: e, photos: widget.trip?.photos ?? 0,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext c) => sheet(c, [
        Text(widget.trip == null ? 'New trip' : 'Edit trip', style: serif(c, 26)),
        const SizedBox(height: 20),
        field('Trip name', n),
        field('Destination', d),
        field('Country', co),
        field('Travel companions (comma separated)', cp),
        field('Description', ds, lines: 3),
        Row(children: [
          Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.flight_takeoff, size: 18), label: Text(fmt(s)), onPressed: () => pick(true))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.flight_land, size: 18), label: Text(fmt(e)), onPressed: () => pick(false))),
        ]),
        const SizedBox(height: 18),
        const Text('Cover photograph', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        SizedBox(
          height: 64,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            for (final u in covers)
              GestureDetector(
                onTap: () => setState(() => cover = u),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 90,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cover == u ? teal : Colors.transparent, width: 3)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(11), child: photo(u)),
                ),
              ),
          ]),
        ),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          const SizedBox(width: 8),
          FilledButton(onPressed: save, child: const Text('Save trip')),
        ]),
      ]);
}

// ───────────── Journal / Place forms ─────────────
void showEntryForm(BuildContext c) => showDialog(context: c, builder: (_) => EntryForm());

class EntryForm extends StatefulWidget {
  EntryForm({super.key});
  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final t = TextEditingController(), x = TextEditingController();
  String? trip = app.trips.isEmpty ? null : app.trips.first.name;
  @override
  Widget build(BuildContext c) => sheet(c, [
        Text('New journal entry', style: serif(c, 26)),
        const SizedBox(height: 20),
        field('Title', t),
        field('What happened today?', x, lines: 5),
        if (app.trips.isNotEmpty)
          DropdownButtonFormField<String>(
            value: trip,
            decoration: const InputDecoration(labelText: 'Trip'),
            items: [for (final tr in app.trips) DropdownMenuItem(value: tr.name, child: Text(tr.name))],
            onChanged: (v) => setState(() => trip = v),
          ),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () {
              if (t.text.trim().isEmpty) return toast(c, 'Please add a title');
              final m = app.trips.where((e) => e.name == trip);
              app.addEntry(Entry(t.text.trim(), x.text.trim(), m.isEmpty ? covers[4] : m.first.cover,
                  trip ?? 'Untitled trip', DateTime.now()));
              Navigator.pop(c);
            },
            child: const Text('Save entry'),
          ),
        ]),
      ]);
}

void showPlaceForm(BuildContext c) {
  final city = TextEditingController(), country = TextEditingController();
  showDialog(
    context: c,
    builder: (d) => sheet(d, [
      Text('Add destination', style: serif(d, 26)),
      const SizedBox(height: 20),
      field('City', city),
      field('Country', country),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancel')),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () {
            if (city.text.trim().isEmpty) return;
            app.addPlace(Place(city.text.trim(), country.text.trim(), covers[app.places.length % covers.length], false));
            Navigator.pop(d);
          },
          child: const Text('Add'),
        ),
      ]),
    ]),
  );
}

// ───────────── Dashboard ─────────────
class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  @override
  Widget build(BuildContext c) {
    final now = DateTime.now();
    final hello = now.hour < 12 ? 'Good morning' : now.hour < 18 ? 'Good afternoon' : 'Good evening';
    final recent = ([...app.trips]..sort((a, b) => b.start.compareTo(a.start))).take(3).toList();
    final byYear = <String, num>{};
    final byCountry = <String, int>{};
    for (final t in app.trips) {
      byYear['${t.start.year}'] = (byYear['${t.start.year}'] ?? 0) + 1;
      byCountry[t.country] = (byCountry[t.country] ?? 0) + 1;
    }
    final years = Map.fromEntries(byYear.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    final top = Map.fromEntries((byCountry.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).take(5));
    final chrono = [...app.trips]..sort((a, b) => a.start.compareTo(b.start));
    var run = 0.0;
    final cumulative = [for (final t in chrono) run += t.photos];
    final events = <(DateTime, String, Color)>[
      for (final t in app.trips) (t.start, 'Started ${t.name}', teal),
      for (final e in app.entries) (e.date, 'Wrote “${e.title}”', amber),
    ]..sort((a, b) => b.$1.compareTo(a.$1));

    return PageWrap([
      Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, runSpacing: 14, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$hello, ${app.name}', style: serif(c, 36)),
          const SizedBox(height: 8),
          const Text('The world is a book — every trip is a new chapter.', style: TextStyle(color: slate, fontSize: 16)),
        ]),
        info(c, Icons.today_outlined, '${_wd[now.weekday - 1]}, ${fmt(now)}'),
      ]),
      const SizedBox(height: 28),
      Grid([
        StatCard(Icons.luggage_outlined, 'Total trips', app.trips.length, teal),
        StatCard(Icons.public_rounded, 'Countries visited', app.countries.length, amber),
        StatCard(Icons.location_city_rounded, 'Cities explored', app.cities.length, const Color(0xFF6366F1)),
        StatCard(Icons.photo_camera_outlined, 'Photographs', app.totalPhotos, const Color(0xFFEC4899)),
      ], min: 220),
      Section('Quick actions'),
      Wrap(spacing: 12, runSpacing: 12, children: [
        FilledButton.icon(icon: const Icon(Icons.add_rounded), label: const Text('New trip'), onPressed: () => showTripForm(c)),
        OutlinedButton.icon(icon: const Icon(Icons.edit_note_rounded), label: const Text('Add journal entry'), onPressed: () => showEntryForm(c)),
        OutlinedButton.icon(
            icon: const Icon(Icons.upload_rounded),
            label: const Text('Upload photographs'),
            onPressed: () {
              app.addPhoto();
              toast(c, 'Photo added to your gallery');
            }),
        OutlinedButton.icon(icon: const Icon(Icons.add_location_alt_outlined), label: const Text('Add destination'), onPressed: () => showPlaceForm(c)),
      ]),
      Section('Recent trips', action: 'View all', onAction: () => app.go(1)),
      Grid([for (final t in recent) TripCard(t)]),
      Section('Travel memories & activity'),
      Split(
        Panel(
          child: Column(children: [
            for (final e in app.entries.take(3))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(borderRadius: BorderRadius.circular(14), child: SizedBox(width: 84, height: 84, child: photo(e.cover))),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(e.title, style: serif(c, 18)),
                      const SizedBox(height: 4),
                      Text('${e.trip} · ${fmt(e.date)}', style: const TextStyle(color: slate, fontSize: 12)),
                      const SizedBox(height: 6),
                      Text(e.text, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(height: 1.4)),
                    ]),
                  ),
                ]),
              ),
          ]),
        ),
        Panel(
          child: Column(children: [
            for (final ev in events.take(6))
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: ev.$3, shape: BoxShape.circle)),
                  Container(width: 2, height: 36, color: hair(c)),
                ]),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(ev.$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(fmt(ev.$1), style: const TextStyle(color: slate, fontSize: 12)),
                  ]),
                ),
              ]),
          ]),
        ),
      ),
      Section('Travel statistics'),
      Grid([
        Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Trips per year', style: serif(c, 18)), const SizedBox(height: 18), Bars(years, teal)])),
        Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Most visited countries', style: serif(c, 18)), const SizedBox(height: 14), HBars(top, amber)])),
        Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Travel activity over time', style: serif(c, 18)),
          const SizedBox(height: 4),
          const Text('Cumulative photographs', style: TextStyle(color: slate, fontSize: 12)),
          const SizedBox(height: 14),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOut,
            builder: (c, v, ch) => ClipRect(child: Align(alignment: Alignment.centerLeft, widthFactor: v, child: ch)),
            child: SizedBox(width: double.infinity, height: 150, child: CustomPaint(painter: LinePainter(cumulative, teal))),
          ),
        ])),
      ], min: 340),
      const SizedBox(height: 40),
    ]);
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;
  StatCard(this.icon, this.label, this.value, this.color, {super.key});
  @override
  Widget build(BuildContext c) => Lift(
        child: Panel(
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withAlpha(35), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: value.toDouble()),
                  duration: const Duration(milliseconds: 900),
                  builder: (c, v, _) => Text('${v.round()}', style: serif(c, 30)),
                ),
                Text(label, style: const TextStyle(color: slate), overflow: TextOverflow.ellipsis),
              ]),
            ),
          ]),
        ),
      );
}

// ───────────── My Trips ─────────────
class TripsPage extends StatefulWidget {
  TripsPage({super.key});
  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  final q = TextEditingController();
  String year = 'All', dest = 'All';
  bool newest = true;

  Widget drop(BuildContext c, String v, String all, List<String> items, ValueChanged<String> on) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: surf(c), borderRadius: BorderRadius.circular(14), border: Border.all(color: hair(c))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: v,
            borderRadius: BorderRadius.circular(14),
            items: [for (final i in items) DropdownMenuItem(value: i, child: Text(i == 'All' ? all : i))],
            onChanged: (x) => on(x!),
          ),
        ),
      );

  @override
  Widget build(BuildContext c) {
    if (q.text != app.query) q.text = app.query;
    final years = ['All', ...{for (final t in app.trips) '${t.start.year}'}.toList()..sort((a, b) => b.compareTo(a))];
    final dests = ['All', ...{for (final t in app.trips) t.destination}.toList()..sort()];
    if (!years.contains(year)) year = 'All';
    if (!dests.contains(dest)) dest = 'All';
    final s = app.query.toLowerCase();
    final list = app.trips.where((t) {
      final hit = s.isEmpty || '${t.name} ${t.destination} ${t.country}'.toLowerCase().contains(s);
      return hit && (year == 'All' || '${t.start.year}' == year) && (dest == 'All' || t.destination == dest);
    }).toList()
      ..sort((a, b) => newest ? b.start.compareTo(a.start) : a.start.compareTo(b.start));

    return PageWrap([
      Header('My Trips', '${app.trips.length} journeys and counting',
          trailing: FilledButton.icon(icon: const Icon(Icons.add_rounded), label: const Text('New trip'), onPressed: () => showTripForm(c))),
      Wrap(spacing: 12, runSpacing: 12, crossAxisAlignment: WrapCrossAlignment.center, children: [
        SizedBox(
          width: 280,
          child: TextField(
            controller: q,
            onChanged: (v) => setState(() => app.query = v),
            decoration: InputDecoration(
              hintText: 'Search trips…', prefixIcon: const Icon(Icons.search_rounded), isDense: true,
              filled: true, fillColor: surf(c),
            ),
          ),
        ),
        drop(c, year, 'All years', years, (v) => setState(() => year = v)),
        drop(c, dest, 'All destinations', dests, (v) => setState(() => dest = v)),
        OutlinedButton.icon(
          icon: Icon(newest ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded, size: 18),
          label: Text(newest ? 'Newest first' : 'Oldest first'),
          onPressed: () => setState(() => newest = !newest),
        ),
      ]),
      const SizedBox(height: 24),
      if (list.isEmpty)
        Panel(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(children: [
                const Icon(Icons.luggage_outlined, size: 44, color: slate),
                const SizedBox(height: 12),
                Text('No trips found', style: serif(c, 20)),
                const SizedBox(height: 6),
                const Text('Try a different search or create a new trip.', style: TextStyle(color: slate)),
              ]),
            ),
          ),
        )
      else
        Grid([for (final t in list) TripCard(t)]),
    ]);
  }
}

// ───────────── Journal ─────────────
class JournalPage extends StatelessWidget {
  JournalPage({super.key});
  @override
  Widget build(BuildContext c) {
    final list = [...app.entries]..sort((a, b) => b.date.compareTo(a.date));
    return PageWrap([
      Header('Travel Journal', 'Words and moments worth keeping',
          trailing: FilledButton.icon(icon: const Icon(Icons.edit_rounded), label: const Text('New entry'), onPressed: () => showEntryForm(c))),
      Grid([
        for (final e in list)
          Lift(
            child: Panel(
              pad: EdgeInsets.zero,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  child: AspectRatio(aspectRatio: 16 / 9, child: SizedBox.expand(child: photo(e.cover))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 12, 12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.title, style: serif(c, 21)),
                    const SizedBox(height: 4),
                    Text('${e.trip} · ${fmt(e.date)}', style: const TextStyle(color: slate, fontSize: 12)),
                    const SizedBox(height: 10),
                    Text(e.text, maxLines: 4, overflow: TextOverflow.ellipsis, style: const TextStyle(height: 1.55)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          tooltip: 'Delete', icon: const Icon(Icons.delete_outline, size: 20, color: slate),
                          onPressed: () => app.deleteEntry(e)),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
      ], min: 340),
    ]);
  }
}

// ───────────── Explore ─────────────
const ideas = [
  ('Santorini', 'Greece', 4, 'Whitewashed cliffs and caldera sunsets.'),
  ('Banff', 'Canada', 8, 'Turquoise lakes under towering peaks.'),
  ('Reykjavík', 'Iceland', 7, 'Volcanic landscapes and midnight sun.'),
  ('Bali', 'Indonesia', 9, 'Rice terraces, temples and surf.'),
  ('Lisbon', 'Portugal', 2, 'Tiled hills and golden trams.'),
  ('Queenstown', 'New Zealand', 3, 'Adventure capital beside a glacial lake.'),
];

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  @override
  Widget build(BuildContext c) => PageWrap([
        Header('Explore', 'Handpicked places for your next chapter'),
        Grid([
          for (final i in ideas)
            Lift(
              child: Panel(
                pad: EdgeInsets.zero,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                    child: AspectRatio(aspectRatio: 4 / 3, child: SizedBox.expand(child: photo(covers[i.$3]))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(i.$1, style: serif(c, 21)),
                      Text(i.$2, style: const TextStyle(color: slate)),
                      const SizedBox(height: 8),
                      Text(i.$4, style: const TextStyle(height: 1.45)),
                      const SizedBox(height: 14),
                      Builder(builder: (c) {
                        final saved = app.places.any((p) => p.city == i.$1);
                        return FilledButton.tonal(
                          onPressed: saved ? null : () => app.addPlace(Place(i.$1, i.$2, covers[i.$3], false)),
                          child: Text(saved ? 'In your wishlist' : 'Add to wishlist'),
                        );
                      }),
                    ]),
                  ),
                ]),
              ),
            ),
        ], min: 300),
      ]);
}

// ───────────── Gallery ─────────────
class GalleryPage extends StatelessWidget {
  GalleryPage({super.key});
  @override
  Widget build(BuildContext c) => PageWrap([
        Header('Photo Gallery', '${app.gallery.length} photographs',
            trailing: FilledButton.icon(
                icon: const Icon(Icons.upload_rounded),
                label: const Text('Upload photos'),
                onPressed: () {
                  app.addPhoto();
                  toast(c, 'Photo added');
                })),
        Grid([
          for (final u in app.gallery)
            Lift(
              onTap: () => showDialog(
                context: c,
                builder: (_) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InteractiveViewer(child: photo(u, fit: BoxFit.contain))),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(aspectRatio: 1, child: SizedBox.expand(child: photo(u))),
              ),
            ),
        ], min: 220, gap: 14),
      ]);
}

// ───────────── Destinations ─────────────
class DestinationsPage extends StatelessWidget {
  DestinationsPage({super.key});
  @override
  Widget build(BuildContext c) {
    final visited = app.places.where((p) => p.visited).length;
    return PageWrap([
      Header('Destinations', '$visited visited · ${app.places.length - visited} on your wishlist',
          trailing: FilledButton.icon(icon: const Icon(Icons.add_location_alt_outlined), label: const Text('Add destination'), onPressed: () => showPlaceForm(c))),
      Grid([
        for (final p in app.places)
          Lift(
            child: Panel(
              pad: EdgeInsets.zero,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  child: AspectRatio(aspectRatio: 16 / 9, child: SizedBox.expand(child: photo(p.image))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 8, 14),
                  child: Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(p.city, style: serif(c, 19)),
                        Text(p.country, style: const TextStyle(color: slate, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(p.visited ? 'Visited' : 'Wishlist',
                            style: TextStyle(color: p.visited ? teal : amber, fontWeight: FontWeight.w700, fontSize: 12)),
                      ]),
                    ),
                    Switch(value: p.visited, activeColor: teal, onChanged: (_) => app.togglePlace(p)),
                    IconButton(icon: const Icon(Icons.close_rounded, size: 18, color: slate), onPressed: () => app.removePlace(p)),
                  ]),
                ),
              ]),
            ),
          ),
      ], min: 260),
    ]);
  }
}

// ───────────── Settings ─────────────
class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final name = TextEditingController(text: app.name);
  @override
  Widget build(BuildContext c) => PageWrap([
        Header('Settings', 'Make Wanderly yours'),
        Panel(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Profile', style: serif(c, 20)),
            const SizedBox(height: 16),
            SizedBox(
              width: 420,
              child: TextField(controller: name, onChanged: app.setName, decoration: const InputDecoration(labelText: 'Display name')),
            ),
            const SizedBox(height: 24),
            Text('Appearance', style: serif(c, 20)),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Dark mode'),
              subtitle: const Text('Switch between light and dark themes'),
              value: app.dark,
              activeColor: teal,
              onChanged: app.setDark,
            ),
            const SizedBox(height: 16),
            const Text('Wanderly · v1.0', style: TextStyle(color: slate)),
          ]),
        ),
      ]);
}
