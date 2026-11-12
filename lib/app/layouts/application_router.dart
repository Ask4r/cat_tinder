import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'application_shell.dart';

const _views = {'discover', 'settings'};

@immutable
class TabLocation {
  TabLocation(Iterable<String> history) : history = List.unmodifiable(history);
  final List<String> history;
  String get selected => history.last;
}

class TabRouteParser extends RouteInformationParser<TabLocation> {
  const TabRouteParser();

  @override
  Future<TabLocation> parseRouteInformation(RouteInformation routeInformation) {
    final path = routeInformation.uri.path.replaceAll('/', '');
    final selected = _views.contains(path) ? path : 'discover';
    final state = routeInformation.state;
    if (state is List &&
        state.isNotEmpty &&
        state.every((entry) => entry is String && _views.contains(entry)) &&
        state.last == selected) {
      return SynchronousFuture(TabLocation(state.cast<String>()));
    }
    return SynchronousFuture(
      TabLocation(['discover', if (selected != 'discover') selected]),
    );
  }

  @override
  RouteInformation restoreRouteInformation(TabLocation configuration) =>
      RouteInformation(
        uri: Uri(path: '/${configuration.selected}'),
        state: configuration.history,
      );
}

class ApplicationRouter extends RouterDelegate<TabLocation>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<TabLocation> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  TabLocation _location = TabLocation(['discover']);

  @override
  TabLocation get currentConfiguration => _location;

  void _select(String view) {
    if (!_views.contains(view) || view == _location.selected) return;
    _location = TabLocation([..._location.history, view]);
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(TabLocation configuration) {
    _location = configuration;
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() async {
    if (await super.popRoute()) return true;
    if (_location.history.length == 1) return false;
    _location = TabLocation(
      _location.history.take(_location.history.length - 1),
    );
    notifyListeners();
    return true;
  }

  @override
  Widget build(BuildContext context) => Navigator(
    key: navigatorKey,
    pages: [
      MaterialPage<void>(
        key: const ValueKey('application'),
        child: ApplicationShell(
          selected: _location.selected,
          onSelected: (view) {
            if (view == _location.selected) return;
            Router.navigate(context, () => _select(view));
          },
        ),
      ),
    ],
    onDidRemovePage: (_) {},
  );
}
