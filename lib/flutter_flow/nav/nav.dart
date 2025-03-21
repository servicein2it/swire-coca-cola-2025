import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
        ),
        FFRoute(
          name: LoginOldWidget.routeName,
          path: LoginOldWidget.routePath,
          builder: (context, params) => LoginOldWidget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Home')
              : NavBarPage(
                  initialPage: 'Home',
                  page: HomeWidget(),
                ),
        ),
        FFRoute(
          name: DayilyEventAgendaWidget.routeName,
          path: DayilyEventAgendaWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'DayilyEventAgenda')
              : DayilyEventAgendaWidget(
                  day1: params.getParam(
                    'day1',
                    ParamType.String,
                  ),
                  selectedImageURL: params.getParam(
                    'selectedImageURL',
                    ParamType.String,
                  ),
                  selectImageURL2: params.getParam(
                    'selectImageURL2',
                    ParamType.String,
                  ),
                  selectImageURL3: params.getParam(
                    'selectImageURL3',
                    ParamType.String,
                  ),
                  selectImageURL4: params.getParam(
                    'selectImageURL4',
                    ParamType.String,
                  ),
                ),
        ),
        FFRoute(
          name: FaqWidget.routeName,
          path: FaqWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FaqWidget(),
          ),
        ),
        FFRoute(
          name: FloorPlanWidget.routeName,
          path: FloorPlanWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'FloorPlan')
              : FloorPlanWidget(),
        ),
        FFRoute(
          name: Profile15Widget.routeName,
          path: Profile15Widget.routePath,
          builder: (context, params) => Profile15Widget(),
        ),
        FFRoute(
          name: FAQRegisWidget.routeName,
          path: FAQRegisWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQRegisWidget(),
          ),
        ),
        FFRoute(
          name: FAQDressWidget.routeName,
          path: FAQDressWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQDressWidget(),
          ),
        ),
        FFRoute(
          name: FeedbackWidget.routeName,
          path: FeedbackWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FeedbackWidget(),
          ),
        ),
        FFRoute(
          name: TestWidget.routeName,
          path: TestWidget.routePath,
          builder: (context, params) => TestWidget(),
        ),
        FFRoute(
          name: PersonalWidget.routeName,
          path: PersonalWidget.routePath,
          builder: (context, params) => PersonalWidget(),
        ),
        FFRoute(
          name: Profile08Widget.routeName,
          path: Profile08Widget.routePath,
          builder: (context, params) => Profile08Widget(),
        ),
        FFRoute(
          name: PostWidget.routeName,
          path: PostWidget.routePath,
          builder: (context, params) => PostWidget(),
        ),
        FFRoute(
          name: DetailTeamWidget.routeName,
          path: DetailTeamWidget.routePath,
          builder: (context, params) => DetailTeamWidget(
            teamName: params.getParam(
              'teamName',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['teamprofile'],
            ),
          ),
        ),
        FFRoute(
          name: SessionPageoldWidget.routeName,
          path: SessionPageoldWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: SessionPageoldWidget(),
          ),
        ),
        FFRoute(
          name: GalleryWidget.routeName,
          path: GalleryWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: GalleryWidget(),
          ),
        ),
        FFRoute(
          name: TeamProfileWidget.routeName,
          path: TeamProfileWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: TeamProfileWidget(),
          ),
        ),
        FFRoute(
          name: DetailSpeakerWidget.routeName,
          path: DetailSpeakerWidget.routePath,
          builder: (context, params) => DetailSpeakerWidget(
            teamName: params.getParam(
              'teamName',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['teamprofile'],
            ),
            sessionName: params.getParam(
              'sessionName',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Session'],
            ),
          ),
        ),
        FFRoute(
          name: FAQAirportWidget.routeName,
          path: FAQAirportWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQAirportWidget(),
          ),
        ),
        FFRoute(
          name: ActivityPicWidget.routeName,
          path: ActivityPicWidget.routePath,
          builder: (context, params) => ActivityPicWidget(),
        ),
        FFRoute(
          name: SessionPageWidget.routeName,
          path: SessionPageWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: SessionPageWidget(),
          ),
        ),
        FFRoute(
          name: NotiWidget.routeName,
          path: NotiWidget.routePath,
          builder: (context, params) => NotiWidget(),
        ),
        FFRoute(
          name: SessionPageCopyWidget.routeName,
          path: SessionPageCopyWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: SessionPageCopyWidget(),
          ),
        ),
        FFRoute(
          name: NotiCopyWidget.routeName,
          path: NotiCopyWidget.routePath,
          builder: (context, params) => NotiCopyWidget(),
        ),
        FFRoute(
          name: FAQEmailWidget.routeName,
          path: FAQEmailWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQEmailWidget(),
          ),
        ),
        FFRoute(
          name: TeamProfileoldWidget.routeName,
          path: TeamProfileoldWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: TeamProfileoldWidget(),
          ),
        ),
        FFRoute(
          name: TeamProfileCopy2Widget.routeName,
          path: TeamProfileCopy2Widget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: TeamProfileCopy2Widget(),
          ),
        ),
        FFRoute(
          name: TeamProfileCopyWidget.routeName,
          path: TeamProfileCopyWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: TeamProfileCopyWidget(),
          ),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: SearchWidget.routeName,
          path: SearchWidget.routePath,
          builder: (context, params) => SearchWidget(),
        ),
        FFRoute(
          name: FAQSafetyWidget.routeName,
          path: FAQSafetyWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQSafetyWidget(),
          ),
        ),
        FFRoute(
          name: FAQInformationWidget.routeName,
          path: FAQInformationWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQInformationWidget(),
          ),
        ),
        FFRoute(
          name: FAQEmergencyWidget.routeName,
          path: FAQEmergencyWidget.routePath,
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: FAQEmergencyWidget(),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Place_holder_for_size_chart_(6).png',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
