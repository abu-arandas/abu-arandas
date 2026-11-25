import '../models/content.dart';
import 'brand.dart';
import 'routes.dart';

/// Everything the site says that is more than a label: Arandas Tech's services, the Zirr products, case studies and
/// questions. English
/// here, Arabic in lib/l10n/ar.dart; `node tool/check_arabic.mjs` fails when a text has no Arabic.
class Content {
  // ---------------------------------------------------------------- Home

  static const homeStats = [
    ('2021', 'building Flutter apps for clients'),
    ('4', 'products in our Zirr line for shops'),
    ('2', 'languages in every build, Arabic and English'),
    ('0', 'analyzer issues, the only number CI accepts'),
  ];

  static const services = [
    Feature(Glyph.phone, 'Flutter apps for your business', 'Android, iPhone and web apps on Flutter and Supabase, from the first screen to the store listing.'),
    Feature(
      Glyph.team,
      'White-label Flutter team',
      'We build your clients’ apps under your agency’s name, on your timeline, and stay invisible unless you want us in the room.',
    ),
    Feature(Glyph.store, 'Zirr, our software for shops', 'An online store, a back office, a till and a starter for new apps, made and supported by us.'),
  ];

  // ---------------------------------------------------------------- Services

  /// What the services page offers, to businesses and agencies alike.
  static const flutterServices = [
    Feature(Glyph.phone, 'Mobile apps', 'Android and iPhone apps in Flutter, from the first sketch to the App Store and Google Play.'),
    Feature(Glyph.chart, 'Web apps and dashboards', 'Back offices, portals and dashboards in Flutter Web, or React and TypeScript when it fits better.'),
    Feature(Glyph.lock, 'Supabase backends', 'Sign-in, roles, storage and a PostgreSQL database with row-level security and SQL tests.'),
    Feature(Glyph.store, 'Online stores', 'A shop with its back office, payments and stock, starting from Zirr so you pay for less.'),
    Feature(Glyph.chat, 'AI features', 'Assistants, product writers and photo tools added to the app you already have.'),
    Feature(Glyph.test, 'Review and rescue', 'An audit of a Flutter app that is late, slow or hard to change, and the fixes if you want them.'),
  ];

  static const qualityBar = [
    Feature(Glyph.code, 'Zero analyzer issues', 'Strict lint rules on every project, checked by CI on every pull request.'),
    Feature(
      Glyph.test,
      'Checked on every change',
      'CI checks the format, the analyzer, the folder rules, the Arabic and the database rules before anything merges.',
    ),
    Feature(Glyph.shield, 'Secure by default', 'Row-level security on every Supabase table, with SQL tests that fail when a policy leaks.'),
    Feature(Glyph.language, 'Arabic and English', 'Right-to-left layouts and a check that fails the build when a screen misses its Arabic.'),
    Feature(Glyph.brand, 'One-file rebrand', 'Name, colours and font live in one file, so a product ships under your brand in an afternoon.'),
    Feature(Glyph.docs, 'Documented', 'A README, an architecture guide and setup steps a new developer can follow alone.'),
  ];

  // ---------------------------------------------------------------- Agencies

  static const agencyBenefits = [
    Feature(Glyph.brand, 'Your name on everything', 'Builds, store listings, repositories and invoices to your client carry your brand, not ours.'),
    Feature(Glyph.handshake, 'An NDA before the brief', 'We sign your NDA, or ours, before you share anything about your client.'),
    Feature(Glyph.code, 'Code you own', 'You and your client own the code you pay for, with its history, from the first commit.'),
    Feature(Glyph.language, 'Arabic done properly', 'Right-to-left layouts, Arabic fonts and Gulf and Levant copy that reads like it was written in Arabic.'),
    Feature(Glyph.lock, 'Jordan compliance built in', 'JoFotara e-invoicing and the personal data protection law (PDPL), already built into our products.'),
    Feature(Glyph.rocket, 'A head start', 'Every project starts from our starter: sign-in, roles, languages, CI and docs on day one.'),
  ];

  static const agencyIncludes = [
    'Flutter apps for Android, iPhone and the web',
    'Supabase backends with row-level security',
    'Arabic and English, right to left',
    'Weekly builds you can show your client',
    'Source code and store builds under your name',
  ];

  static const agencyOffers = [
    Offer(
      name: 'Project',
      price: 'Fixed price',
      summary: 'A defined app, quoted once, delivered in sprints.',
      points: [
        'A written scope and a fixed quote',
        'A demo on a test link every week',
        'Store builds, source code and docs at handover',
        '30 days of fixes after launch',
      ],
    ),
    Offer(
      name: 'Monthly team',
      price: 'Monthly',
      summary: 'Reserved Flutter days every month for your agency’s pipeline.',
      points: ['Days reserved for you each month', 'Work on any of your clients’ apps', 'A shared board and a weekly call', 'Cancel with a month’s notice'],
    ),
    Offer(
      name: 'Review and rescue',
      price: 'Fixed price',
      summary: 'An audit of a Flutter app that is late, slow or hard to change.',
      points: [
        'A written report in five working days',
        'Lints, tests, security and architecture',
        'A plan, in order, to fix what matters',
        'Optional: we do the fixes',
      ],
    ),
  ];

  static const agencySteps = [
    Feature(Glyph.handshake, 'Brief and NDA', 'Send the brief on WhatsApp or by email. We sign an NDA first if you need one.'),
    Feature(Glyph.docs, 'Estimate in two working days', 'A written scope, the screens, a timeline and a price.'),
    Feature(Glyph.rocket, 'Weekly demos', 'Each week you get a working build on a test link to show your client.'),
    Feature(Glyph.code, 'Handover', 'Source code, store builds, docs and a walkthrough, all under your name.'),
  ];

  static const agencyFaqs = [
    Faq('Who owns the code?', 'You do, for the work you pay for. Our own products, the Zirr line, are licensed to you instead.'),
    Faq('Will you talk to our client?', 'Only if you want us to. By default we talk to you, and your client never sees our name.'),
    Faq('What time zone do you work in?', 'Amman, UTC+3, which overlaps the whole working day in the Gulf and most of it in Europe.'),
    Faq('How do you charge?', 'A fixed price per project, or a monthly fee for reserved days. Ask on WhatsApp for current rates.'),
    Faq('Do you only do Flutter?', 'Flutter and Supabase are what we do best. We also build web apps in React and TypeScript.'),
  ];

  // ---------------------------------------------------------------- The Zirr line

  /// Every product in the Zirr line, for the Zirr page and the home page. Each card opens its own page or live demo.
  static const zirrProducts = [
    CaseStudy(
      slug: 'zirr-retail',
      title: 'Zirr Retail',
      sector: 'Retail ERP',
      summary: 'One app for a clothing store: the online shop, a till in every branch, stock, buying and the books, sold as source code.',
      challenge: '',
      built: [],
      results: [],
      stack: ['Flutter', 'Supabase'],
      image: 'assets/images/zirr-retail.jpg',
      links: [SiteLink('See Zirr Retail', Routes.retail)],
    ),
    CaseStudy(
      slug: 'zirr-pos',
      title: 'Zirr POS',
      sector: 'Point of sale',
      summary: 'A point of sale for shops, cafés and restaurants that saves every sale on the device first, so the till keeps selling when the internet drops.',
      challenge: '',
      built: [],
      results: [],
      stack: ['React', 'TypeScript', 'Electron', 'Supabase'],
      image: 'assets/images/pos-register.png',
      links: [SiteLink('Try it in your browser', 'https://pos-sage-one.vercel.app')],
    ),
    CaseStudy(
      slug: 'zirr-boutique',
      title: 'Zirr Boutique',
      sector: 'Online store',
      summary: 'A fashion storefront with its own admin panel for a brand that sells online: colour and size variants, promotion codes and card checkout.',
      challenge: '',
      built: [],
      results: [],
      stack: ['Flutter Web', 'Supabase', 'Stripe'],
      image: 'assets/images/zirr-boutique.jpg',
      links: [SiteLink('Open the store', 'https://vanguard-demo-sigma.vercel.app')],
    ),
    CaseStudy(
      slug: 'zirr-starter',
      title: 'Zirr Starter',
      sector: 'App template',
      summary: 'The Flutter and Supabase template every Arandas Tech app starts from: sign-in, roles, Arabic and English, CI and docs on day one.',
      challenge: '',
      built: [],
      results: [],
      stack: ['Flutter', 'GetX', 'Supabase'],
      links: [SiteLink('Read how we use it', '${Routes.work}/starter')],
    ),
  ];

  /// Why shops pick Zirr, on the Zirr page.
  static const zirrReasons = [
    Feature(Glyph.language, 'Arabic first, English too', 'Every screen, receipt and email in both languages, right to left where it should be.'),
    Feature(Glyph.receipt, 'Ready for Jordan', 'JoFotara e-invoices, Jordanian dinars and the personal data protection law, built in.'),
    Feature(Glyph.pos, 'Keeps selling offline', 'The till saves each sale on the device first and sends it when the internet is back.'),
    Feature(Glyph.code, 'Code you can own', 'Buy the source code with a licence, or let us set it up and run it for you.'),
    Feature(Glyph.handshake, 'People you can call', 'Made in Amman by Arandas Tech. Ask on WhatsApp and a developer answers.'),
    Feature(Glyph.shield, 'Your data stays yours', 'Row-level security on every table, with SQL tests that fail when a rule leaks.'),
  ];

  // ---------------------------------------------------------------- Zirr Retail

  static const retailFeatures = [
    Feature(Glyph.store, 'Online shop', 'Live stock per size, search and filters, checkout, order tracking, returns and loyalty points.'),
    Feature(Glyph.pos, 'Point of sale', 'A till for every branch: barcodes, split payments, returns and cash-up.'),
    Feature(Glyph.stock, 'Stock across stores', 'One stock ledger for the warehouse and every store, with transfers, counts and purchase orders.'),
    Feature(Glyph.chart, 'Books and dashboards', 'Sales, margins and profit and loss per store, on the same data as the shop.'),
    Feature(Glyph.lock, 'Staff and permissions', '39 staff permissions and two-step sign-in, with each role seeing only its own pages.'),
    Feature(Glyph.receipt, 'JoFotara e-invoices', 'Each sale goes to Jordan’s national e-invoicing system, with its QR code on the receipt.'),
  ];

  static const retailInTheBox = [
    'The full Flutter source code: shop, back office and point of sale',
    'Supabase migrations with row-level security and SQL tests',
    'Strict lint rules with zero analyzer issues, and CI that keeps it that way',
    'A one-file rebrand and setup steps for Vercel and Supabase',
    'English and Arabic, light and dark, on phones, tablets and laptops',
  ];

  static const retailOffers = [
    Offer(
      name: 'Developer licence',
      price: r'$59',
      summary: 'For one business you own and run.',
      points: ['Full Flutter and SQL source code', 'The latest version, with a licence in your name', 'Setup notes and 30 days of email help'],
      link: SiteLink('Buy with PayPal', 'https://www.paypal.com/ncp/payment/PLB-MEBQ9L5YNMRU'),
    ),
    Offer(
      name: 'Agency licence',
      price: r'$199',
      summary: 'For agencies and freelancers who build shops for clients.',
      points: ['Full Flutter and SQL source code', 'Set it up for a client, under your brand, and charge them', '60 days of email help'],
      link: SiteLink('Buy with PayPal', 'https://www.paypal.com/ncp/payment/873ZSGENBAFQA'),
    ),
    Offer(
      name: 'Done for you',
      price: '250 JOD, then 20 JOD a month',
      summary: 'For fashion sellers in Jordan and the Gulf.',
      points: ['Your products, logo and web address', 'Online shop, stock and orders ready to use', 'Hosting, updates and support included'],
    ),
  ];

  static const retailLinks = [
    SiteLink('Visit the live shop', 'https://erp-house.vercel.app'),
    // There is no public back office (its pages need a staff sign-in), so visitors book a walkthrough instead.
    SiteLink(
      'Book a back-office walkthrough',
      'https://wa.me/962791568798?text=Hi%2C%20I%20would%20like%20a%20walkthrough%20of%20the%20Zirr%20Retail%20back%20office.',
    ),
    SiteLink('Compare licences', 'https://erp-house.vercel.app/software#pricing'),
  ];

  // ---------------------------------------------------------------- Case studies

  static const caseStudies = [
    CaseStudy(
      slug: 'retail',
      title: 'One app for a fashion retailer’s shop, tills and books',
      sector: 'Retail',
      summary: 'The online shop, a till in every branch, stock, purchasing and accounts for retailers selling in Jordan and the UAE, in one Flutter project.',
      challenge: 'Fashion retailers with a warehouse and several stores often run the website, the tills and the stock in separate tools, so the website sells sizes a store has already sold.',
      built: [
        'An online shop with live stock per size, checkout in two currencies and order tracking',
        'A point of sale for every branch with barcodes, split payments and cash-up',
        'One stock ledger behind the shop and the stores, with transfers, counts and purchase orders',
        'Dashboards, margins and profit and loss per store',
        'JoFotara e-invoices for every sale',
      ],
      results: [
        'One database for the shop, the stores and the books',
        'Every table behind row-level security, proven by SQL tests',
        'Now sold as source code, as Zirr Retail',
      ],
      stack: ['Flutter', 'Dart', 'GetX', 'Supabase', 'PostgreSQL'],
      image: 'assets/images/zirr-retail.jpg',
      links: [SiteLink('Visit the live shop', 'https://erp-house.vercel.app'), SiteLink('See Zirr Retail', Routes.retail)],
    ),
    CaseStudy(
      slug: 'vanguard',
      title: 'A premium fashion store with its own back office',
      sector: 'E-commerce',
      summary: 'An editorial Flutter Web storefront with colour and size variants, promotion rules and Stripe checkout, and an admin panel for the team.',
      challenge: 'A premium fashion brand needs variants with their own price and stock, promotion codes with rules, and a back office its staff can run without a developer.',
      built: [
        'A storefront with nested colour and size variants, each with its own price and stock',
        'A promotions engine with codes, limits and rules',
        'Stripe checkout',
        'A role-based back office for products, orders and promotions',
        'Every screen on the live Supabase catalogue, with no sample data in the app',
      ],
      results: [
        'A live store anyone can open',
        'Services kept free of the UI framework, so the logic stands on its own',
        'Database rules proven by 163 SQL checks',
      ],
      stack: ['Flutter Web', 'Supabase', 'Stripe'],
      image: 'assets/images/zirr-boutique.jpg',
      links: [SiteLink('Open the store', 'https://vanguard-demo-sigma.vercel.app')],
    ),
    CaseStudy(
      slug: 'starter',
      title: 'The starter every Arandas Tech app begins from',
      sector: 'Internal tooling',
      summary: 'A Flutter and Supabase template with one folder structure, house lint rules, CI, row-level security tests and a one-file rebrand.',
      challenge: 'Every new project spent its first weeks rebuilding sign-in, languages, layout and CI, and each one did it a little differently.',
      built: [
        'One folder structure and the rules a change keeps to',
        'A 12-column responsive grid with no layout dependency',
        'Arabic and English with a check that fails on a missing translation',
        'Row-level security with SQL tests, and real data only',
        'CI for format, analysis, the house rules, SQL tests and a web build',
      ],
      results: [
        'New projects start with working sign-in, languages and CI',
        'This website is built from it',
        'Agencies get the same structure in every app we hand over',
      ],
      stack: ['Flutter', 'GetX', 'Supabase', 'GitHub Actions'],
      links: [SiteLink('Work with us', Routes.services)],
    ),
  ];

  static CaseStudy? caseStudy(String slug) => caseStudies.where((c) => c.slug == slug).firstOrNull;

  // ---------------------------------------------------------------- Testimonials

  /// Clients' words, once they have agreed to be quoted. The section stays hidden while this is empty.
  static const testimonials = <Testimonial>[];

  // ---------------------------------------------------------------- Contact

  static const projectTypes = ['A Flutter app for my business', 'White-label work for an agency', 'A Zirr product', 'Something else'];

  static final contactLinks = [
    SiteLink('WhatsApp', Brand.whatsAppLink()),
    if (Brand.email != null) const SiteLink('Email', 'mailto:${Brand.email}'),
    const SiteLink('Facebook', Brand.facebook),
    const SiteLink('GitHub', Brand.github),
  ];

  // ---------------------------------------------------------------- Policies

  /// When the policies below last changed. Change it with them.
  static const legalUpdated = 'Last updated 25 November 2026';

  /// The terms, privacy and refund pages, linked from every page's footer. Payment providers read them before they
  /// accept a shop, so they stay plain and match what the offers above promise.
  static const legal = [
    LegalDoc(
      route: Routes.terms,
      title: 'Terms of service',
      summary: 'The rules for using this site, buying a Zirr licence and working with us on a project.',
      parts: [
        LegalPart('Who we are', [
          'Arandas Tech (العرندس للتكنولوجيا) is a software business in Amman, Jordan, owned and run by Ehab Arandas. You can reach us on WhatsApp or through the other links at the foot of every page.',
        ]),
        LegalPart('What these terms cover', [
          'These terms apply to this website, to the Zirr licences we sell and to the work we do for clients. When we sign a written quote or contract with you, it comes first wherever it differs from these terms.',
        ]),
        LegalPart('Zirr licences', [
          'A licence lets you use the source code of the product you bought, under the licence file that comes with it (LICENSE.md). Buying a licence means you accept that file.',
          'Our products stay ours: a licence gives you the right to use the code, not its ownership.',
        ]),
        LegalPart('Projects for clients', [
          'Before we start, we agree in writing on what we will build, the price, how it is paid and the timeline.',
          'Once you have paid for a project in full, you own the code we wrote for it. A Zirr product inside it stays under its own licence.',
        ]),
        LegalPart('Prices and payment', [
          'Prices are shown on this site or in your quote, in US dollars or Jordanian dinars. You pay through PayPal or as your quote says, so we never see your card details.',
        ]),
        LegalPart('Our responsibility', [
          'We fix faults in our own work during the help period of your licence or quote. Beyond that, software is provided as it is, and as far as the law allows, our total liability is limited to what you paid us for it.',
        ]),
        LegalPart('Law', ['These terms are governed by the laws of the Hashemite Kingdom of Jordan, and the courts of Amman decide any dispute.']),
        LegalPart('Changes', [
          'We may update these terms. The date at the top shows the latest version, and the version in force when you paid applies to that purchase.',
        ]),
      ],
    ),
    LegalDoc(
      route: Routes.privacy,
      title: 'Privacy policy',
      summary: 'What we learn about you, why, and what you can ask us to do with it.',
      parts: [
        LegalPart('What this site collects', [
          'Nothing that names you. The site has no accounts, no tracking cookies and no analytics. The contact form only writes a WhatsApp message on your own device; nothing reaches us until you send it from WhatsApp.',
          'Like every website, the services that deliver the page (our host Vercel, and Google, which serves part of the page’s engine) see technical details such as your IP address while it loads.',
        ]),
        LegalPart('What you send us', [
          'When you message us on WhatsApp, by email or on Facebook, we receive what you write and what those services show us, such as your name and number.',
          'When you buy through PayPal, we receive your name, your email address and what you bought. PayPal handles the payment, so we never see your card details.',
        ]),
        LegalPart('Why we use it', [
          'To answer you, deliver what you bought, send your invoice, give the help your licence or project includes, and keep the records the law asks for.',
        ]),
        LegalPart('Who we share it with', [
          'We never sell your information. We share only what is needed: with the payment provider you chose, and with the Income and Sales Tax Department, which receives invoices through the national e-invoicing system as Jordanian law requires.',
        ]),
        LegalPart('How long we keep it', [
          'Invoices and payment records for as long as the law requires. Messages and other details until you ask us to delete them, or once we no longer need them.',
        ]),
        LegalPart('Your rights', [
          'You can ask to see the information we hold about you, to correct it or to delete it, as Jordan’s Personal Data Protection Law (No. 24 of 2023) allows. Message us on WhatsApp and we will answer within a few working days.',
        ]),
        LegalPart('Apps we build or run for clients', [
          'When we build or run an app for a client, that client decides how its users’ data is used, and we handle that data only on the client’s instructions.',
        ]),
        LegalPart('Changes', ['We may update this policy. The date at the top shows the latest version.']),
      ],
    ),
    LegalDoc(
      route: Routes.refunds,
      title: 'Refund and cancellation policy',
      summary: 'When you can get your money back, and how to ask.',
      parts: [
        LegalPart('Zirr licences', [
          'A licence gives you the source code straight away, so it cannot be returned. If the code does not install or work as described and we cannot fix it within 14 days of your purchase, we refund you in full.',
          'If you paid twice for the same licence by mistake, we refund the extra payment.',
        ]),
        LegalPart('Zirr set up for you', [
          'The setup fee is refunded in full if you cancel before we start setting up your shop. Once your shop is live, it is not refunded.',
          'You can stop the monthly fee at any time. Your shop stays open until the end of the month you paid for, and that month is not refunded.',
        ]),
        LegalPart('Projects for clients', [
          'Payments follow the stages in your quote. If either side ends a project early, you pay for the work done up to then, and we refund the rest of what you paid in advance.',
        ]),
        LegalPart('How to ask', [
          'Message us on WhatsApp with your name and your order or invoice number. We answer within two working days, and an approved refund goes back the way you paid, usually within 14 days.',
        ]),
      ],
    ),
  ];

  /// Every text above that is shown translated, for the Arabic check.
  static Iterable<String> get translatedText sync* {
    for (final (_, label) in homeStats) yield label;
    for (final f in [...services, ...flutterServices, ...zirrReasons, ...qualityBar, ...agencyBenefits, ...agencySteps, ...retailFeatures]) {
      yield f.title;
      yield f.body;
    }
    for (final o in [...agencyOffers, ...retailOffers]) {
      yield* [o.name, o.price, o.summary, ...o.points];
      if (o.link != null) yield o.link!.label;
    }
    for (final q in agencyFaqs) yield* [q.question, q.answer];
    yield* agencyIncludes;
    yield* retailInTheBox;
    for (final l in [...retailLinks, ...contactLinks]) yield l.label;
    for (final c in [...caseStudies, ...zirrProducts]) {
      yield* [c.title, c.sector, c.summary, ...c.built, ...c.results, for (final l in c.links) l.label];
      if (c.challenge.isNotEmpty) yield c.challenge;
    }
    for (final t in testimonials) yield* [t.quote, t.role];
    yield* projectTypes;
    yield legalUpdated;
    for (final doc in legal) {
      yield* [doc.title, doc.summary];
      for (final part in doc.parts) yield* [part.heading, ...part.paragraphs];
    }
  }
}
