import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

/// custom tab selector
class TabSelector extends StatefulWidget {
  const TabSelector({
    Key key,
    @required this.tabs,
    @required this.onTabChanged,
    this.activeIndex = 0,
  })  : assert(tabs != null),
        assert(onTabChanged != null),
        super(key: key);

  @override
  _TabSelectorState createState() => _TabSelectorState();

  final List<String> tabs;
  final int activeIndex;
  final Function(int) onTabChanged;
}

class _TabSelectorState extends State<TabSelector> {
  ThemeData _kTheme;

  /// tab item
  Widget _buildTabItem(
          {@required String title, @required int index, bool active = false}) =>
      Padding(
        padding: EdgeInsets.only(bottom: kSpacingX16, top: kSpacingX20),
        child: InkWell(
          splashColor: kTransparent,
          borderRadius:
              BorderRadius.circular(active ? kSpacingX24 : kSpacingNone),
          onTap: () => widget.onTabChanged(index),
          child: AnimatedContainer(
            duration: kScaleDuration,
            width: SizeConfig.screenWidth * 0.25,
            height: kSpacingX36,
            decoration: BoxDecoration(
              border: Border.all(
                color: active ? _kTheme.colorScheme.onBackground : kTransparent,
              ),
              borderRadius:
                  BorderRadius.circular(active ? kSpacingX24 : kSpacingNone),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: _kTheme.textTheme.button.copyWith(
                color: active
                    ? _kTheme.colorScheme.onBackground
                    : _kTheme.colorScheme.onBackground
                        .withOpacity(kEmphasisLow),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _kTheme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...widget.tabs
            .map(
              (tab) => _buildTabItem(
                title: tab,
                index: widget.tabs.indexOf(tab),
              ),
            )
            .toList(),
      ],
    );
  }
}
