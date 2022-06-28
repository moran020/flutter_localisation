class Language {
  final int id;
  final String flag;
  final String languageCode;

  Language(this.id, this.flag, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "https://www.flagistrany.ru/data/flags/ultra/ru.png", "ru"),
      Language(2, "https://www.flagistrany.ru/data/flags/ultra/gb.png", "en"),
      Language(3, "https://www.flagistrany.ru/data/flags/ultra/it.png", "it"),
    ];
  }
}
