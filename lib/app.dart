import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_io/io.dart';

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

    final String localeName =
        settings.locale?.languageCode ?? Platform.localeName.split('_').first;

    final theme = MainTheme(localeName: localeName);

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
