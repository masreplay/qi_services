import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_lib.dart';
import 'src/main/main.dart';

class MainApp extends StatefulHookConsumerWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    final theme = MainTheme();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(appRouterProvider).config(),
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: settings.themeMode,
      theme: theme.buildLight(),
      darkTheme: theme.buildDark(),
    );
  }
}
