import '../models/content.dart';
import 'brand.dart';
import 'routes.dart';

/// Everything the site says that is more than a label: services, products, case studies and questions. English
/// here, Arabic in lib/l10n/ar.dart; test/l10n/translations_test.dart fails when a text has no Arabic.
class Content {
  // ---------------------------------------------------------------- Home

  static const homeStats = [
    ('2021', 'building Flutter apps for clients'),
    ('2', 'languages in every build, Arabic and English'),
    ('60%', 'test coverage, the least CI accepts'),
    ('100%', 'of tables behind row-level security'),
  ];

  static const services = [
    Feature(
      Glyph.team,
      'White-label Flutter team',
      'We build your clients’ apps under your agency’s name, on your timeline, and stay invisible unless you want us in the room.',
    ),
    Feature(
      Glyph.store,
      'Marcat for retail',
      'An online shop, a back office and a point of sale in one Flutter app, sold as source code you can brand and resell.',
    ),
    Feature(Glyph.calendar, 'Arandas Clinic', 'Appointments, patient files, WhatsApp reminders and JoFotara e-invoices for small clinics in Jordan.'),
    Feature(Glyph.phone, 'Custom apps', 'Android, iPhone and web apps on Flutter and Supabase, from the first screen to the store listing.'),
  ];

  static const qualityBar = [
    Feature(Glyph.code, 'Zero analyzer issues', 'Strict lint rules on every project, checked by CI on every pull request.'),
    Feature(Glyph.test, 'Tested code', 'Unit, widget and integration tests, with at least 60% line coverage before anything merges.'),
    Feature(Glyph.shield, 'Secure by default', 'Row-level security on every Supabase table, with SQL tests that fail when a policy leaks.'),
    Feature(Glyph.language, 'Arabic and English', 'Right-to-left layouts and a test that fails the build when a screen misses its Arabic.'),
    Feature(Glyph.brand, 'One-file rebrand', 'Name, colours and font live in one file, so a product ships under your brand in an afternoon.'),
    Feature(Glyph.docs, 'Documented', 'A README, an architecture guide and setup steps a new developer can follow alone.'),
  ];

  // ---------------------------------------------------------------- Agencies

  static const agencyBenefits = [
    Feature(Glyph.brand, 'Your name on everything', 'Builds, store listings, repositories and invoices to your client carry your brand, not ours.'),
    Feature(Glyph.handshake, 'An NDA before the brief', 'We sign your NDA, or ours, before you share anything about your client.'),
    Feature(Glyph.code, 'Code you own', 'You and your client own the code you pay for, with its history, from the first commit.'),
    Feature(Glyph.language, 'Arabic done properly', 'Right-to-left layouts, Arabic fonts and Gulf and Levant copy that reads like it was written in Arabic.'),
    Feature(
      Glyph.lock,
      'Jordan compliance built in',
      'JoFotara e-invoicing and the personal data protection law (PDPL), already built and tested in our products.',
    ),
    Feature(Glyph.rocket, 'A head start', 'Every project starts from our tested starter: sign-in, roles, languages, CI and docs on day one.'),
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
    Faq('Who owns the code?', 'You do, for the work you pay for. Our own products (the starter, Marcat and the clinic system) are licensed to you instead.'),
    Faq('Will you talk to our client?', 'Only if you want us to. By default we talk to you, and your client never sees our name.'),
    Faq('What time zone do you work in?', 'Amman, UTC+3, which overlaps the whole working day in the Gulf and most of it in Europe.'),
    Faq('How do you charge?', 'A fixed price per project, or a monthly fee for reserved days. Ask on WhatsApp for current rates.'),
    Faq('Do you only do Flutter?', 'Flutter and Supabase are what we do best. We also build web apps in React and TypeScript.'),
  ];

  // ---------------------------------------------------------------- Marcat

  static const marcatFeatures = [
    Feature(Glyph.store, 'Online shop', 'Live stock per size, search and filters, checkout, order tracking, returns and loyalty points.'),
    Feature(Glyph.pos, 'Point of sale', 'A till for every branch: barcodes, split payments, returns and cash-up.'),
    Feature(Glyph.stock, 'Stock across stores', 'One stock ledger for the warehouse and every store, with transfers, counts and purchase orders.'),
    Feature(Glyph.chart, 'Books and dashboards', 'Sales, margins and profit and loss per store, on the same data as the shop.'),
    Feature(Glyph.lock, 'Staff and permissions', '39 staff permissions and two-step sign-in, with each role seeing only its own pages.'),
    Feature(Glyph.receipt, 'JoFotara e-invoices', 'Each sale goes to Jordan’s national e-invoicing system, with its QR code on the receipt.'),
  ];

  static const marcatInTheBox = [
    'The full Flutter source code: shop, back office and point of sale',
    'Supabase migrations with row-level security and SQL tests',
    'A sample company to start from: five stores, 24 products and 90 days of sales',
    'Tests with 68% line coverage, and CI that keeps it above 60%',
    'A one-file rebrand and setup steps for Vercel and Supabase',
    'English and Arabic, light and dark, on phones, tablets and laptops',
  ];

  static const marcatOffers = [
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

  static const marcatLinks = [
    SiteLink('Visit the demo shop', 'https://erp-house.vercel.app'),
    SiteLink('Try the back office', 'https://erp-house.vercel.app/sandbox/sign-in'),
    SiteLink('Compare licences', 'https://erp-house.vercel.app/software#pricing'),
  ];

  // ---------------------------------------------------------------- Clinic

  static const clinicFeatures = [
    Feature(Glyph.calendar, 'Schedule', 'A day view per doctor, booking in a few taps from free slots, and every status from booked to no-show.'),
    Feature(Glyph.phone, 'Online booking', 'Each clinic gets its own booking page for Instagram and WhatsApp. Patients need no account.'),
    Feature(Glyph.chat, 'WhatsApp reminders', '24 hours and 2 hours before each visit, with Confirm and Cancel buttons that update the schedule.'),
    Feature(Glyph.docs, 'Patient files', 'Contact details, allergies, visits, clinical notes, x-rays and PDFs, payments and balance.'),
    Feature(Glyph.team, 'Roles', 'Owner, doctor and receptionist, each with what they need and no more. Receptionists never see clinical notes.'),
    Feature(
      Glyph.receipt,
      'JoFotara e-invoices',
      'Every payment becomes an e-invoice and every voided payment a credit invoice, with the QR code on the receipt.',
    ),
  ];

  static const clinicPrivacy = [
    'Patient consent and its date recorded on every new file',
    'Each clinic’s data walled off by row-level security in the database',
    'A log of who opened or changed each patient file',
    'No medical details in WhatsApp messages',
    'Files in a private bucket, opened with links that expire in 10 minutes',
  ];

  // ---------------------------------------------------------------- Case studies

  static const caseStudies = [
    CaseStudy(
      slug: 'marcat',
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
        '68% test coverage, with an integration test that walks a sale end to end',
        'Now sold as source code, as Marcat',
      ],
      stack: ['Flutter', 'Dart', 'GetX', 'Supabase', 'PostgreSQL'],
      image: 'assets/images/arandas-erp.jpg',
      links: [SiteLink('Visit the demo shop', 'https://erp-house.vercel.app'), SiteLink('See Marcat', Routes.marcat)],
    ),
    CaseStudy(
      slug: 'clinic',
      title: 'Bookings, files and WhatsApp reminders for clinics in Jordan',
      sector: 'Healthcare',
      summary: 'A Flutter app for small clinics, on Android, iPhone and the web, built Arabic first around Jordan’s privacy and e-invoicing laws.',
      challenge: 'Small clinics lose visits to no-shows, keep patient files on paper, and now have to send every payment to JoFotara and protect health data under the PDPL.',
      built: [
        'A schedule per doctor and a public booking page for each clinic',
        'Reminders on WhatsApp with Confirm and Cancel buttons',
        'Patient files with notes, x-rays and payments, behind three roles',
        'JoFotara e-invoices built as UBL 2.1 and sent by a Supabase Edge Function',
        'Consent records and an audit log of who opened each file',
      ],
      results: [
        '75% test coverage, with SQL tests for booking, overlap, consent and access rules',
        'Clinical notes hidden from receptionists by the database itself',
        'One codebase for three platforms',
      ],
      stack: ['Flutter', 'Supabase', 'Edge Functions', 'WhatsApp Cloud API', 'JoFotara'],
      links: [SiteLink('See Arandas Clinic', Routes.clinic)],
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
        'A demo mode that runs every screen without a backend',
      ],
      results: ['A public demo anyone can open', 'Services kept free of the UI framework, so the logic is tested on its own', '64% test coverage'],
      stack: ['Flutter Web', 'Supabase', 'Stripe'],
      image: 'assets/images/vanguard-store.jpg',
      links: [SiteLink('Open the store demo', 'https://vanguard-demo-sigma.vercel.app')],
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
        'Arabic and English with a test that fails on a missing translation',
        'Row-level security with SQL tests, and a demo mode on sample data',
        'CI for format, analysis, tests, coverage and a web build',
      ],
      results: [
        'New projects start with working, tested sign-in, languages and CI',
        'This website is built from it',
        'Agencies get the same structure in every app we hand over',
      ],
      stack: ['Flutter', 'GetX', 'Supabase', 'GitHub Actions'],
      links: [SiteLink('Work with us', Routes.agencies)],
    ),
  ];

  /// Other products, shown below the case studies.
  static const otherProducts = [
    CaseStudy(
      slug: 'pos',
      title: 'EA POS',
      sector: 'Point of sale',
      summary: 'A point of sale for shops, cafés and restaurants that saves every sale on the device first, so the till keeps selling when the internet drops.',
      challenge: '',
      built: [],
      results: [],
      stack: ['React', 'TypeScript', 'Electron', 'Supabase'],
      image: 'assets/images/pos-register.png',
      links: [SiteLink('Try the demo', 'https://pos-sage-one.vercel.app')],
    ),
  ];

  static CaseStudy? caseStudy(String slug) => caseStudies.where((c) => c.slug == slug).firstOrNull;

  // ---------------------------------------------------------------- Testimonials

  /// Clients' words, once they have agreed to be quoted. The section stays hidden while this is empty.
  static const testimonials = <Testimonial>[];

  // ---------------------------------------------------------------- Contact

  static const projectTypes = ['White-label work for an agency', 'Marcat licence', 'Arandas Clinic', 'A new app', 'Something else'];

  static final contactLinks = [
    SiteLink('WhatsApp', Brand.whatsAppLink()),
    if (Brand.email != null) const SiteLink('Email', 'mailto:${Brand.email}'),
    const SiteLink('Facebook', Brand.facebook),
    const SiteLink('GitHub', Brand.github),
  ];

  /// Every text above that is shown translated, for the Arabic check.
  static Iterable<String> get translatedText sync* {
    for (final (_, label) in homeStats) yield label;
    for (final f in [...services, ...qualityBar, ...agencyBenefits, ...agencySteps, ...marcatFeatures, ...clinicFeatures]) {
      yield f.title;
      yield f.body;
    }
    for (final o in [...agencyOffers, ...marcatOffers]) {
      yield* [o.name, o.price, o.summary, ...o.points];
      if (o.link != null) yield o.link!.label;
    }
    for (final q in agencyFaqs) yield* [q.question, q.answer];
    yield* agencyIncludes;
    yield* marcatInTheBox;
    yield* clinicPrivacy;
    for (final l in [...marcatLinks, ...contactLinks]) yield l.label;
    for (final c in [...caseStudies, ...otherProducts]) {
      yield* [c.title, c.sector, c.summary, ...c.built, ...c.results, for (final l in c.links) l.label];
      if (c.challenge.isNotEmpty) yield c.challenge;
    }
    for (final t in testimonials) yield* [t.quote, t.role];
    yield* projectTypes;
  }
}
