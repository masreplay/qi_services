import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';

import 'area_code.dart';

Future<AreaCode?> showAreaCodeBottomSheet({
  required BuildContext context,
  required AreaCode value,
}) {
  return showModalBottomSheet<AreaCode>(
    context: context,
    showDragHandle: true,
    enableDrag: true,
    builder: (context) {
      return HookConsumer(
        builder: (context, ref, child) {
          final controller = useTextEditingController();

          final codes = ref.watch(getAreaCodesProvider(controller.text));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: "Search",
                    suffixIcon: Icon(DefaultIcons.search),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: codes.length,
                  itemBuilder: (context, index) {
                    final areaCode = codes[index];
                    return ListTile(
                      title: Text("${areaCode.country} (${areaCode.code})"),
                      onTap: () {
                        context.router.pop(areaCode);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
