import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'services_repository.g.dart';

@riverpod
ServicesRepository servicesRepository(
  ServicesRepositoryRef ref,
) {
  return const ServicesRepository._();
}

class ServicesRepository {
  const ServicesRepository._();

  Future<List<ServiceModel>> getAll(
      // Some filters
      ) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      const ServiceModel(
        titles: {
          "ar": "من سيربح المليون",
          "en": "Who wants to be a millionaire",
        },
        descriptions: {
          "ar": "اربح ملايين الدولارات بالإجابة على الأسئلة",
          "en": "Win millions of dollars by answering questions",
        },
        image:
            "https://play-lh.googleusercontent.com/QYz93ZggjS3jZLkKVovlTCU1yxScNLV9A8c5Z2SgY2gPyh8TVecSfWns2cL4-KtD3A",
        url:
            "https://play-lh.googleusercontent.com/QYz93ZggjS3jZLkKVovlTCU1yxScNLV9A8c5Z2SgY2gPyh8TVecSfWns2cL4-KtD3A",
        urlLaunchMode: LaunchMode.externalApplication,
        foregroundColor: Colors.white,
        backgroundColor: null,
        gradientColors: [
          Color(0xFFFFD900),
          Color(0xFFFFBB00),
        ],
        gradientBegin: Alignment.topCenter,
        gradientEnd: Alignment.bottomCenter,
      ),
    ];
  }
}
