import 'package:qi_services/common_lib.dart';

/// A layout view variant [LayoutViewVariant]
enum LayoutViewVariant {
  /// [ListView] with tile builder
  list,

  /// [GridView] with tile builder
  grid,

  /// Rows and columns with to represent a grid and list
  mixed,
}

class LayoutViewDelegate {
  const LayoutViewDelegate();
}

/// A category of items in a layout view
class LayoutCategory<T extends Object> {
  const LayoutCategory({
    this.title,
    required this.layout,
    required this.data,
  }) : assert(layout != LayoutViewVariant.mixed);

  final String? title;

  final List<T> data;

  final LayoutViewVariant layout;

  List<T> toList() {
    return data;
  }
}

/// [LayoutViewVariant.list] tile builder
typedef LayoutViewListTileBuilder<T extends Object> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

/// [LayoutViewVariant.grid] tile builder
typedef LayoutViewGridTileBuilder<T extends Object> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

/// A layout view that can be used to display a list of items in a list or grid or both.
class LayoutView<T extends Object> extends StatelessWidget {
  const LayoutView(
    this.data, {
    super.key,
    this.type = LayoutViewVariant.list,
    this.delegate,
    required this.listTileBuilder,
    required this.gridTileBuilder,
  });

  final List<LayoutCategory<T>> data;
  final LayoutViewVariant type;
  final LayoutViewDelegate? delegate;
  final LayoutViewListTileBuilder<T> listTileBuilder;
  final LayoutViewGridTileBuilder<T> gridTileBuilder;

  @override
  Widget build(BuildContext context) {
    final items = data.expand((category) => category.data).toList();

    final delegate = this.delegate ?? const LayoutViewDelegate();

    switch (type) {
      case LayoutViewVariant.list:
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: Insets.medium),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return listTileBuilder(context, index, items[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox.square(dimension: Insets.small);
          },
        );
      case LayoutViewVariant.grid:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (final item in data.sublist(0, 3))
                    Expanded(child: Text(item.title!)),
                ],
              ),
            ),
          ],
        );
      case LayoutViewVariant.mixed:
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: Insets.medium,
            horizontal: Insets.medium,
          ),
          child: ColumnPadded(
            spacing: Insets.medium,
            children: [
              for (final category in data)
                ColumnPadded(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (category.title != null)
                      Text(
                        category.title!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    if (category.layout == LayoutViewVariant.list)
                      Column(
                        children: [
                          for (final (index, item) in category.data.indexed)
                            listTileBuilder(context, index, item),
                        ],
                      ),
                    if (category.layout == LayoutViewVariant.grid)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (var i = 0; i < 3; i++)
                            if (i < category.data.length)
                              Expanded(
                                child: listTileBuilder(
                                  context,
                                  i,
                                  category.data[i],
                                ),
                              )
                            else
                              const Spacer(),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        );
    }
  }
}
