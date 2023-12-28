import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_repository.g.dart';

/// Singleton for repository
/// `not using class based provider
/// because it's not have the ability to not using build method`
@riverpod
NotificationsRepository notificationsRepository(
  NotificationsRepositoryRef ref,
) {
  return NotificationsRepository._(ref);
}

class NotificationsRepository {
  const NotificationsRepository._(this._ref);

  // ignore: unused_field
  final Ref _ref;

  List<NotificationModel> get _data {
    return [
      NotificationModel(
        title: 'تخفيضات العيد',
        body: 'تخفيضات العيد تصل الى 50% على جميع الخدمات',
        image: null,
        date: DateTime.now(),
        isRead: true,
      ),
      NotificationModel(
        title: 'تخفيضات نهاية السنة',
        body: 'تخفيضات العيد تصل الى 70% على جميع الخدمات',
        image: null,
        date: DateTime.now(),
        isRead: false,
      ),
    ];
  }

  Future<List<NotificationModel>> getAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return _data;
  }

  Future<int> getCount() async {
    await Future.delayed(const Duration(seconds: 2));
    return _data.where((element) => !element.isRead).length;
  }
}
