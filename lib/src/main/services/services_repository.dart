import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/services/service_model.dart';
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
        title: "من سيربح المليون",
        description: "اربح ملايين الدولارات بالإجابة على الأسئلة",
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