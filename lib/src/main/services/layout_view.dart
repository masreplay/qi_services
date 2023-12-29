import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qi_services/common_lib.dart';

part 'layout_view.g.dart';

/// A layout view variant [LayoutViewVariant]
@JsonEnum(
  alwaysCreate: true,
)
enum LayoutViewVariant {
  /// [ListView] with tile builder
  list,

  /// [GridView] with tile builder
  grid,

  /// Rows and columns with to represent a grid and list
  mixed;

  String toJson() => _$LayoutViewVariantEnumMap[this]!;
  factory LayoutViewVariant.fromJson(String json) => _$LayoutViewVariantEnumMap
      .map((key, value) => MapEntry(value, key))[json]!;
}

class LayoutViewDelegate {
  const LayoutViewDelegate({
    this.crossAxisCount = 3,
    this.maxCrossAxisExtent,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
  });

  final double? maxCrossAxisExtent;

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;
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
  int? index,
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
    this.padding,
    required this.listTileBuilder,
    required this.gridTileBuilder,
  });

  final EdgeInsets? padding;

  final List<LayoutCategory<T>> data;

  final LayoutViewVariant type;

  final LayoutViewDelegate? delegate;

  final LayoutViewListTileBuilder<T> listTileBuilder;

  final LayoutViewGridTileBuilder<T> gridTileBuilder;

  @override
  Widget build(BuildContext context) {
    final items = data.expand((category) => category.data).toList();

    final delegate = this.delegate ??
        const LayoutViewDelegate(
          crossAxisCount: 3,
        );

    Widget widget;

    switch (type) {
      case LayoutViewVariant.list:
        widget = ListView.separated(
          padding: padding,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return listTileBuilder(context, index, items[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox.square(dimension: delegate.mainAxisSpacing);
          },
        );
      case LayoutViewVariant.grid:
        widget = AlignedGridView.count(
          padding: padding,
          crossAxisCount: delegate.crossAxisCount,
          mainAxisSpacing: delegate.mainAxisSpacing,
          crossAxisSpacing: delegate.crossAxisSpacing,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return gridTileBuilder(context, index, items[index]);
          },
        );

      case LayoutViewVariant.mixed:
        widget = SingleChildScrollView(
          padding: padding,
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: category.data.length,
                        itemBuilder: (context, index) {
                          return listTileBuilder(
                            context,
                            null,
                            category.data[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox.square(
                            dimension: delegate.mainAxisSpacing,
                          );
                        },
                      ),
                    if (category.layout == LayoutViewVariant.grid)
                      AlignedGridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        crossAxisCount: delegate.crossAxisCount,
                        mainAxisSpacing: delegate.mainAxisSpacing,
                        crossAxisSpacing: delegate.crossAxisSpacing,
                        itemCount: category.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return gridTileBuilder(
                            context,
                            index,
                            category.data[index],
                          );
                        },
                      ),
                  ],
                ),
            ],
          ),
        );
    }

    return Column(
      children: [
        Expanded(child: widget),
      ],
    );
  }
}
