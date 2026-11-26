import '../config/brand.dart';

/// Arabic for every English text the site shows. English text is its own key (`'Work'.tr`), so a missing entry
/// shows English rather than nothing; `node tool/check_arabic.mjs` fails the build when one is missing.
const ar = <String, String>{
  Brand.name: Brand.nameAr,
  Brand.city: 'عمّان، الأردن',
  'العربية': 'English',

  // Header, menu and footer
  'Work': 'أعمالنا',
  'Contact': 'تواصل معنا',
  'Home': 'الرئيسية',
  'Menu': 'القائمة',
  'Talk to us': 'تحدّث معنا',
  'Pages': 'الصفحات',
  'Elsewhere': 'تجدنا أيضاً على',
  'WhatsApp': 'واتساب',
  'Email': 'البريد الإلكتروني',
  'Facebook': 'فيسبوك',
  'GitHub': 'GitHub',
  '© @year @name. Built with Flutter.': '© @year @name. صُنع بـ Flutter.',

  // Blocks
  'Message us on WhatsApp': 'راسلنا على واتساب',
  'Other ways to reach us': 'طرق أخرى للتواصل',
  'Have a project in mind?': 'عندك مشروع؟',
  'Tell us what you are building. We answer on WhatsApp within one working day.': 'أخبرنا بما تبنيه. نردّ على واتساب خلال يوم عمل واحد.',
  'Read the case study': 'اقرأ دراسة الحالة',
  'Ask on WhatsApp': 'اسأل على واتساب',
  'Clients': 'العملاء',
  'What clients say': 'ماذا يقول عملاؤنا',

  // Home
  'See our work': 'شاهد أعمالنا',
  'building Flutter apps for clients': 'نبني تطبيقات Flutter للعملاء منذ',
  'languages in every build, Arabic and English': 'لغتان في كل إصدار، العربية والإنجليزية',
  'analyzer issues, the only number CI accepts': 'مشكلة في التحليل، الرقم الوحيد الذي يقبله CI',
  'What we do': 'ماذا نفعل',
  'Three ways to work with us': 'ثلاث طرق للعمل معنا',
  'Our products': 'منتجاتنا',
  'Our quality bar': 'معايير الجودة لدينا',
  'What every project ships with': 'ما يأتي مع كل مشروع',
  'The same rules hold for our own products and for the apps we build for you.': 'القواعد نفسها تسري على منتجاتنا وعلى التطبيقات التي نبنيها لك.',
  'Case studies': 'دراسات الحالة',
  'Recent work': 'أحدث أعمالنا',
  'All case studies': 'كل دراسات الحالة',

  // Services
  'White-label Flutter team': 'فريق Flutter باسمك',
  'We build your clients’ apps under your agency’s name, on your timeline, and stay invisible unless you want us in the room.':
      'نبني تطبيقات عملائك باسم وكالتك وفي مواعيدك، ونبقى خلف الكواليس إلا إذا أردت حضورنا.',
  'Zirr Retail': 'زِرّ للتجزئة',
  'Android, iPhone and web apps on Flutter and Supabase, from the first screen to the store listing.':
      'تطبيقات أندرويد وآيفون وويب على Flutter وSupabase، من أول شاشة حتى النشر في المتجر.',

  // Quality bar
  'Zero analyzer issues': 'صفر ملاحظات من المحلّل',
  'Strict lint rules on every project, checked by CI on every pull request.': 'قواعد صارمة لجودة الكود في كل مشروع، يفحصها CI مع كل طلب دمج.',
  'Checked on every change': 'مفحوص عند كل تغيير',
  'CI checks the format, the analyzer, the folder rules, the Arabic and the database rules before anything merges.':
      'يفحص CI التنسيق والمحلّل وقواعد المجلدات والعربية وقواعد قاعدة البيانات قبل دمج أي تغيير.',
  'Secure by default': 'آمن من البداية',
  'Row-level security on every Supabase table, with SQL tests that fail when a policy leaks.':
      'أمان على مستوى الصفوف في كل جدول Supabase، مع اختبارات SQL تفشل إذا سرّبت سياسة أي بيانات.',
  'Arabic and English': 'العربية والإنجليزية',
  'Right-to-left layouts and a check that fails the build when a screen misses its Arabic.':
      'تصميم من اليمين إلى اليسار، وفحص يوقف البناء إذا نقصت شاشةً ترجمتُها العربية.',
  'One-file rebrand': 'تغيير العلامة من ملف واحد',
  'Name, colours and font live in one file, so a product ships under your brand in an afternoon.':
      'الاسم والألوان والخط في ملف واحد، فيصدر المنتج باسمك خلال ساعات.',
  'Documented': 'موثّق',
  'A README, an architecture guide and setup steps a new developer can follow alone.': 'ملف README ودليل للبنية وخطوات إعداد يتبعها أي مطوّر جديد وحده.',

  // Agencies
  'For agencies and software houses': 'للوكالات وشركات البرمجيات',
  'A white-label Flutter team, under your name': 'فريق Flutter يعمل باسمك',
  'Send us a brief': 'أرسل لنا الفكرة',
  'What you get': 'ما تحصل عليه',
  'Based in Amman, UTC+3.': 'مقرّنا عمّان، بتوقيت UTC+3.',
  'Your name on everything': 'اسمك على كل شيء',
  'Builds, store listings, repositories and invoices to your client carry your brand, not ours.':
      'الإصدارات وصفحات المتاجر والمستودعات والفواتير لعميلك تحمل علامتك أنت، لا علامتنا.',
  'An NDA before the brief': 'اتفاقية سرية قبل التفاصيل',
  'We sign your NDA, or ours, before you share anything about your client.': 'نوقّع اتفاقية السرية الخاصة بك، أو اتفاقيتنا، قبل أن تشاركنا أي شيء عن عميلك.',
  'Code you own': 'كود تملكه',
  'You and your client own the code you pay for, with its history, from the first commit.':
      'أنت وعميلك تملكان الكود الذي تدفع ثمنه، مع سجلّه كاملاً من أول تعديل.',
  'Arabic done properly': 'عربية كما يجب',
  'Right-to-left layouts, Arabic fonts and Gulf and Levant copy that reads like it was written in Arabic.':
      'تصميم من اليمين إلى اليسار وخطوط عربية ونصوص خليجية وشامية تُقرأ كأنها كُتبت بالعربية أصلاً.',
  'Jordan compliance built in': 'متوافق مع الأنظمة الأردنية',
  'JoFotara e-invoicing and the personal data protection law (PDPL), already built into our products.':
      'الفوترة الإلكترونية جو فوترة وقانون حماية البيانات الشخصية، مبنيّان في منتجاتنا.',
  'A head start': 'بداية متقدّمة',
  'Every project starts from our starter: sign-in, roles, languages, CI and docs on day one.':
      'يبدأ كل مشروع من قالبنا: تسجيل الدخول والصلاحيات واللغات وCI والوثائق من اليوم الأول.',
  'Ways to work': 'طرق العمل',
  'Pick how we work with you': 'اختر طريقة عملنا معك',
  'Prices depend on the scope. Send a brief and you get a written quote within two working days.':
      'السعر يعتمد على نطاق العمل. أرسل الفكرة وتصلك عرض سعر مكتوب خلال يومَي عمل.',
  'Project': 'مشروع',
  'Fixed price': 'سعر ثابت',
  'A defined app, quoted once, delivered in sprints.': 'تطبيق محدّد، بسعر واحد، يُسلَّم على مراحل.',
  'A written scope and a fixed quote': 'نطاق عمل مكتوب وسعر ثابت',
  'A demo on a test link every week': 'عرض على رابط تجريبي كل أسبوع',
  'Store builds, source code and docs at handover': 'إصدارات المتاجر والكود والوثائق عند التسليم',
  '30 days of fixes after launch': '30 يوماً من الإصلاحات بعد الإطلاق',
  'Monthly team': 'فريق شهري',
  'Monthly': 'شهرياً',
  'Reserved Flutter days every month for your agency’s pipeline.': 'أيام Flutter محجوزة لوكالتك كل شهر لمشاريعها القادمة.',
  'Days reserved for you each month': 'أيام محجوزة لك كل شهر',
  'Work on any of your clients’ apps': 'عمل على أي تطبيق من تطبيقات عملائك',
  'A shared board and a weekly call': 'لوحة مهام مشتركة ومكالمة أسبوعية',
  'Cancel with a month’s notice': 'إلغاء بإشعار قبل شهر',
  'Review and rescue': 'مراجعة وإنقاذ',
  'An audit of a Flutter app that is late, slow or hard to change.': 'تدقيق لتطبيق Flutter متأخر أو بطيء أو صعب التعديل.',
  'A written report in five working days': 'تقرير مكتوب خلال خمسة أيام عمل',
  'Lints, tests, security and architecture': 'جودة الكود والاختبارات والأمان والبنية',
  'A plan, in order, to fix what matters': 'خطة مرتّبة لإصلاح ما يهمّ أولاً',
  'Optional: we do the fixes': 'اختياري: نحن ننفّذ الإصلاحات',
  'How it works': 'كيف نعمل',
  'From brief to handover': 'من الفكرة إلى التسليم',
  'Brief and NDA': 'الفكرة واتفاقية السرية',
  'Send the brief on WhatsApp or by email. We sign an NDA first if you need one.': 'أرسل الفكرة على واتساب أو بالبريد. نوقّع اتفاقية سرية أولاً إن احتجت.',
  'Estimate in two working days': 'تقدير خلال يومَي عمل',
  'A written scope, the screens, a timeline and a price.': 'نطاق عمل مكتوب والشاشات وجدول زمني وسعر.',
  'Weekly demos': 'عروض أسبوعية',
  'Each week you get a working build on a test link to show your client.': 'كل أسبوع يصلك إصدار يعمل على رابط تجريبي لتعرضه على عميلك.',
  'Handover': 'التسليم',
  'Source code, store builds, docs and a walkthrough, all under your name.': 'الكود وإصدارات المتاجر والوثائق وجولة شرح، كلها باسمك.',
  'The standard your client gets': 'المستوى الذي يحصل عليه عميلك',
  'Questions': 'أسئلة',
  'Who owns the code?': 'من يملك الكود؟',
  'You do, for the work you pay for. Our own products, the Zirr line, are licensed to you instead.':
      'أنت، في العمل الذي تدفع ثمنه. أما منتجاتنا، مجموعة زِرّ، فتحصل على ترخيص لاستخدامها.',
  'Will you talk to our client?': 'هل تتواصلون مع عميلنا؟',
  'Only if you want us to. By default we talk to you, and your client never sees our name.':
      'فقط إن أردت ذلك. نتواصل معك أنت عادةً، ولا يرى عميلك اسمنا أبداً.',
  'What time zone do you work in?': 'ما هو توقيت عملكم؟',
  'Amman, UTC+3, which overlaps the whole working day in the Gulf and most of it in Europe.':
      'توقيت عمّان UTC+3، ويتقاطع مع يوم العمل كاملاً في الخليج ومعظمه في أوروبا.',
  'How do you charge?': 'كيف تحسبون الأسعار؟',
  'A fixed price per project, or a monthly fee for reserved days. Ask on WhatsApp for current rates.':
      'سعر ثابت لكل مشروع، أو رسوم شهرية لأيام محجوزة. اسألنا على واتساب عن الأسعار الحالية.',
  'Do you only do Flutter?': 'هل تعملون بـ Flutter فقط؟',
  'Flutter and Supabase are what we do best. We also build web apps in React and TypeScript.':
      'أفضل ما نتقنه Flutter وSupabase، ونبني أيضاً تطبيقات ويب بـ React وTypeScript.',
  'Send the brief on WhatsApp. We sign an NDA first if you need one, and quote within two working days.':
      'أرسل الفكرة على واتساب. نوقّع اتفاقية سرية أولاً إن احتجت، ونرسل السعر خلال يومَي عمل.',
  'Flutter apps for Android, iPhone and the web': 'تطبيقات Flutter لأندرويد وآيفون والويب',
  'Supabase backends with row-level security': 'خوادم Supabase بأمان على مستوى الصفوف',
  'Arabic and English, right to left': 'العربية والإنجليزية، من اليمين إلى اليسار',
  'Weekly builds you can show your client': 'إصدارات أسبوعية تعرضها على عميلك',
  'Source code and store builds under your name': 'الكود وإصدارات المتاجر باسمك',

  // Zirr Retail
  'Zirr Retail · for fashion retail': 'زِرّ للتجزئة · لمحلات الأزياء',
  'Your online shop, tills and stock in one Flutter app': 'متجرك الإلكتروني والكاشير والمخزون في تطبيق Flutter واحد',
  'Zirr Retail runs a fashion retailer end to end: the website, a point of sale in every branch, stock across stores, purchasing and the books, on one Supabase database. Buy the source code and ship it under your brand.': 'زِرّ للتجزئة يدير محل الأزياء من أوله إلى آخره: الموقع ونقطة بيع في كل فرع والمخزون بين الفروع والمشتريات والحسابات، على قاعدة بيانات Supabase واحدة. اشترِ الكود المصدري وأطلقه باسمك.',
  'Visit the live shop': 'زُر المتجر المباشر',
  'Book a back-office walkthrough': 'احجز جولة في لوحة الإدارة',
  'Compare licences': 'قارن التراخيص',
  'Features': 'المزايا',
  'One system instead of five': 'نظام واحد بدل خمسة',
  'Online shop': 'متجر إلكتروني',
  'Live stock per size, search and filters, checkout, order tracking, returns and loyalty points.':
      'مخزون مباشر لكل مقاس، وبحث وفلاتر، ودفع، وتتبّع للطلبات، ومرتجعات، ونقاط ولاء.',
  'Point of sale': 'نقطة بيع',
  'A till for every branch: barcodes, split payments, returns and cash-up.': 'كاشير لكل فرع: باركود، ودفع مقسّم، ومرتجعات، وإغلاق الصندوق.',
  'Stock across stores': 'المخزون بين الفروع',
  'One stock ledger for the warehouse and every store, with transfers, counts and purchase orders.':
      'سجلّ مخزون واحد للمستودع وكل فرع، مع التحويلات والجرد وأوامر الشراء.',
  'Books and dashboards': 'الحسابات ولوحات المتابعة',
  'Sales, margins and profit and loss per store, on the same data as the shop.': 'المبيعات والهوامش والأرباح والخسائر لكل فرع، من بيانات المتجر نفسها.',
  'Staff and permissions': 'الموظفون والصلاحيات',
  '39 staff permissions and two-step sign-in, with each role seeing only its own pages.': '39 صلاحية للموظفين وتسجيل دخول بخطوتين، وكل دور يرى صفحاته فقط.',
  'JoFotara e-invoices': 'فواتير جو فوترة',
  'Each sale goes to Jordan’s national e-invoicing system, with its QR code on the receipt.':
      'كل عملية بيع تُرسل إلى نظام الفوترة الوطني في الأردن، مع رمز QR على الإيصال.',
  'In the box': 'ماذا يتضمّن',
  'What you get with the code': 'ما تحصل عليه مع الكود',
  'The full Flutter source code: shop, back office and point of sale': 'كود Flutter المصدري كاملاً: المتجر ولوحة الإدارة ونقطة البيع',
  'Supabase migrations with row-level security and SQL tests': 'ملفات قاعدة بيانات Supabase مع أمان على مستوى الصفوف واختبارات SQL',
  'Strict lint rules with zero analyzer issues, and CI that keeps it that way': 'قواعد تدقيق صارمة بلا أي مشكلة في التحليل، وCI يحافظ على ذلك',
  'A one-file rebrand and setup steps for Vercel and Supabase': 'تغيير العلامة من ملف واحد وخطوات إعداد Vercel وSupabase',
  'English and Arabic, light and dark, on phones, tablets and laptops': 'إنجليزي وعربي، فاتح وداكن، على الجوال والتابلت واللابتوب',
  'of tables behind row-level security, with SQL tests': 'من الجداول محمية بأمان على مستوى الصفوف، مع اختبارات SQL',
  'staff permissions, so each role sees only its own pages': 'صلاحية للموظفين، فيرى كل دور صفحاته فقط',
  'currencies and countries, Jordan and the UAE': 'عملتان ودولتان، الأردن والإمارات',
  'apps in one: the shop, the back office and the till': 'تطبيقات في واحد: المتجر ولوحة الإدارة والكاشير',
  'Pricing': 'الأسعار',
  'Pay once for the code, or let us run it for you': 'ادفع مرة واحدة للكود، أو دعنا نشغّله لك',
  'Licences are paid through PayPal. Within 24 hours you get the latest version by email, with your licence inside.':
      'تُدفع التراخيص عبر PayPal. خلال 24 ساعة يصلك أحدث إصدار بالبريد ومعه ترخيصك.',
  'Developer licence': 'ترخيص المطوّر',
  r'$59': r'59$',
  'For one business you own and run.': 'لمشروع واحد تملكه وتديره.',
  'Full Flutter and SQL source code': 'كود Flutter وSQL المصدري كاملاً',
  'The latest version, with a licence in your name': 'أحدث إصدار، مع ترخيص باسمك',
  'Setup notes and 30 days of email help': 'ملاحظات الإعداد و30 يوماً من الدعم بالبريد',
  'Buy with PayPal': 'اشترِ عبر PayPal',
  'Agency licence': 'ترخيص الوكالة',
  r'$199': r'199$',
  'For agencies and freelancers who build shops for clients.': 'للوكالات والمستقلين الذين يبنون متاجر لعملائهم.',
  'Set it up for a client, under your brand, and charge them': 'جهّزه لعميل باسم علامتك، وتقاضَ أجرك منه',
  '60 days of email help': '60 يوماً من الدعم بالبريد',
  'Done for you': 'نجهّزه لك',
  '250 JOD, then 20 JOD a month': '250 ديناراً، ثم 20 ديناراً شهرياً',
  'For fashion sellers in Jordan and the Gulf.': 'لبائعي الأزياء في الأردن والخليج.',
  'Your products, logo and web address': 'منتجاتك وشعارك وعنوان موقعك',
  'Online shop, stock and orders ready to use': 'متجر إلكتروني ومخزون وطلبات جاهزة للاستخدام',
  'Hosting, updates and support included': 'الاستضافة والتحديثات والدعم مشمولة',
  'Want a walkthrough first?': 'تريد جولة أولاً؟',
  'We show you the shop, the back office and the till on a call, in Arabic or English.':
      'نعرض لك المتجر ولوحة الإدارة والكاشير في مكالمة، بالعربي أو الإنجليزي.',

  // Work and case studies
  'What we have built': 'ما بنيناه',
  'Products we built and run, with the problem each one solves and what it achieved.': 'منتجات بنيناها ونشغّلها، مع المشكلة التي يحلّها كلٌّ منها وما حقّقه.',
  'Also from us': 'من منتجاتنا أيضاً',
  'The challenge': 'التحدّي',
  'Stack': 'التقنيات',
  'What we built': 'ما بنيناه',
  'Results': 'النتائج',
  'More case studies': 'دراسات حالة أخرى',
  'One app for a fashion retailer’s shop, tills and books': 'تطبيق واحد لمتجر محل الأزياء وكاشيراته وحساباته',
  'Retail': 'التجزئة',
  'The online shop, a till in every branch, stock, purchasing and accounts for retailers selling in Jordan and the UAE, in one Flutter project.':
      'المتجر الإلكتروني وكاشير في كل فرع والمخزون والمشتريات والحسابات لمحلات تبيع في الأردن والإمارات، في مشروع Flutter واحد.',
  'Fashion retailers with a warehouse and several stores often run the website, the tills and the stock in separate tools, so the website sells sizes a store has already sold.':
      'كثير من محلات الأزياء التي لديها مستودع وعدة فروع تدير الموقع والكاشير والمخزون بأدوات منفصلة، فيبيع الموقع مقاسات باعها أحد الفروع من قبل.',
  'An online shop with live stock per size, checkout in two currencies and order tracking': 'متجر إلكتروني بمخزون مباشر لكل مقاس، ودفع بعملتين، وتتبّع للطلبات',
  'A point of sale for every branch with barcodes, split payments and cash-up': 'نقطة بيع لكل فرع مع باركود ودفع مقسّم وإغلاق الصندوق',
  'One stock ledger behind the shop and the stores, with transfers, counts and purchase orders':
      'سجلّ مخزون واحد خلف المتجر والفروع، مع التحويلات والجرد وأوامر الشراء',
  'Dashboards, margins and profit and loss per store': 'لوحات متابعة وهوامش وأرباح وخسائر لكل فرع',
  'JoFotara e-invoices for every sale': 'فاتورة جو فوترة لكل عملية بيع',
  'One database for the shop, the stores and the books': 'قاعدة بيانات واحدة للمتجر والفروع والحسابات',
  'Every table behind row-level security, proven by SQL tests': 'كل جدول محمي بأمان على مستوى الصفوف، تثبته اختبارات SQL',
  'Now sold as source code, as Zirr Retail': 'يُباع الآن ككود مصدري باسم زِرّ للتجزئة',
  'See Zirr Retail': 'تعرّف على زِرّ للتجزئة',
  'A premium fashion store with its own back office': 'متجر أزياء راقٍ بلوحة إدارة خاصة',
  'E-commerce': 'التجارة الإلكترونية',
  'An editorial Flutter Web storefront with colour and size variants, promotion rules and Stripe checkout, and an admin panel for the team.':
      'واجهة متجر Flutter Web بطابع مجلّات الأزياء، بألوان ومقاسات وقواعد عروض ودفع عبر Stripe، ولوحة إدارة للفريق.',
  'A premium fashion brand needs variants with their own price and stock, promotion codes with rules, and a back office its staff can run without a developer.':
      'تحتاج علامة الأزياء الراقية إلى خيارات لكلٍّ منها سعرها ومخزونها، ورموز عروض بقواعد، ولوحة إدارة يديرها فريقها دون مطوّر.',
  'A storefront with nested colour and size variants, each with its own price and stock': 'واجهة متجر بخيارات ألوان ومقاسات متداخلة، لكلٍّ منها سعره ومخزونه',
  'A promotions engine with codes, limits and rules': 'محرّك عروض برموز وحدود وقواعد',
  'Stripe checkout': 'الدفع عبر Stripe',
  'A role-based back office for products, orders and promotions': 'لوحة إدارة حسب الأدوار للمنتجات والطلبات والعروض',
  'Every screen on the live Supabase catalogue, with no sample data in the app': 'كل الشاشات على كتالوج Supabase المباشر، بلا بيانات نموذجية في التطبيق',
  'A live store anyone can open': 'متجر مباشر يفتحه أي أحد',
  'Services kept free of the UI framework, so the logic stands on its own': 'خدمات منفصلة عن إطار الواجهة، فيبقى المنطق مستقلاً بذاته',
  'Database rules proven by 163 SQL checks': 'قواعد قاعدة البيانات تثبتها 163 فحصاً بلغة SQL',
  'Open the store': 'افتح المتجر',
  'Internal tooling': 'أدوات داخلية',
  'A Flutter and Supabase template with one folder structure, house lint rules, CI, row-level security tests and a one-file rebrand.':
      'قالب Flutter وSupabase ببنية مجلّدات واحدة وقواعد جودة خاصة بنا وCI واختبارات أمان على مستوى الصفوف وتغيير العلامة من ملف واحد.',
  'Every new project spent its first weeks rebuilding sign-in, languages, layout and CI, and each one did it a little differently.':
      'كان كل مشروع جديد يقضي أسابيعه الأولى في إعادة بناء تسجيل الدخول واللغات والتصميم وCI، وكلٌّ بطريقة مختلفة قليلاً.',
  'One folder structure and the rules a change keeps to': 'بنية مجلّدات واحدة وقواعد يلتزم بها كل تعديل',
  'A 12-column responsive grid with no layout dependency': 'شبكة متجاوبة من 12 عموداً دون مكتبة تصميم خارجية',
  'Arabic and English with a check that fails on a missing translation': 'العربية والإنجليزية مع فحص يفشل عند نقص ترجمة',
  'Row-level security with SQL tests, and real data only': 'أمان على مستوى الصفوف مع اختبارات SQL، وبيانات حقيقية فقط',
  'CI for format, analysis, the house rules, SQL tests and a web build': 'CI للتنسيق والتحليل وقواعد البيت واختبارات SQL وبناء الويب',
  'New projects start with working sign-in, languages and CI': 'تبدأ المشاريع الجديدة بتسجيل دخول ولغات وCI تعمل',
  'This website is built from it': 'هذا الموقع مبني منه',
  'Agencies get the same structure in every app we hand over': 'تحصل الوكالات على البنية نفسها في كل تطبيق نسلّمه',
  'Work with us': 'اعمل معنا',
  'Zirr POS': 'زِرّ كاشير',
  'A point of sale for shops, cafés and restaurants that saves every sale on the device first, so the till keeps selling when the internet drops.':
      'نقطة بيع للمحلات والمقاهي والمطاعم تحفظ كل عملية بيع على الجهاز أولاً، فيستمر الكاشير بالبيع حين ينقطع الإنترنت.',
  'Try it in your browser': 'جرّبه في متصفحك',

  // Contact
  'Tell us about your project': 'أخبرنا عن مشروعك',
  'Fill this in and WhatsApp opens with your message ready to send. We answer within one working day.':
      'املأ النموذج ويفتح واتساب ورسالتك جاهزة للإرسال. نردّ خلال يوم عمل واحد.',
  'Your name': 'اسمك',
  'Company or agency (optional)': 'الشركة أو الوكالة (اختياري)',
  'What is it about?': 'موضوع الرسالة',
  'Your message': 'رسالتك',
  'Send on WhatsApp': 'أرسل على واتساب',
  'Required': 'مطلوب',
  'Company: @company': 'الشركة: @company',
  'About: @type': 'الموضوع: @type',
  'White-label work for an agency': 'عمل باسم وكالة',
  'Something else': 'موضوع آخر',

  // Not found
  'Page not found': 'الصفحة غير موجودة',
  'This page lost a button.': 'ضاع زِرّ من هذه الصفحة.',
  'This page went out for a coffee.': 'هذه الصفحة خرجت تشرب قهوة.',
  'We looked under every cushion. Nothing.': 'بحثنا تحت كل وسادة. لا شيء.',
  'The lost button': 'الزِّرّ الضائع',
  'The link may be old, or the address mistyped.': 'ربما الرابط قديم، أو في العنوان خطأ.',
  'Go to the home page': 'اذهب إلى الرئيسية',

  // The logo's secret (five presses in a row) and the footer's smile.
  'You found the secret. Buttons for everyone.': 'وجدت السرّ. أزرار للجميع.',
  'Made in Amman, one button at a time.': 'صُنع في عمّان، زِرّاً بعد زِرّ.',

  // Arandas Tech and its Zirr line
  Brand.productLine: Brand.productLineAr,
  'Flutter services': 'خدمات Flutter',
  'A software company in Amman. We build Flutter apps and make Zirr, software for shops.':
      'شركة برمجيات في عمّان. نبني تطبيقات Flutter ونصنع زِرّ، برامج للمحلات.',
  'Hi Arandas Tech team, I found you on your website.': 'مرحباً فريق العرندس للتكنولوجيا، وصلت إليكم من موقعكم.',
  'Hi Arandas Tech team, I would like to know more about: @name': 'مرحباً فريق العرندس للتكنولوجيا، أودّ معرفة المزيد عن: @name',
  'Hi Arandas Tech team, I am @name.': 'مرحباً فريق العرندس للتكنولوجيا، أنا @name.',
  'Hi Arandas Tech team, I would like to talk about a Flutter project.': 'مرحباً فريق العرندس للتكنولوجيا، أودّ الحديث عن مشروع Flutter.',
  'Hi Arandas Tech team, I would like a demo of Zirr.': 'مرحباً فريق العرندس للتكنولوجيا، أودّ عرضاً تجريبياً لزِرّ.',
  'Five presses! Zirr’s buttons say thank you.': 'خمس ضغطات! أزرار زِرّ تشكرك.',
  'Arandas Tech · software company in Amman': 'العرندس للتكنولوجيا · شركة برمجيات في عمّان',
  'Software for businesses that work in Arabic and English': 'برمجيات لأعمال تعمل بالعربي والإنجليزي',
  'We build Flutter apps for companies and agencies, and we make Zirr, our own line of software that shops run on: the till, the stock, the online store.':
      'نبني تطبيقات Flutter للشركات والوكالات، ونصنع زِرّ، مجموعتنا من البرامج التي تعمل عليها المحلات: الكاشير والمخزون والمتجر الإلكتروني.',
  'See our Flutter services': 'تعرّف على خدمات Flutter',
  'Meet Zirr': 'تعرّف على زِرّ',
  'products in our Zirr line for shops': 'منتجات في مجموعة زِرّ للمحلات',
  'Zirr, our software for shops': 'زِرّ، برامجنا للمحلات',
  'Four products from one team, built and checked to the same bar as our client work, in Arabic and English.':
      'أربعة منتجات من فريق واحد، مبنية ومفحوصة بمعايير أعمالنا للعملاء نفسها، بالعربي والإنجليزي.',
  'Flutter apps for your business': 'تطبيقات Flutter لعملك',
  'An online store, a back office, a till and a starter for new apps, made and supported by us.':
      'متجر إلكتروني ولوحة إدارة وكاشير وقالب للتطبيقات الجديدة، نصنعها وندعمها بأنفسنا.',

  // Flutter services
  'Mobile apps': 'تطبيقات الجوال',
  'Android and iPhone apps in Flutter, from the first sketch to the App Store and Google Play.':
      'تطبيقات أندرويد وآيفون بـ Flutter، من أول رسمة حتى App Store وGoogle Play.',
  'Web apps and dashboards': 'تطبيقات ويب ولوحات متابعة',
  'Back offices, portals and dashboards in Flutter Web, or React and TypeScript when it fits better.':
      'لوحات إدارة وبوابات ولوحات متابعة بـ Flutter Web، أو React وTypeScript حين يكونان الأنسب.',
  'Supabase backends': 'خوادم Supabase',
  'Sign-in, roles, storage and a PostgreSQL database with row-level security and SQL tests.':
      'تسجيل دخول وصلاحيات وتخزين وقاعدة بيانات PostgreSQL بأمان على مستوى الصفوف واختبارات SQL.',
  'Online stores': 'متاجر إلكترونية',
  'A shop with its back office, payments and stock, starting from Zirr so you pay for less.': 'متجر مع لوحة إدارته والدفع والمخزون، يبدأ من زِرّ فتدفع أقل.',
  'AI features': 'مزايا الذكاء الاصطناعي',
  'Assistants, product writers and photo tools added to the app you already have.': 'مساعدون وكاتب لوصف المنتجات وأدوات للصور، تُضاف إلى تطبيقك الحالي.',
  'An audit of a Flutter app that is late, slow or hard to change, and the fixes if you want them.':
      'تدقيق لتطبيق Flutter متأخر أو بطيء أو صعب التعديل، والإصلاحات إن أردتها.',
  'Flutter apps for businesses and agencies': 'تطبيقات Flutter للشركات والوكالات',
  'Bring us your idea, or your client’s. We design, build, test and ship the app in Arabic and English, and hand it over with its code. For agencies, all of it under your name.':
      'أحضر لنا فكرتك، أو فكرة عميلك. نصمّم التطبيق ونبنيه ونختبره ونطلقه بالعربي والإنجليزي، ونسلّمه مع كوده. وللوكالات، كل ذلك باسمها.',
  'What we build': 'ماذا نبني',
  'From one screen to a whole system': 'من شاشة واحدة إلى نظام كامل',
  'You win the client and own the relationship. We build the app and hand it over as yours.':
      'أنت تكسب العميل وتملك العلاقة معه. ونحن نبني التطبيق ونسلّمه لك باسمك.',
  'What clients and agencies ask us': 'ما يسألنا عنه العملاء والوكالات',
  'Have an app to build?': 'عندك تطبيق تريد بناءه؟',
  'A Flutter app for my business': 'تطبيق Flutter لعملي',
  'A Zirr product': 'منتج من زِرّ',

  // The Zirr line
  'Zirr by Arandas Tech': 'زِرّ من العرندس للتكنولوجيا',
  'Zirr: the software a shop runs on': 'زِرّ: البرامج التي يعمل عليها محلّك',
  'Zirr is our product line for retail: a till for every branch, the stock behind it, the online store, and the starter we build new apps from. Every product is made, run and supported by Arandas Tech in Amman.': 'زِرّ مجموعتنا من البرامج لقطاع التجزئة: كاشير لكل فرع والمخزون خلفه والمتجر الإلكتروني والقالب الذي نبني منه التطبيقات الجديدة. كل منتج تصنعه العرندس للتكنولوجيا في عمّان وتشغّله وتدعمه.',
  'Book a free demo': 'احجز عرضاً مجانياً',
  'The Zirr line': 'مجموعة زِرّ',
  'Four products, one team behind them': 'أربعة منتجات، وفريق واحد خلفها',
  'Why shops pick Zirr': 'لماذا تختار المحلات زِرّ',
  'Made for how shops here work': 'مصمّم على طريقة عمل محلاتنا',
  'Want to see Zirr in your shop?': 'تريد أن ترى زِرّ في محلّك؟',
  'We show you the till, the stock and the online store on a call, in Arabic or English, and set it up for you in Amman.':
      'نعرض لك الكاشير والمخزون والمتجر الإلكتروني في مكالمة، بالعربي أو الإنجليزي، ونجهّزه لك في عمّان.',
  'Press the Zirr button': 'اضغط الزِّرّ',
  'Zirr means “button”: the one on a shirt, and the one on a screen.': 'زِرّ يعني الزِّرّ: زِرّ القميص، وزِرّ الشاشة.',
  'Pressed. It likes that.': 'انضغط. وعجبه الموضوع.',
  'Click. Every sale starts like this.': 'كليك. كل بيعة بتبدأ هيك.',
  'Zirr Boutique': 'زِرّ بوتيك',
  'Zirr Starter': 'قالب زِرّ',
  'Retail ERP': 'نظام إدارة التجزئة',
  'Online store': 'متجر إلكتروني',
  'App template': 'قالب تطبيقات',
  'One app for a clothing store: the online shop, a till in every branch, stock, buying and the books, sold as source code.':
      'تطبيق واحد لمحل الملابس: المتجر الإلكتروني وكاشير في كل فرع والمخزون والمشتريات والحسابات، يُباع ككود مصدري.',
  'A fashion storefront with its own admin panel for a brand that sells online: colour and size variants, promotion codes and card checkout.':
      'واجهة متجر أزياء بلوحة إدارة خاصة لعلامة تبيع أونلاين: خيارات ألوان ومقاسات ورموز عروض ودفع بالبطاقة.',
  'The Flutter and Supabase template every Arandas Tech app starts from: sign-in, roles, Arabic and English, CI and docs on day one.':
      'قالب Flutter وSupabase الذي يبدأ منه كل تطبيق من العرندس للتكنولوجيا: تسجيل الدخول والصلاحيات والعربية والإنجليزية وCI والوثائق من اليوم الأول.',
  'Read how we use it': 'اقرأ كيف نستخدمه',
  'Arabic first, English too': 'العربية أولاً، والإنجليزية أيضاً',
  'Every screen, receipt and email in both languages, right to left where it should be.': 'كل شاشة وإيصال وبريد باللغتين، ومن اليمين إلى اليسار حيث يجب.',
  'Ready for Jordan': 'جاهز للأردن',
  'JoFotara e-invoices, Jordanian dinars and the personal data protection law, built in.':
      'فواتير جو فوترة والدينار الأردني وقانون حماية البيانات الشخصية، مبنية فيه.',
  'Keeps selling offline': 'يبيع حتى دون إنترنت',
  'The till saves each sale on the device first and sends it when the internet is back.':
      'يحفظ الكاشير كل عملية بيع على الجهاز أولاً ويرسلها حين يعود الإنترنت.',
  'Code you can own': 'كود يمكنك امتلاكه',
  'Buy the source code with a licence, or let us set it up and run it for you.': 'اشترِ الكود المصدري بترخيص، أو دعنا نجهّزه ونشغّله لك.',
  'People you can call': 'فريق تستطيع الاتصال به',
  'Made in Amman by Arandas Tech. Ask on WhatsApp and a developer answers.': 'صُنع في عمّان على يد العرندس للتكنولوجيا. اسأل على واتساب ويجيبك مطوّر.',
  'Your data stays yours': 'بياناتك تبقى لك',
  'Row-level security on every table, with SQL tests that fail when a rule leaks.':
      'أمان على مستوى الصفوف في كل جدول، مع اختبارات SQL تفشل إذا سرّبت قاعدة أي بيانات.',
  'The starter every Arandas Tech app begins from': 'القالب الذي يبدأ منه كل تطبيق من العرندس للتكنولوجيا',

  // Policies
  'Policies': 'السياسات',
  'Last updated 26 November 2026': 'آخر تحديث: 26 تشرين الثاني 2026',
  'Trade register number: @number': 'رقم السجل التجاري: @number',
  'Terms of service': 'شروط الخدمة',
  'The rules for using this site, buying a Zirr licence and working with us on a project.':
      'قواعد استخدام هذا الموقع، وشراء ترخيص زِرّ، والعمل معنا على مشروع.',
  'Who we are': 'من نحن',
  'Arandas Tech (العرندس للتكنولوجيا) is a software business in Amman, Jordan, owned and run by Ehab Arandas. You can reach us on WhatsApp or through the other links at the foot of every page.': 'العرندس للتكنولوجيا (Arandas Tech) عمل برمجيات في عمّان، الأردن، يملكه ويديره إيهاب العرندس. يمكنك التواصل معنا على واتساب أو عبر الروابط الأخرى أسفل كل صفحة.',
  'What these terms cover': 'ما تشمله هذه الشروط',
  'These terms apply to this website, to the Zirr licences we sell and to the work we do for clients. When we sign a written quote or contract with you, it comes first wherever it differs from these terms.': 'تسري هذه الشروط على هذا الموقع، وعلى تراخيص زِرّ التي نبيعها، وعلى العمل الذي ننجزه للعملاء. وإذا وقّعنا معك عرض سعر أو عقداً مكتوباً، يُقدَّم على هذه الشروط حيثما اختلف عنها.',
  'Zirr licences': 'تراخيص زِرّ',
  'A licence lets you use the source code of the product you bought, under the licence file that comes with it (LICENSE.md). Buying a licence means you accept that file.':
      'يتيح لك الترخيص استخدام الكود المصدري للمنتج الذي اشتريته، وفق ملف الترخيص المرفق معه (LICENSE.md). وشراؤك للترخيص يعني قبولك لهذا الملف.',
  'Our products stay ours: a licence gives you the right to use the code, not its ownership.':
      'تبقى منتجاتنا ملكاً لنا: يمنحك الترخيص حق استخدام الكود، لا ملكيته.',
  'Projects for clients': 'مشاريع العملاء',
  'Before we start, we agree in writing on what we will build, the price, how it is paid and the timeline.':
      'قبل أن نبدأ، نتفق كتابةً على ما سنبنيه، والسعر، وطريقة الدفع، والجدول الزمني.',
  'Once you have paid for a project in full, you own the code we wrote for it. A Zirr product inside it stays under its own licence.':
      'عندما تدفع ثمن المشروع كاملاً، يصبح الكود الذي كتبناه له ملكاً لك. ويبقى أي منتج من زِرّ داخله خاضعاً لترخيصه الخاص.',
  'Prices and payment': 'الأسعار والدفع',
  'Prices are shown on this site or in your quote, in US dollars or Jordanian dinars. You pay through PayPal or as your quote says, so we never see your card details.': 'تظهر الأسعار على هذا الموقع أو في عرض السعر الخاص بك، بالدولار الأمريكي أو الدينار الأردني. تدفع عبر PayPal أو كما يذكر عرض السعر، فلا نطّلع أبداً على بيانات بطاقتك.',
  'Our responsibility': 'مسؤوليتنا',
  'We fix faults in our own work during the help period of your licence or quote. Beyond that, software is provided as it is, and as far as the law allows, our total liability is limited to what you paid us for it.': 'نصلح الأعطال في عملنا خلال فترة الدعم المذكورة في ترخيصك أو عرض السعر. وبعدها تُقدَّم البرمجيات كما هي، وفي الحدود التي يسمح بها القانون تقتصر مسؤوليتنا الكاملة على ما دفعته لنا مقابلها.',
  'Law': 'القانون',
  'These terms are governed by the laws of the Hashemite Kingdom of Jordan, and the courts of Amman decide any dispute.':
      'تخضع هذه الشروط لقوانين المملكة الأردنية الهاشمية، وتختص محاكم عمّان بالنظر في أي نزاع.',
  'Changes': 'التعديلات',
  'We may update these terms. The date at the top shows the latest version, and the version in force when you paid applies to that purchase.':
      'قد نحدّث هذه الشروط. يبيّن التاريخ في الأعلى أحدث نسخة، وتسري على كل عملية شراء النسخةُ النافذة وقت الدفع.',
  'Privacy policy': 'سياسة الخصوصية',
  'What we learn about you, why, and what you can ask us to do with it.': 'ما نعرفه عنك، ولماذا، وما يمكنك أن تطلبه منّا بشأنه.',
  'What this site collects': 'ما يجمعه هذا الموقع',
  'Nothing that names you. The site has no accounts, no tracking cookies and no analytics. The contact form only writes a WhatsApp message on your own device; nothing reaches us until you send it from WhatsApp.': 'لا شيء يدلّ على هويتك. لا حسابات في الموقع، ولا ملفات تعريف ارتباط للتتبّع، ولا أدوات تحليلات. نموذج التواصل يكتب رسالة واتساب على جهازك فقط، ولا يصلنا شيء حتى ترسلها أنت من واتساب.',
  'Like every website, the services that deliver the page (our host Vercel, and Google, which serves part of the page’s engine) see technical details such as your IP address while it loads.':
      'وكأي موقع، ترى الخدمات التي توصل الصفحة إليك (مستضيفنا Vercel، وGoogle التي تقدّم جزءاً من محرّك الصفحة) تفاصيل تقنية مثل عنوان IP أثناء تحميلها.',
  'What you send us': 'ما ترسله إلينا',
  'When you message us on WhatsApp, by email or on Facebook, we receive what you write and what those services show us, such as your name and number.':
      'عندما تراسلنا على واتساب أو بالبريد الإلكتروني أو على فيسبوك، يصلنا ما تكتبه وما تُظهره لنا تلك الخدمات، مثل اسمك ورقمك.',
  'When you buy through PayPal, we receive your name, your email address and what you bought. PayPal handles the payment, so we never see your card details.':
      'وعندما تشتري عبر PayPal، يصلنا اسمك وبريدك الإلكتروني وما اشتريته. يتولّى PayPal عملية الدفع، فلا نطّلع أبداً على بيانات بطاقتك.',
  'Why we use it': 'لماذا نستخدمها',
  'To answer you, deliver what you bought, send your invoice, give the help your licence or project includes, and keep the records the law asks for.':
      'للرد عليك، وتسليم ما اشتريته، وإرسال فاتورتك، وتقديم الدعم الذي يشمله ترخيصك أو مشروعك، والاحتفاظ بالسجلات التي يطلبها القانون.',
  'Who we share it with': 'مع من نشاركها',
  'We never sell your information. We share only what is needed: with the payment provider you chose, and with the Income and Sales Tax Department, which receives invoices through the national e-invoicing system as Jordanian law requires.': 'لا نبيع معلوماتك أبداً. نشارك فقط ما يلزم: مع مزوّد الدفع الذي اخترته، ومع دائرة ضريبة الدخل والمبيعات التي تستلم الفواتير عبر نظام الفوترة الوطني كما يشترط القانون الأردني.',
  'Error reports from our apps': 'تقارير الأخطاء من تطبيقاتنا',
  'When one of our apps runs into an error, such as Zirr POS on a shop’s till or a shop we run, it can send us an error report through Sentry, a service that stores these reports for us. A report holds the error, where in the app it happened, the page or screen, and the kind of browser or device. It does not say who was signed in, and Sentry does not keep the IP address it came from. We use these reports only to find and fix faults.': 'حين يواجه أحد تطبيقاتنا خطأً، مثل زِرّ كاشير على صندوق أحد المتاجر أو متجر نديره، قد يرسل إلينا تقريراً عن الخطأ عبر Sentry، وهي خدمة تحفظ هذه التقارير لنا. يحمل التقرير الخطأ، ومكان حدوثه في التطبيق، والصفحة أو الشاشة، ونوع المتصفح أو الجهاز. ولا يذكر من كان مسجَّل الدخول، ولا تحتفظ Sentry بعنوان IP الذي جاء منه. نستخدم هذه التقارير فقط لإيجاد الأعطال وإصلاحها.',
  'How long we keep it': 'مدة الاحتفاظ بها',
  'Invoices and payment records for as long as the law requires. Messages and other details until you ask us to delete them, or once we no longer need them.':
      'الفواتير وسجلات الدفع للمدة التي يشترطها القانون. أما الرسائل والتفاصيل الأخرى فحتى تطلب منّا حذفها، أو حين لا نعود بحاجة إليها.',
  'Your rights': 'حقوقك',
  'You can ask to see the information we hold about you, to correct it or to delete it, as Jordan’s Personal Data Protection Law (No. 24 of 2023) allows. Message us on WhatsApp and we will answer within a few working days.': 'يحق لك أن تطلب الاطلاع على المعلومات التي نحتفظ بها عنك، أو تصحيحها، أو حذفها، وفق قانون حماية البيانات الشخصية الأردني رقم 24 لسنة 2023. راسلنا على واتساب وسنرد خلال أيام عمل قليلة.',
  'Apps we build or run for clients': 'التطبيقات التي نبنيها أو نشغّلها للعملاء',
  'When we build or run an app for a client, that client decides how its users’ data is used, and we handle that data only on the client’s instructions.':
      'عندما نبني تطبيقاً لعميل أو نشغّله له، يقرّر العميل كيف تُستخدم بيانات مستخدميه، ولا نتعامل مع تلك البيانات إلا بتعليماته.',
  'We may update this policy. The date at the top shows the latest version.': 'قد نحدّث هذه السياسة. يبيّن التاريخ في الأعلى أحدث نسخة.',
  'Refund and cancellation policy': 'سياسة الاسترداد والإلغاء',
  'When you can get your money back, and how to ask.': 'متى يمكنك استرداد أموالك، وكيف تطلب ذلك.',
  'A licence gives you the source code straight away, so it cannot be returned. If the code does not install or work as described and we cannot fix it within 14 days of your purchase, we refund you in full.': 'يمنحك الترخيص الكود المصدري فوراً، لذا لا يمكن إرجاعه. وإذا لم يُثبَّت الكود أو لم يعمل كما هو موصوف، ولم نتمكن من إصلاحه خلال 14 يوماً من شرائك، نعيد لك المبلغ كاملاً.',
  'If you paid twice for the same licence by mistake, we refund the extra payment.': 'وإذا دفعت ثمن الترخيص نفسه مرتين بالخطأ، نعيد لك الدفعة الزائدة.',
  'Zirr set up for you': 'زِرّ جاهز لك',
  'The setup fee is refunded in full if you cancel before we start setting up your shop. Once your shop is live, it is not refunded.':
      'تُعاد رسوم التجهيز كاملة إذا ألغيت قبل أن نبدأ تجهيز متجرك. أما بعد إطلاق متجرك فلا تُعاد.',
  'You can stop the monthly fee at any time. Your shop stays open until the end of the month you paid for, and that month is not refunded.':
      'يمكنك إيقاف الاشتراك الشهري في أي وقت. يبقى متجرك يعمل حتى نهاية الشهر الذي دفعته، ولا يُعاد مبلغ ذلك الشهر.',
  'Payments follow the stages in your quote. If either side ends a project early, you pay for the work done up to then, and we refund the rest of what you paid in advance.':
      'تتبع الدفعات مراحل عرض السعر. وإذا أنهى أيّ من الطرفين المشروع مبكراً، تدفع مقابل العمل المنجز حتى ذلك الحين، ونعيد لك باقي ما دفعته مقدماً.',
  'How to ask': 'كيف تطلب ذلك',
  'Message us on WhatsApp with your name and your order or invoice number. We answer within two working days, and an approved refund goes back the way you paid, usually within 14 days.':
      'راسلنا على واتساب باسمك ورقم طلبك أو فاتورتك. نرد خلال يومَي عمل، ويُعاد المبلغ الموافَق عليه بالطريقة التي دفعت بها، عادةً خلال 14 يوماً.',
};
