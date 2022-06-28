import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localisation_sample/languages/language_constants.dart';
import 'package:localisation_sample/languages/language.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomeWidget(),
      },
      locale: _locale,
    );
  }
}

class MyHomeWidget extends StatelessWidget {
  const MyHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translation(context).title),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              //настройки языка
              child: DropdownButton<Language>(
                icon: const Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    MyApp.setLocale(context, _locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(e.flag),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              DetailCard(
                name: 'winnie',
                image:
                    'https://upload.wikimedia.org/wikipedia/ru/3/31/Winniethepooh.jpg',
                date: "2022-05-15",
                honey: 5,
                kind: 'wild',
                price: 20,
              ),
              DetailCard(
                  name: 'eeyore',
                  image:
                      'https://upload.wikimedia.org/wikipedia/ru/thumb/7/70/Eeyore.gif/274px-Eeyore.gif',
                  date: "2022-02-12",
                  honey: 2,
                  kind: 'linden',
                  price: 8),
              DetailCard(
                  name: 'piglet',
                  image:
                      'https://ru.wikifur.com/w/images/thumb/2/20/Piglet_WTP.png/428px-Piglet_WTP.png',
                  date: "2022-11-25",
                  honey: 1,
                  kind: 'flower',
                  price: 4),
              DetailCard(
                  name: 'owl',
                  image:
                      'https://upload.wikimedia.org/wikipedia/ru/4/42/%D0%A1%D0%BE%D0%B2%D0%B0_%28%D0%92%D0%B8%D0%BD%D0%BD%D0%B8-%D0%9F%D1%83%D1%85%29.jpg',
                  date: "2022-09-18",
                  honey: 0,
                  kind: 'kind',
                  price: 0),
            ],
          ),
        ));
  }
}

// карточка персонажа
class DetailCard extends StatelessWidget {
  final String name;
  final String image;
  final String date;
  final int honey;
  final String kind;
  final double price;

  const DetailCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.date,
      required this.honey,
      required this.kind,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.network(image),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(translation(context).name(name),
                    style: const TextStyle(fontSize: 20)),
                Text(translation(context).date(DateTime.parse(date))),
                Text(translation(context).honey(honey) +
                    " - " +
                    translation(context).kind(kind)),
                Text(translation(context).price(price)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
