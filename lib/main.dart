import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:js' as js; // เพิ่ม js package เพื่อใช้งาน JavaScript

// ฟังก์ชันสำหรับการจัดการข้อความที่ได้รับเมื่อแอปทำงานในพื้นหลัง
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

// ฟังก์ชันสำหรับตั้งค่า FCM บน Web/PWA
Future<void> _initializeWebFCM() async {
  try {
    // บันทึก FCM token พร้อม VAPID key
    FirebaseMessaging.instance.getToken(
      vapidKey: 'BC0MO0z7yU2oEwzFQIq9vx54rcL-a02viFq0548EcazydnDz8fiB5ZnzybxZotnQN16o-B7Lh4detHy0a9aaYx4', // ต้องแทนที่ด้วยค่าจริงจาก Firebase Console
    ).then((String? token) {
      if (token != null) {
        print('FCM Token: $token');
        _saveFCMToken(token);
      }
    });

    // สำหรับแอปพลิเคชัน Flutter ที่ใช้ JS
    js.context.callMethod('eval', [
      '''
      if ('Notification' in window) {
        Notification.requestPermission().then(function(permission) {
          console.log('Notification permission status:', permission);
        });
      }
      '''
    ]);

  } catch (e) {
    print('Error initializing Firebase Messaging on Web: $e');
  }
}

// บันทึก FCM token ไว้ในฐานข้อมูลหรือส่งไปยังเซิร์ฟเวอร์
void _saveFCMToken(String token) {
  // ตัวอย่าง:
  // FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(currentUser.uid)
  //     .update({'fcmToken': token});
  
  // หรือส่ง HTTP request ไปยังเซิร์ฟเวอร์ของคุณ
  // http.post('https://your-api.com/tokens', body: {'token': token});
  print('FCM Token saved: $token');
}

// ฟังก์ชันสำหรับจัดการการคลิกที่การแจ้งเตือนและนำทางไปยังหน้าที่เหมาะสม
void _handleNotificationClick(RemoteMessage message) {
  // ดึงข้อมูลจาก message และทำการนำทางไปยังหน้าที่เหมาะสม
  // ในกรณีของ FlutterFlow เราจะใช้ GoRouter เพื่อนำทางไปยังหน้าที่ต้องการ
  
  if (message.data.containsKey('route')) {
    String route = message.data['route'];
    
    // ตัวอย่างการนำทางด้วย GoRouter
    // GoRouter.of(navigatorKey.currentContext!).go(route);
    
    print('Should navigate to route: $route');
  }
}

// ฟังก์ชันเริ่มต้นการใช้งาน FCM
Future<void> initializeFirebaseMessaging() async {
  // สำหรับเว็บ/PWA โดยเฉพาะ
  if (kIsWeb) {
    await _initializeWebFCM();
  } else {
    // สำหรับมือถือ
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    // รับ FCM token สำหรับอุปกรณ์มือถือ
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('Mobile FCM Token: $token');
      _saveFCMToken(token);
    }
  }

  // การจัดการกับข้อความ foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification:');
      print('Title: ${message.notification!.title}');
      print('Body: ${message.notification!.body}');
      // สำหรับเว็บได้ถูกจัดการใน JavaScript แล้ว
      
      // สำหรับอุปกรณ์มือถือ คุณอาจต้องการแสดงการแจ้งเตือนในแอปที่นี่
      if (!kIsWeb) {
        // แสดงการแจ้งเตือนในแอปโดยใช้ FlutterLocalNotifications หรือแพ็คเกจอื่น
      }
    }
  });

  // จัดการการคลิกที่การแจ้งเตือนเมื่อแอปถูกเปิด
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    _handleNotificationClick(message);
  });

  // ตรวจสอบการคลิกที่การแจ้งเตือนที่ทำให้เปิดแอป
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print('App opened from terminated state via notification');
      _handleNotificationClick(message);
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  // เริ่มต้น Firebase ปกติของ FlutterFlow
  await initFirebase();
  
  // ลงทะเบียน background handler สำหรับ FCM
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // เริ่มต้นการใช้งาน FCM
  await initializeFirebaseMessaging();

  await SupaFlow.initialize();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = swireCocaColaLeadersSummit2025FirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Swire Coca-Cola Leaders Summit 2025',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        Locale('ja'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Home';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': HomeWidget(),
      'DayilyEventAgenda': DayilyEventAgendaWidget(),
      'FloorPlan': FloorPlanWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Color(0xFFCE2127),
        selectedItemColor: FlutterFlowTheme.of(context).secondaryBackground,
        unselectedItemColor: FlutterFlowTheme.of(context).primaryText,
        selectedBackgroundColor: Color(0x00000000),
        borderRadius: 8.0,
        itemBorderRadius: 8.0,
        margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        width: double.infinity,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_rounded,
                  color: currentIndex == 0
                      ? FlutterFlowTheme.of(context).secondaryBackground
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 32.0,
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'qduicz2a' /* Home */,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 0
                        ? FlutterFlowTheme.of(context).secondaryBackground
                        : FlutterFlowTheme.of(context).primaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.calendar,
                  color: currentIndex == 1
                      ? FlutterFlowTheme.of(context).secondaryBackground
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    '8pe1qo0f' /* Agenda */,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 1
                        ? FlutterFlowTheme.of(context).secondaryBackground
                        : FlutterFlowTheme.of(context).primaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  color: currentIndex == 2
                      ? FlutterFlowTheme.of(context).secondaryBackground
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'ifxdak17' /* Floorplan */,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 2
                        ? FlutterFlowTheme.of(context).secondaryBackground
                        : FlutterFlowTheme.of(context).primaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}