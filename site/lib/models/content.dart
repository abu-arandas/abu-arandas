/// The shapes the site's content comes in. Text is English and is translated where it is shown (`text.tr`), so
/// the content in lib/config/content.dart reads as plain English and lib/l10n/ar.dart holds the Arabic.
library;

/// The pictures a [Feature] can carry, drawn by lib/widgets/glyph_icon.dart.
enum Glyph { team, brand, code, shield, language, test, docs, rocket, store, pos, stock, chart, calendar, chat, receipt, lock, phone, handshake }

/// A titled point with a short paragraph and a picture.
class Feature {
  const Feature(this.glyph, this.title, this.body);

  final Glyph glyph;
  final String title;
  final String body;
}

/// A link a visitor can open, inside the site (starting with `/`) or outside it.
class SiteLink {
  const SiteLink(this.label, this.url);

  final String label;
  final String url;

  bool get isInternal => url.startsWith('/');
}

/// A question with its answer.
class Faq {
  const Faq(this.question, this.answer);

  final String question;
  final String answer;
}

/// One way to work together, with what it costs.
class Offer {
  const Offer({required this.name, required this.price, required this.summary, required this.points, this.link});

  final String name;

  /// Shown as written: a price, or how the price is agreed.
  final String price;
  final String summary;
  final List<String> points;

  /// Where to buy or ask; null for the contact page.
  final SiteLink? link;
}

/// A client's words about the work. The site shows the section only when there is at least one.
class Testimonial {
  const Testimonial({required this.quote, required this.name, required this.role});

  final String quote;
  final String name;
  final String role;
}

/// A project told as a story: what was needed, what was built, and what it achieved.
class CaseStudy {
  const CaseStudy({
    required this.slug,
    required this.title,
    required this.sector,
    required this.summary,
    required this.challenge,
    required this.built,
    required this.results,
    required this.stack,
    this.image,
    this.links = const [],
  });

  /// Its address under /work.
  final String slug;
  final String title;
  final String sector;
  final String summary;
  final String challenge;
  final List<String> built;
  final List<String> results;

  /// Names of tools, shown untranslated.
  final List<String> stack;

  /// An asset under assets/images, or null for none.
  final String? image;
  final List<SiteLink> links;
}
