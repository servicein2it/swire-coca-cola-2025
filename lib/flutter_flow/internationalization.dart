import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'zh_Hans', 'ja'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? zh_HansText = '',
    String? jaText = '',
  }) =>
      [enText, zh_HansText, jaText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // LoginOld
  {
    'l3ypzr50': {
      'en': 'Welcome',
      'ja': 'いらっしゃいませ',
      'zh_Hans': '欢迎',
    },
    'iubkoy6t': {
      'en': 'Let\'s get started by filling out the form below.',
      'ja': 'まずは以下のフォームに記入しましょう。',
      'zh_Hans': '让我们从填写下面的表格开始。',
    },
    'l9owux4y': {
      'en': 'Email',
      'ja': 'メール',
      'zh_Hans': '电子邮件',
    },
    'w4acyb5t': {
      'en': 'Password',
      'ja': 'パスワード',
      'zh_Hans': '密码',
    },
    'hk9l8y8x': {
      'en': 'Sign In',
      'ja': 'サインイン',
      'zh_Hans': '登入',
    },
    'dgntiroe': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // Home
  {
    'wztbc789': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'bj1gcq6k': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    '9ax8zabd': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'b29gj5xo': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    '63busscq': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '4zrykk7x': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'o5v1ia1x': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    '035ooaf5': {
      'en': 'Your QR Code',
      'ja': 'QRコード',
      'zh_Hans': '您的二维码',
    },
    'z45we47a': {
      'en': 'My Activity',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'i6w0lpix': {
      'en': 'Agenda',
      'ja': '議題',
      'zh_Hans': '议程',
    },
    'rj6xvs1d': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'onh5f95r': {
      'en': 'Speaker',
      'ja': 'スピーカー',
      'zh_Hans': '扬声器',
    },
    'n0ccnzuv': {
      'en': 'Event Gallery',
      'ja': 'イベントギャラリー',
      'zh_Hans': '活动图库',
    },
    'lq50f5b4': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '539n9ywt': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'qduicz2a': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // DayilyEventAgenda
  {
    'cosye2dp': {
      'en': 'OVERALL',
      'ja': '全体',
      'zh_Hans': '全面的',
    },
    'j42tnayk': {
      'en': 'OVERALL AGENDA',
      'ja': '全体議題',
      'zh_Hans': '总体议程',
    },
    'm46n8oqt': {
      'en': 'WED 28 MAY',
      'ja': '2月15日（土）',
      'zh_Hans': '2 月 15 日，星期六',
    },
    'hayeae5h': {
      'en': 'Ballroom, Level 2',
      'ja': 'ロイヤル オーキッド ボールルーム、2 階',
      'zh_Hans': '皇家兰花宴会厅，2 楼',
    },
    'gy81g2zg': {
      'en': 'Dress code:  Polo T-shirt',
      'ja': 'ドレスコード: アボットポロTシャツ',
      'zh_Hans': '着装要求：Abbott Polo T 恤',
    },
    'xsirrmk4': {
      'en': '3:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    'uho48hd2': {
      'en': 'Market Visit (optional)',
      'ja': '',
      'zh_Hans': '',
    },
    'en0i0p8e': {
      'en': '7:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    '6l2ixr2z': {
      'en': 'Cocktail Reception \n& Refreshments \n(optional)',
      'ja': '',
      'zh_Hans': '',
    },
    'gssnatjj': {
      'en': 'THU 29 MAY',
      'ja': '2月16日（日）',
      'zh_Hans': '2 月 16 日，周日',
    },
    '0cyc1dn4': {
      'en': 'Dress code:  Business Casual',
      'ja': 'ドレスコード: ビジネスカジュアル',
      'zh_Hans': '着装要求：商务休闲',
    },
    'vnyq60ns': {
      'en': '8:30 AM',
      'ja': '',
      'zh_Hans': '',
    },
    'zv79baij': {
      'en': 'Registration',
      'ja': '',
      'zh_Hans': '',
    },
    '0vj5z75n': {
      'en': '9:00 AM',
      'ja': '',
      'zh_Hans': '',
    },
    'fega8sim': {
      'en': 'Opening',
      'ja': '',
      'zh_Hans': '',
    },
    '36iy2p66': {
      'en': '9:30 AM',
      'ja': '',
      'zh_Hans': '',
    },
    'd4gejg6l': {
      'en': 'Driven to Win Sessions',
      'ja': '',
      'zh_Hans': '',
    },
    '1fyvtgqz': {
      'en': '3:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    'rymf5907': {
      'en': 'Transformation Showcase',
      'ja': '',
      'zh_Hans': '',
    },
    'pzk0srq0': {
      'en': '6:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    'ekuclst8': {
      'en': 'Welcome Dinner',
      'ja': '',
      'zh_Hans': '',
    },
    'thugoloj': {
      'en': 'FRI 30 MAY',
      'ja': '2月17日（月）',
      'zh_Hans': '2 月 17 日星期一',
    },
    'oqpoe3qi': {
      'en': 'Dress code: Comfortable Outdoor Attire',
      'ja': '服装規定: 快適なアウトドアウェア',
      'zh_Hans': '着装要求：舒适的户外服装',
    },
    'bk5tf5o4': {
      'en': '9:00 AM',
      'ja': '',
      'zh_Hans': '',
    },
    '6jrqyvaz': {
      'en': 'Polaris Journey',
      'ja': '',
      'zh_Hans': '',
    },
    '9aa4mwhj': {
      'en': '2:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    'xw144zfa': {
      'en': 'Team Building',
      'ja': '',
      'zh_Hans': '',
    },
    'hm6b373r': {
      'en': '4:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    'ngjq48s5': {
      'en': 'Closing',
      'ja': '',
      'zh_Hans': '',
    },
    'w72llwxo': {
      'en': '2:00 PM',
      'ja': '',
      'zh_Hans': '',
    },
    'mmilymuj': {
      'en': 'Celebration Dinner',
      'ja': '',
      'zh_Hans': '',
    },
    'kwqnlyty': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    '283yz3d6': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'mgrzsu4e': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    '4oxxlgta': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'orycdow0': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'b0lvhosg': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'yulisnou': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    '4jigujk2': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    '8pe1qo0f': {
      'en': 'Agenda',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FAQ
  {
    '1390p1mh': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'n1b2ca6f': {
      'en': 'Registration',
      'ja': '登録',
      'zh_Hans': '登记',
    },
    '2irsoody': {
      'en': 'Dress Code',
      'ja': '服装規定',
      'zh_Hans': '着装要求',
    },
    'bdmrkqfd': {
      'en': 'Airport Map',
      'ja': '空港マップ',
      'zh_Hans': '机场地图',
    },
    '97hu55q6': {
      'en': 'Email Contact',
      'ja': '電子メールによるお問い合わせ',
      'zh_Hans': '电子邮件联系',
    },
    '49fedrri': {
      'en': 'Bangkok Travel Information',
      'ja': '電子メールによるお問い合わせ',
      'zh_Hans': '电子邮件联系',
    },
    'ypreat5y': {
      'en': 'Basic Thai Phases You Must Know!',
      'ja': '電子メールによるお問い合わせ',
      'zh_Hans': '电子邮件联系',
    },
    'gqtp6rd4': {
      'en': 'Safety Tips',
      'ja': '電子メールによるお問い合わせ',
      'zh_Hans': '电子邮件联系',
    },
    'igk5l2ic': {
      'en': 'Emergency Contact',
      'ja': '電子メールによるお問い合わせ',
      'zh_Hans': '电子邮件联系',
    },
    'n814pv51': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'onr0i0ie': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    '56qlfex3': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    '86x6y1r7': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'bz6f5yfh': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'rwxlfx96': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    '7w17gsp1': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    'k52l7k8o': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'j3i4x8uh': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FloorPlan
  {
    '9u2m9wea': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'wj0z9lhp': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'p9za3gk3': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    '1jcuncgb': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'ea1w2veg': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '37el8ott': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    '8pphwhvl': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    's3nya8kb': {
      'en': 'OVERALL FLOORPLAN',
      'ja': '全体のフロアプラン',
      'zh_Hans': '总体平面图',
    },
    'hd48nt0t': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'ifxdak17': {
      'en': 'Floorplan',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // Profile15
  {
    '0dpjxojn': {
      'en': 'Edit Profile',
      'ja': 'プロフィールを編集',
      'zh_Hans': '編輯資料',
    },
    'b6daqw7c': {
      'en': 'Change Password',
      'ja': 'パスワードを変更する',
      'zh_Hans': '更改密码',
    },
    'gcp0gv8e': {
      'en': 'Notification Settings',
      'ja': '通知設定',
      'zh_Hans': '通知设置',
    },
    'oeoewcd5': {
      'en': 'Terms of Services',
      'ja': '利用規約',
      'zh_Hans': '服务条款',
    },
    'imjiyvvj': {
      'en': 'Log Out',
      'ja': 'ログアウト',
      'zh_Hans': '登出',
    },
  },
  // FAQRegis
  {
    'vrw7mqgp': {
      'en': 'Registration ',
      'ja': '登録',
      'zh_Hans': '登记',
    },
    'lz9ilrdy': {
      'en': 'Wednesday, 28 May:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'ivej8stk': {
      'en': '08:00 - 20:00 at the Hotel Lobby',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'auenm40k': {
      'en':
          '(Remark: For late arrival after 20:00, please check in at the front desk.)',
      'ja': '（注：20:00以降に到着予定の場合は、フロントにてチェックインをお願いいたします。）',
      'zh_Hans': '（备注：20:00以后抵达的客人请到前台办理入住手续。）',
    },
    'aktt9dwe': {
      'en': 'Thursday, 29 May:  ',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    'huuq8coa': {
      'en': '07:00 - 17:00 at the Grand Ballroom Foyer, \nLevel 2',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    'ro7wp0h9': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'oktt9rbx': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FAQDress
  {
    'gbxd9prs': {
      'en': 'Dress Code',
      'ja': '服装規定',
      'zh_Hans': '着装要求',
    },
    '35rdkc1j': {
      'en': 'Day 1 (May 28):',
      'ja': '1日目（2月14日）:',
      'zh_Hans': '第 1 天（2 月 14 日）：',
    },
    'bnf8soel': {
      'en': 'Smart Casual',
      'ja': 'スマートカジュアル',
      'zh_Hans': '时尚休闲',
    },
    'kcwcldfi': {
      'en': 'Day 2 (May 29):',
      'ja': '2日目（2月15日）:',
      'zh_Hans': '第二天（2 月 15 日）：',
    },
    'e6wsj359': {
      'en':
          'Polo T-shirt, no jeans, no athletic shoes \n(presenters can change into Polo Shirt later)',
      'ja': 'アボット ポロ T シャツ、ジーンズ、運動靴は禁止 \n(プレゼンターは後でポロシャツに着替えることができます)',
      'zh_Hans': 'Abbott Polo T 恤，不穿牛仔裤，不穿运动鞋\n（演讲者稍后可以换成 Polo 衫）',
    },
    'qbw2ah3y': {
      'en': 'Day 3 (May 30):',
      'ja': '3日目（2月16日）:',
      'zh_Hans': '第 3 天（2 月 16 日）：',
    },
    'mx1clvmn': {
      'en': 'Daytime:',
      'ja': '昼間：',
      'zh_Hans': '白天：',
    },
    '6j8495p8': {
      'en': 'Business Casual, no jeans, no athletic \nshoes',
      'ja': 'ビジネスカジュアル、ジーンズ、運動靴は禁止',
      'zh_Hans': '商务休闲装，不宜穿牛仔裤、运动鞋',
    },
    'pqc3vrr5': {
      'en': 'Evening:',
      'ja': '夕方：',
      'zh_Hans': '晚上：',
    },
    'hwnj78bm': {
      'en': 'Formal or Traditional Ethnic for Gala',
      'ja': 'ガラのためのフォーマルまたは伝統的な民族衣装',
      'zh_Hans': '正式或传统的民族庆典',
    },
    'iwhg5q84': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    '25toaweu': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // Feedback
  {
    'xy1wmqjn': {
      'en': 'Name',
      'ja': '名前',
      'zh_Hans': '姓名',
    },
    '2mqavsnd': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    's47be5d1': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'lny1shu9': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'bv25p1aa': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'rskgnf87': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '8wsbb1h3': {
      'en': 'Feedback',
      'ja': 'フィードバック',
      'zh_Hans': '反馈',
    },
    '0q0pwasn': {
      'en': 'Speakers Session',
      'ja': 'スピーカーセッション',
      'zh_Hans': '演讲环节',
    },
    'xm5b97hd': {
      'en': 'End of event feedback',
      'ja': 'イベント終了時のフィードバック',
      'zh_Hans': '活动结束反馈',
    },
    '884d2ifs': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'blxnccud': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    '7e5sbl8a': {
      'en': 'Please  your feedback of the session',
      'ja': 'セッションのフィードバックをお願いします',
      'zh_Hans': '请对会议进行反馈',
    },
    '9t3g1dff': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'ewcu09l5': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // test
  {
    '0qn3ux3n': {
      'en': 'Page Title',
      'ja': '',
      'zh_Hans': '',
    },
    '1x7667hp': {
      'en': 'My Calendar',
      'ja': '',
      'zh_Hans': '',
    },
    'oebu5ly8': {
      'en': 'Home',
      'ja': '',
      'zh_Hans': '',
    },
  },
  // Personal
  {
    'fa0jcywt': {
      'en': 'Your QR Code',
      'ja': 'QRコード',
      'zh_Hans': '您的二维码',
    },
    'vsgjbya1': {
      'en': 'Ref ID',
      'ja': '参照ID',
      'zh_Hans': '参考编号',
    },
    '1490jca5': {
      'en': 'Name',
      'ja': '名前',
      'zh_Hans': '姓名',
    },
    'dm1dfgsy': {
      'en': 'Office Based Country',
      'ja': 'オフィス拠点国',
      'zh_Hans': '办事处所在地国家',
    },
    'jxzzg8kr': {
      'en': 'Check in Date',
      'ja': 'チェックイン日',
      'zh_Hans': '入住日期',
    },
    'ptsxxmti': {
      'en': 'Check out Date',
      'ja': 'チェックアウト日',
      'zh_Hans': '退房日期',
    },
    '61x3ab1d': {
      'en': 'Polo shirt\'s Size',
      'ja': 'ポロシャツのサイズ',
      'zh_Hans': 'Polo 衫尺码',
    },
    '5nkrcb18': {
      'en': 'Your Activity',
      'ja': 'あなたのアクティビティ',
      'zh_Hans': '您的活动',
    },
    '8rcqjmhz': {
      'en': 'Logout',
      'ja': 'ログアウト',
      'zh_Hans': '登出',
    },
    '5zld18de': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    '66d3c835': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // Profile08
  {
    'n9h45gr8': {
      'en': 'David Jerome',
      'ja': '',
      'zh_Hans': '',
    },
    '5ua3ji5m': {
      'en': 'David.j@gmail.com',
      'ja': '',
      'zh_Hans': '',
    },
    'ts6j9pud': {
      'en': 'Passenger Documents',
      'ja': '',
      'zh_Hans': '',
    },
    'jni8derj': {
      'en': 'Tracker Notifications',
      'ja': '',
      'zh_Hans': '',
    },
    '5d9ihf1k': {
      'en': 'Help Center',
      'ja': '',
      'zh_Hans': '',
    },
    '88pwv257': {
      'en': 'Settings',
      'ja': '',
      'zh_Hans': '',
    },
    'fqb8vmj7': {
      'en': 'Phone Number',
      'ja': '',
      'zh_Hans': '',
    },
    '20dlkhro': {
      'en': 'Add Number',
      'ja': '',
      'zh_Hans': '',
    },
    'tv65vsxr': {
      'en': 'Language',
      'ja': '',
      'zh_Hans': '',
    },
    '1t7so7m7': {
      'en': 'English (eng)',
      'ja': '',
      'zh_Hans': '',
    },
    't3fc27tv': {
      'en': 'Currency',
      'ja': '',
      'zh_Hans': '',
    },
    '5obns1rq': {
      'en': 'US Dollar (\$)',
      'ja': '',
      'zh_Hans': '',
    },
    '0ik940tz': {
      'en': 'Profile Settings',
      'ja': '',
      'zh_Hans': '',
    },
    'bcgfva5q': {
      'en': 'Edit Profile',
      'ja': '',
      'zh_Hans': '',
    },
    '4ubeqpi2': {
      'en': 'Notification Settings',
      'ja': '',
      'zh_Hans': '',
    },
    'j9150zqp': {
      'en': 'Log out of account',
      'ja': '',
      'zh_Hans': '',
    },
    '1ab1kpkz': {
      'en': 'Log Out?',
      'ja': '',
      'zh_Hans': '',
    },
    'a1jn31c9': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // post
  {
    'vsllm6oi': {
      'en': 'Coffee Farm Tours',
      'ja': '',
      'zh_Hans': '',
    },
    '1k3ln8vy': {
      'en': '3.1k Members',
      'ja': '',
      'zh_Hans': '',
    },
    'tkvkuwig': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'ja': '',
      'zh_Hans': '',
    },
    '81wn8l5b': {
      'en': 'Alexandria Smith',
      'ja': '',
      'zh_Hans': '',
    },
    'jbgaqvfk': {
      'en': '1m ago',
      'ja': '',
      'zh_Hans': '',
    },
    'm6adi3h8': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'ja': '',
      'zh_Hans': '',
    },
    '5fhm9hys': {
      'en': '3',
      'ja': '',
      'zh_Hans': '',
    },
    'qbugdo0w': {
      'en': 'likes',
      'ja': '',
      'zh_Hans': '',
    },
    't0bxzk6e': {
      'en': '8',
      'ja': '',
      'zh_Hans': '',
    },
    'dt0t7wuv': {
      'en': 'Comments',
      'ja': '',
      'zh_Hans': '',
    },
    'xxnrf65m': {
      'en': 'Randy Alcorn',
      'ja': '',
      'zh_Hans': '',
    },
    'k3iwfvqz': {
      'en':
          'I\'m not really sure about this section here aI think you should do soemthing cool!',
      'ja': '',
      'zh_Hans': '',
    },
    '857ftn7x': {
      'en': 'a min ago',
      'ja': '',
      'zh_Hans': '',
    },
    '05znyxqz': {
      'en': 'Sandra Smith',
      'ja': '',
      'zh_Hans': '',
    },
    'tc9stddb': {
      'en':
          'I\'m not really sure about this section here aI think you should do soemthing cool!',
      'ja': '',
      'zh_Hans': '',
    },
    '5temsv6g': {
      'en': 'a min ago',
      'ja': '',
      'zh_Hans': '',
    },
    '23jraa16': {
      'en': 'Write a Post',
      'ja': '',
      'zh_Hans': '',
    },
    'c77o4t5g': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // detailTeam
  {
    'htifpaqh': {
      'en': 'Position',
      'ja': '',
      'zh_Hans': '',
    },
    'fce1szfp': {
      'en': 'Department',
      'ja': '',
      'zh_Hans': '',
    },
    'mtwjonjf': {
      'en': 'Office Based Country',
      'ja': '',
      'zh_Hans': '',
    },
    '91gmb1sd': {
      'en': 'Year of service',
      'ja': '',
      'zh_Hans': '',
    },
    'emadxl1e': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'n249ul7z': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // SessionPageold
  {
    'ztpr5r2q': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    '3588aith': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'jqn6t68i': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'jf6tncs1': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'wd6gvtqe': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '3hsdyeh4': {
      'en': 'Feedback',
      'ja': 'フィードバック',
      'zh_Hans': '反馈',
    },
    'f4oe1d7g': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'g3c2l2br': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    'pt2uuhyy': {
      'en': 'Speaker Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'vbsjn6pf': {
      'en': 'ALL',
      'ja': '',
      'zh_Hans': '',
    },
    'g4pz1srg': {
      'en': 'DAY 1',
      'ja': '',
      'zh_Hans': '',
    },
    'yrq4td8l': {
      'en': 'DAY 2',
      'ja': '',
      'zh_Hans': '',
    },
    'x4btq33f': {
      'en': 'DAY 3',
      'ja': '',
      'zh_Hans': '',
    },
    'uc43v1dk': {
      'en': 'DAY 4',
      'ja': '',
      'zh_Hans': '',
    },
    '9qr2rwkj': {
      'en': 'ALL',
      'ja': '',
      'zh_Hans': '',
    },
    'yktzhbtg': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // Gallery
  {
    'f3erb5vl': {
      'en': 'Event Gallery',
      'ja': '',
      'zh_Hans': '',
    },
    '8j242mnt': {
      'en': '28 May 2025',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    'h31v08k1': {
      'en': '29 May 2025',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    'e62oami6': {
      'en': '30 May 2025',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    '6fc29ev8': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'gldxy68t': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'pes88x4q': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'o8t5s4na': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    '19y4hmad': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    '4xjqt2bn': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '991wfw1d': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'gohkciih': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    'a0bygtkd': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // TeamProfile
  {
    '0jbwp8qf': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'o2nvpshp': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'owqmwun6': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    '9iky80uc': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'p91yrrrj': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'zrj3jzuf': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'yf73hsu5': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    'cqcybyrk': {
      'en': 'Team Profile',
      'ja': 'チームプロフィール',
      'zh_Hans': '团队简介',
    },
    'x0xj86u2': {
      'en': 'ALL',
      'ja': '全て',
      'zh_Hans': '全部',
    },
    'ay2h8pqp': {
      'en': 'Team1',
      'ja': '管理',
      'zh_Hans': '管理',
    },
    '6rtuo3fr': {
      'en': 'Team2',
      'ja': 'タイ',
      'zh_Hans': '泰国',
    },
    's07mtdv3': {
      'en': 'Team3',
      'ja': '中国',
      'zh_Hans': '中国',
    },
    'oeiqsf02': {
      'en': 'ALL',
      'ja': '',
      'zh_Hans': '',
    },
    '2kfkgf8f': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'hg8sevpw': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // detailSpeaker
  {
    'dwqu0z9v': {
      'en': 'Name',
      'ja': '',
      'zh_Hans': '',
    },
    'i5gymxtj': {
      'en': 'Position',
      'ja': '',
      'zh_Hans': '',
    },
    'u6luw0vf': {
      'en': 'Time Session',
      'ja': '',
      'zh_Hans': '',
    },
    'xg7ktfae': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'h9ppwj7w': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FAQAirport
  {
    '98zan438': {
      'en': 'Airport Map',
      'ja': '空港マップ',
      'zh_Hans': '机场地图',
    },
    'bd5gff9i': {
      'en': 'Don Muang Airport Pick-up',
      'ja': 'ドンムアン空港送迎',
      'zh_Hans': '廊曼机场接机',
    },
    '0251lxbj': {
      'en': 'Download PDF',
      'ja': 'PDFをダウンロード',
      'zh_Hans': '下载 PDF',
    },
    '74oev42i': {
      'en': 'Suvanrnabhumi Airport Pick-up',
      'ja': 'スワンナプーム空港送迎',
      'zh_Hans': '素万那普机场接机',
    },
    'bnpoda84': {
      'en': 'Download PDF',
      'ja': 'PDFをダウンロード',
      'zh_Hans': '下载 PDF',
    },
    'ozl5yzju': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'aqi27wxf': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // ActivityPic
  {
    'iesokm5d': {
      'en': 'Your Activity',
      'ja': 'あなたのアクティビティ',
      'zh_Hans': '您的活动',
    },
    '1kiclf2m': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'lov2xymr': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // SessionPage
  {
    '9f7bin30': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    '7lo0imex': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'dru04bwn': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    '0yflwfs5': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'nb0tykk7': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'mx4cjeqy': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'tisav1vp': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    'docxsqtc': {
      'en': 'Speaker Schedule',
      'ja': 'チームプロフィール',
      'zh_Hans': '团队简介',
    },
    'pg4khus1': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'xs17vq4f': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // noti
  {
    'u8zv9obe': {
      'en': 'Push Notifications ',
      'ja': '',
      'zh_Hans': '',
    },
    '87lxpq5p': {
      'en':
          'Receive Push notifications \nfrom our application on a semi regular basis.',
      'ja': '',
      'zh_Hans': '',
    },
    '8rsdk3x1': {
      'en': 'Open Notifications',
      'ja': '',
      'zh_Hans': '',
    },
    'f81t4094': {
      'en': 'Go to ABBOTT Application',
      'ja': '',
      'zh_Hans': '',
    },
    'h0leajyt': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // SessionPageCopy
  {
    'r3cgmlg3': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'v04c9hdv': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    '3ljby51p': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'odh8qf9i': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'oamgsc0v': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'h1sdz4tt': {
      'en': 'Feedback',
      'ja': 'フィードバック',
      'zh_Hans': '反馈',
    },
    'ulmnpecr': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'p5xq653u': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    '8s10mqet': {
      'en': 'Speaker Schedule',
      'ja': 'チームプロフィール',
      'zh_Hans': '团队简介',
    },
    'gya5g8iv': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // notiCopy
  {
    'a6sd7f6i': {
      'en': 'Push Notifications',
      'ja': '',
      'zh_Hans': '',
    },
    'g1alcpcz': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'ja': '',
      'zh_Hans': '',
    },
    'd86eewkm': {
      'en': 'Noti Permission',
      'ja': '',
      'zh_Hans': '',
    },
    '57ffj1gv': {
      'en': 'Go to  Home Page',
      'ja': '',
      'zh_Hans': '',
    },
    '1dv060q6': {
      'en': 'Test Notification',
      'ja': '',
      'zh_Hans': '',
    },
    '8jhyxd8q': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FAQEmail
  {
    '7vmbx1th': {
      'en': 'Email Contact',
      'ja': '電子メールでのお問い合わせ',
      'zh_Hans': '电子邮件联系',
    },
    'wn5x6ofg': {
      'en':
          'Should you have any questions regarding this email or need assistance with anything else regarding your attendance at the Conference please don’t hesitate to contact us at',
      'ja': 'このメールに関してご質問がある場合、またはカンファレンスへの参加に関して他にサポートが必要な場合は、お気軽にお問い合わせください。',
      'zh_Hans': '如果您对本电子邮件有任何疑问，或需要有关参加会议的任何其他帮助，请随时通过以下方式联系我们',
    },
    'u2u9r5jy': {
      'en': 'Amphika at',
      'ja': 'アンフィカ',
      'zh_Hans': '安菲卡',
    },
    'irhknz6m': {
      'en': 'amphika.indeedcreation@gmail.com',
      'ja': 'amphika.indeedcreation@gmail.com',
      'zh_Hans': 'amphika.indeedcreation@gmail.com',
    },
    'gebvgbqz': {
      'en': 'Siriyanee at',
      'ja': 'シリヤニー',
      'zh_Hans': 'Siriyanee 在',
    },
    'g81idsag': {
      'en': 'siriyanee@indeedcreation.com',
      'ja': '1. Grab または認可された交通手段のご利用を強くお勧めします。',
      'zh_Hans': '1. 强烈建议您使用 Grab 或授权的交通渠道。',
    },
    'akwsvb0f': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'fw1yiavi': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // TeamProfileold
  {
    '64brt58l': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'd5k998wu': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'qlxzkw9d': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'nbx0vob2': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'pv78n1dx': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'ny9x46b2': {
      'en': 'Feedback',
      'ja': 'フィードバック',
      'zh_Hans': '反馈',
    },
    'bup69nwk': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'zs5duhev': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    'rkzr98dn': {
      'en': 'Team Profile',
      'ja': 'チームプロフィール',
      'zh_Hans': '团队简介',
    },
    '0emjem3g': {
      'en': 'ALL',
      'ja': '全て',
      'zh_Hans': '全部',
    },
    'ozm3csf2': {
      'en': 'GLOBAL',
      'ja': '管理',
      'zh_Hans': '管理',
    },
    'fkxl18k1': {
      'en': 'APAC HQ',
      'ja': 'タイ',
      'zh_Hans': '泰国',
    },
    '16h253sk': {
      'en': 'Special visitor',
      'ja': '中国',
      'zh_Hans': '中国',
    },
    '7gkxnggy': {
      'en': 'Australia',
      'ja': '日本',
      'zh_Hans': '日本',
    },
    '65pvcwp5': {
      'en': 'New Zealand',
      'ja': 'オーストラリア',
      'zh_Hans': '澳大利亚',
    },
    '7szsgj4t': {
      'en': 'EMAK India',
      'ja': 'シンガポール',
      'zh_Hans': '新加坡',
    },
    'vv6v64xl': {
      'en': 'EMAK Korea',
      'ja': '香港',
      'zh_Hans': '香港',
    },
    '51af6vnv': {
      'en': 'EMAK SEA',
      'ja': 'インドネシア',
      'zh_Hans': '印度尼西亚',
    },
    'h14l2wbt': {
      'en': 'Greater China China',
      'ja': '',
      'zh_Hans': '',
    },
    'inrdrlra': {
      'en': 'Greater China Hong Kong',
      'ja': '',
      'zh_Hans': '',
    },
    '9sunkq3z': {
      'en': 'Greater China Taiwan',
      'ja': '',
      'zh_Hans': '',
    },
    '3rgf1ddd': {
      'en': 'Japan',
      'ja': '',
      'zh_Hans': '',
    },
    'fbm6y0db': {
      'en': 'ALL',
      'ja': '',
      'zh_Hans': '',
    },
    'zakkuc1e': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // TeamProfileCopy2
  {
    '5h5w9wco': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    'lqqjgy17': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'jbt4cqj2': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'pw1fmjsk': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    'b9o373v3': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    '1zj7c2bl': {
      'en': 'Feedback',
      'ja': 'フィードバック',
      'zh_Hans': '反馈',
    },
    'x7sto5t1': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    'ysu1ctp9': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    's0ivdkxe': {
      'en': 'Team Profile',
      'ja': 'チームプロフィール',
      'zh_Hans': '团队简介',
    },
    '6ofottoa': {
      'en': 'ALL',
      'ja': '全て',
      'zh_Hans': '全部',
    },
    'qwautp57': {
      'en': 'GLOBAL',
      'ja': '管理',
      'zh_Hans': '管理',
    },
    'ytzs1crr': {
      'en': 'APAC HQ',
      'ja': 'タイ',
      'zh_Hans': '泰国',
    },
    '7ma39fir': {
      'en': 'Special visitor',
      'ja': '中国',
      'zh_Hans': '中国',
    },
    'kyhb7b6z': {
      'en': 'Australia',
      'ja': '日本',
      'zh_Hans': '日本',
    },
    'qz8baual': {
      'en': 'New Zealand',
      'ja': 'オーストラリア',
      'zh_Hans': '澳大利亚',
    },
    '8w14o068': {
      'en': 'EMAK India',
      'ja': 'シンガポール',
      'zh_Hans': '新加坡',
    },
    'tjrqvdfd': {
      'en': 'EMAK Korea',
      'ja': '香港',
      'zh_Hans': '香港',
    },
    'iwdzdr26': {
      'en': 'EMAK SEA',
      'ja': 'インドネシア',
      'zh_Hans': '印度尼西亚',
    },
    'r5wkn68x': {
      'en': 'Greater China China',
      'ja': '',
      'zh_Hans': '',
    },
    '0p5hu0cb': {
      'en': 'Greater China Hong Kong',
      'ja': '',
      'zh_Hans': '',
    },
    '6lfrts5l': {
      'en': 'Greater China Taiwan',
      'ja': '',
      'zh_Hans': '',
    },
    '5s5g843q': {
      'en': 'Japan',
      'ja': '',
      'zh_Hans': '',
    },
    'iq27mgrs': {
      'en': 'ALL',
      'ja': '',
      'zh_Hans': '',
    },
    '4vklvf2i': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // TeamProfileCopy
  {
    '1eitfs8p': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
    '73u4z5nm': {
      'en': 'Event Agenda',
      'ja': 'イベントアジェンダ',
      'zh_Hans': '活动议程',
    },
    'b7tv03pd': {
      'en': 'Floor Plan',
      'ja': 'フロアプラン',
      'zh_Hans': '楼层平面图',
    },
    'aoekbms6': {
      'en': 'Speakers Schedule',
      'ja': '講演スケジュール',
      'zh_Hans': '演讲者日程',
    },
    '3etrfiee': {
      'en': 'FAQ',
      'ja': 'よくある質問',
      'zh_Hans': '常问问题',
    },
    'epuplysn': {
      'en': 'Feedback',
      'ja': 'フィードバック',
      'zh_Hans': '反馈',
    },
    'jwfy3zjd': {
      'en': 'Settings',
      'ja': '設定',
      'zh_Hans': '设置',
    },
    '5ojtiwzo': {
      'en': 'Language options:',
      'ja': '言語オプション:',
      'zh_Hans': '语言选项:',
    },
    '8bw8lpns': {
      'en': 'Team Profile',
      'ja': 'チームプロフィール',
      'zh_Hans': '团队简介',
    },
    'qzt34frj': {
      'en': 'ALL',
      'ja': '全て',
      'zh_Hans': '全部',
    },
    'kbdj2n1d': {
      'en': 'GLOBAL',
      'ja': '管理',
      'zh_Hans': '管理',
    },
    'fy0erpez': {
      'en': 'APAC HQ',
      'ja': 'タイ',
      'zh_Hans': '泰国',
    },
    'cx2bd28c': {
      'en': 'Special visitor',
      'ja': '中国',
      'zh_Hans': '中国',
    },
    'il4r6wql': {
      'en': 'Australia',
      'ja': '日本',
      'zh_Hans': '日本',
    },
    '67fr24rd': {
      'en': 'New Zealand',
      'ja': 'オーストラリア',
      'zh_Hans': '澳大利亚',
    },
    'qredbsgm': {
      'en': 'EMAK India',
      'ja': 'シンガポール',
      'zh_Hans': '新加坡',
    },
    '2msr556e': {
      'en': 'EMAK Korea',
      'ja': '香港',
      'zh_Hans': '香港',
    },
    'w3ehms8a': {
      'en': 'EMAK SEA',
      'ja': 'インドネシア',
      'zh_Hans': '印度尼西亚',
    },
    'rlgq3kkv': {
      'en': 'Greater China China',
      'ja': '',
      'zh_Hans': '',
    },
    'm5d4u73o': {
      'en': 'Greater China Hong Kong',
      'ja': '',
      'zh_Hans': '',
    },
    '7oenmc85': {
      'en': 'Greater China Taiwan',
      'ja': '',
      'zh_Hans': '',
    },
    'vwn9v9ti': {
      'en': 'Japan',
      'ja': '',
      'zh_Hans': '',
    },
    'tvek3er3': {
      'en': 'ALL',
      'ja': '',
      'zh_Hans': '',
    },
    'upyfr0ve': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // login
  {
    'z6lfctai': {
      'en': 'Welcome',
      'ja': '',
      'zh_Hans': '',
    },
    'txzfh43b': {
      'en': 'Fill out the information below in order to access your account.',
      'ja': '',
      'zh_Hans': '',
    },
    '07pa6yq0': {
      'en': 'Email',
      'ja': '',
      'zh_Hans': '',
    },
    'mtm3btu5': {
      'en': 'Password',
      'ja': '',
      'zh_Hans': '',
    },
    'egvto0ux': {
      'en': 'Sign In',
      'ja': '',
      'zh_Hans': '',
    },
    'm44qsp79': {
      'en': 'Home',
      'ja': '',
      'zh_Hans': '',
    },
  },
  // search
  {
    'bqwo75zz': {
      'en': 'TextField',
      'ja': '',
      'zh_Hans': '',
    },
    'pp5cexx6': {
      'en': '100 ฿',
      'ja': '',
      'zh_Hans': '',
    },
    'jslzelui': {
      'en': 'Phone',
      'ja': '',
      'zh_Hans': '',
    },
    '8k0dohii': {
      'en': 'Search Page',
      'ja': '',
      'zh_Hans': '',
    },
    '1ycytsgl': {
      'en': 'Home',
      'ja': '',
      'zh_Hans': '',
    },
  },
  // FAQSafety
  {
    'ba6l9297': {
      'en': 'Safety Tips',
      'ja': '登録',
      'zh_Hans': '登记',
    },
    'xthiat46': {
      'en': '1. Keep Your Stuff Safe:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    '1p881c9k': {
      'en':
          'ust stay aware of your things in crowded spots. A crossbody bag works great!',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'mkhnzr9t': {
      'en': '2. Use Trusted Rides:',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    '1m7l0zw8': {
      'en':
          'Taxis: Make sure the meter’s on, or agree on the price first.\nGrab: It’s like Uber – quick, easy, and safe!',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    'or6xxoa4': {
      'en': '3. Watch Out for Scams:',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    'cvaklvd9': {
      'en':
          'If something feels too good to be true, it might be. Always double-check.',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    'b1k6d0qq': {
      'en': '4. Be Careful with Traffic:',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    '2q9imz7h': {
      'en': 'Use pedestrian crossings and look out for motorbikes zooming by!',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    '4dwczrft': {
      'en': '5. Drink Smart:',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    'vaqazx4r': {
      'en':
          'Street food is awesome, just pick vendors with lots of people around. And keep an eye on your drink.',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    '42kcmqvo': {
      'en': '6. Emergency Numbers:',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    'ta1m09ch': {
      'en': 'Police: 191, Medical: 1669, Tourist Police: 1155.',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    'b3mj6842': {
      'en': '7. Respect the Local Culture:',
      'ja': '2月15日土曜日:',
      'zh_Hans': '2月15日，星期六：',
    },
    '3aub2mc1': {
      'en':
          'Cover your shoulders and knees when visiting temples. Be kind and respectful to the Thai people and their traditions.',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    '5hqvx5vm': {
      'en': 'Enjoy your time in Bangkok and stay safe! 😊',
      'ja': 'グランドボールルームホワイエ、レベル2にて07:00～17:00',
      'zh_Hans': '07:00 - 17:00，2 楼大宴会厅前厅',
    },
    '5338a1g3': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'mmpzvn2q': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FAQInformation
  {
    'byc68yvz': {
      'en': 'Information Bangkok and Thailand',
      'ja': '登録',
      'zh_Hans': '登记',
    },
    'bwfsuwn8': {
      'en': '1. Transportation:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'fk8y2d1t': {
      'en':
          '- BTS Skytrain: Fast and convenient for key areas like Sukhumvit, Silom, and Chatuchak.\n- MRT Subway: Efficient, connecting spots like Hua Lamphong and Chatuchak.\n- Taxis: Use the meter or agree on a fare beforehand.\n- Grab: Reliable ride-hailing app for getting around.\n- Tuk-Tuks: Iconic 3-wheeled vehicles, negotiate the price.\n- Boats/Ferries: Scenic travel on the Chao Phraya River to landmarks like the Grand Palace and Wat Arun',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '911afuh2': {
      'en': '2. Places to Visit:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'svxhr6q5': {
      'en':
          '- Grand Palace: Iconic landmark with the Emerald Buddha.\n- Wat Arun: Riverside temple with stunning views, especially at sunrise.\n- Siam Area: Luxury malls like Siam Paragon and MBK Center.\n- Asiatique The Riverfront: Night market with shops, restaurants, and a Ferris wheel.\n- Khao San Road: Backpacker hub with nightlife and street food.\n- Chinatown: Bustling markets, food stalls, and temples.',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'v24qcgpp': {
      'en': '3. Local Cuisine:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'dklk4x2r': {
      'en':
          '- Pad Thai: Stir-fried noodles, a local favorite.\n- Tom Yum Goong: Spicy shrimp soup.\n- Som Tum: Spicy green papaya salad.\n- Mango Sticky Rice: Sweet dessert with sticky rice and mango.\n- Street Food: Bangkok’s famous street food is around Sukhumvit, Khao San, and Chinatown.',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'ghsrkvps': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    'ohypzlk6': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // FAQEmergency
  {
    '2n0m37tv': {
      'en': 'Emergency Contact',
      'ja': '登録',
      'zh_Hans': '登记',
    },
    'wazwdnmb': {
      'en': 'Police and general emergency call:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    '6b4h2vb6': {
      'en': '191',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '1a33kg2j': {
      'en': 'Emergency Medical:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'sexnzfdu': {
      'en': '1669',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'bxc3nvb7': {
      'en': 'Water Accident:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'avjg355o': {
      'en': '1196',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '78770p7j': {
      'en': 'Motorway Hotline:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    '6okb1tjg': {
      'en': '1586 press 7',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '8bp700wj': {
      'en': 'Highway Police:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'srz6x0wo': {
      'en': '1193',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'tm0chgf2': {
      'en': 'Tourist Police:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    '11krh77m': {
      'en': '1155',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '0rq6yfnt': {
      'en': 'Thailand Transport Portal:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'm7xenw3m': {
      'en': '1356',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '5m9o0138': {
      'en': 'Bumrungrad International Hospital:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'zu808yr3': {
      'en': '+66 2066 8888',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    '7f4j594c': {
      'en': 'Police General Hospital:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'hdli7w9e': {
      'en': '0-2207-6000',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'ad3aqtcm': {
      'en': 'King Chulalongkorn Memorial Hospital:',
      'ja': '2月14日金曜日:',
      'zh_Hans': '2月14日，星期五：',
    },
    'wljzqdmp': {
      'en': '02-256-4000',
      'ja': 'ホテルロビーにて08:00～20:00',
      'zh_Hans': '08:00 - 20:00 酒店大堂',
    },
    'sampvyg8': {
      'en': 'Swire Coca-Cola \nLeaders Summit 2025',
      'ja': '',
      'zh_Hans': '',
    },
    '47fysy3v': {
      'en': 'Home',
      'ja': '家',
      'zh_Hans': '家',
    },
  },
  // NAVBAR
  {
    'e3gvnohm': {
      'en': 'Home',
      'ja': '',
      'zh_Hans': '',
    },
    '1cu2hm72': {
      'en': 'Agenda',
      'ja': '',
      'zh_Hans': '',
    },
    'u4wlz120': {
      'en': 'Floorplan',
      'ja': '',
      'zh_Hans': '',
    },
  },
  // QRCode
  {
    '03ff6e25': {
      'en': 'Ref ID',
      'ja': '参照ID',
      'zh_Hans': '参考编号',
    },
  },
  // Miscellaneous
  {
    'cfyk5g1q': {
      'en': 'Please allow to open camera',
      'ja': '',
      'zh_Hans': '',
    },
    'tg5ij2ix': {
      'en': 'Allow to push notification',
      'ja': '',
      'zh_Hans': '',
    },
    '1fn1wy6p': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'x3jq9yi9': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'z9n3lmcs': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'emp8056p': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'zzxkubb2': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'flxn43zc': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'h2uub98q': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'tyv8o8ut': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'jdtf2p9p': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'qqdo0lz9': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    '9vfgte5u': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'sr7kylfx': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'ad7b41uy': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'q6kzw31f': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    '9psnvvmu': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    '2vnid9np': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'hm0hnkwr': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'c2w57u5u': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'ae90ckk5': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'n5r47wr2': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'xhdmal8d': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'i208rn3k': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'dfjm5o1c': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    '96ne0vf3': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
    'puyq3uyv': {
      'en': '',
      'ja': '',
      'zh_Hans': '',
    },
  },
].reduce((a, b) => a..addAll(b));
