import 'package:alice/alice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router/app_router.dart';

part 'alice.g.dart';

@Riverpod(keepAlive: true)
Raw<Alice> alice(AliceRef ref) {
  return Alice(
    navigatorKey: navigatorKey,
    showNotification: true,
    showInspectorOnShake: true,
  );
}
