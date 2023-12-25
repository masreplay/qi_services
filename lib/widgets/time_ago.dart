import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/common_lib.dart';

class TimeAgo extends HookWidget {
  const TimeAgo({
    super.key,
    required this.builder,
    this.duration = const Duration(seconds: 1),
  });

  final Widget Function(BuildContext context, DateTime now) builder;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final now = useState(DateTime.now());

    useEffect(
      () {
        final timer = Timer.periodic(duration, (_) {
          now.value = DateTime.now();
        });

        return timer.cancel;
      },
      [],
    );

    return builder(context, now.value);
  }
}
