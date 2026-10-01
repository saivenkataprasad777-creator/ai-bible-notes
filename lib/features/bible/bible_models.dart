class BibleLanguage {
  const BibleLanguage({required this.name, required this.nativeName, required this.code});

  final String name;
  final String nativeName;
  final String code;
}

class BibleTranslation {
  const BibleTranslation({required this.name, required this.languageCode, required this.description});

  final String name;
  final String languageCode;
  final String description;
}

class BibleBook {
  const BibleBook({required this.name, required this.testament, required this.chapters});

  final String name;
  final String testament;
  final int chapters;
}

const bibleLanguages = <BibleLanguage>[
  BibleLanguage(name: 'English', nativeName: 'English', code: 'en'),
  BibleLanguage(name: 'Telugu', nativeName: 'తెలుగు', code: 'te'),
  BibleLanguage(name: 'Hindi', nativeName: 'हिन्दी', code: 'hi'),
  BibleLanguage(name: 'Tamil', nativeName: 'தமிழ்', code: 'ta'),
  BibleLanguage(name: 'Kannada', nativeName: 'ಕನ್ನಡ', code: 'kn'),
  BibleLanguage(name: 'Malayalam', nativeName: 'മലയാളം', code: 'ml'),
  BibleLanguage(name: 'Bengali', nativeName: 'বাংলা', code: 'bn'),
  BibleLanguage(name: 'Marathi', nativeName: 'मराठी', code: 'mr'),
  BibleLanguage(name: 'Gujarati', nativeName: 'ગુજરાતી', code: 'gu'),
  BibleLanguage(name: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ', code: 'pa'),
  BibleLanguage(name: 'Spanish', nativeName: 'Español', code: 'es'),
  BibleLanguage(name: 'French', nativeName: 'Français', code: 'fr'),
  BibleLanguage(name: 'German', nativeName: 'Deutsch', code: 'de'),
  BibleLanguage(name: 'Portuguese', nativeName: 'Português', code: 'pt'),
  BibleLanguage(name: 'Arabic', nativeName: 'العربية', code: 'ar'),
];

const bibleTranslations = <BibleTranslation>[
  BibleTranslation(name: 'English — Sample', languageCode: 'en', description: 'Translation provider will be connected in the Bible data layer.'),
  BibleTranslation(name: 'Telugu — Sample', languageCode: 'te', description: 'Translation provider will be connected in the Bible data layer.'),
  BibleTranslation(name: 'Hindi — Sample', languageCode: 'hi', description: 'Translation provider will be connected in the Bible data layer.'),
];

const bibleBooks = <BibleBook>[
  BibleBook(name: 'Genesis', testament: 'Old Testament', chapters: 50),
  BibleBook(name: 'Exodus', testament: 'Old Testament', chapters: 40),
  BibleBook(name: 'Leviticus', testament: 'Old Testament', chapters: 27),
  BibleBook(name: 'Numbers', testament: 'Old Testament', chapters: 36),
  BibleBook(name: 'Deuteronomy', testament: 'Old Testament', chapters: 34),
  BibleBook(name: 'Joshua', testament: 'Old Testament', chapters: 24),
  BibleBook(name: 'Judges', testament: 'Old Testament', chapters: 21),
  BibleBook(name: 'Ruth', testament: 'Old Testament', chapters: 4),
  BibleBook(name: 'Psalms', testament: 'Old Testament', chapters: 150),
  BibleBook(name: 'Proverbs', testament: 'Old Testament', chapters: 31),
  BibleBook(name: 'Isaiah', testament: 'Old Testament', chapters: 66),
  BibleBook(name: 'Matthew', testament: 'New Testament', chapters: 28),
  BibleBook(name: 'Mark', testament: 'New Testament', chapters: 16),
  BibleBook(name: 'Luke', testament: 'New Testament', chapters: 24),
  BibleBook(name: 'John', testament: 'New Testament', chapters: 21),
  BibleBook(name: 'Acts', testament: 'New Testament', chapters: 28),
  BibleBook(name: 'Romans', testament: 'New Testament', chapters: 16),
  BibleBook(name: '1 Corinthians', testament: 'New Testament', chapters: 16),
  BibleBook(name: '2 Corinthians', testament: 'New Testament', chapters: 13),
  BibleBook(name: 'Galatians', testament: 'New Testament', chapters: 6),
  BibleBook(name: 'Ephesians', testament: 'New Testament', chapters: 6),
  BibleBook(name: 'Philippians', testament: 'New Testament', chapters: 4),
  BibleBook(name: 'Colossians', testament: 'New Testament', chapters: 4),
  BibleBook(name: '1 Peter', testament: 'New Testament', chapters: 5),
  BibleBook(name: '1 John', testament: 'New Testament', chapters: 5),
  BibleBook(name: 'Revelation', testament: 'New Testament', chapters: 22),
];
