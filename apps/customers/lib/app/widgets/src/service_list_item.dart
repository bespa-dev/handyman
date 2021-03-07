import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ArtisanServiceListItem extends StatefulWidget {
  const ArtisanServiceListItem({Key key, @required this.service})
      : super(key: key);

  final String service;

  @override
  _ArtisanServiceListItemState createState() => _ArtisanServiceListItemState();
}

class _ArtisanServiceListItemState extends State<ArtisanServiceListItem> {
  /// blocs
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _updateServiceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  final _controller = TextEditingController();

  @override
  void dispose() {
    _categoryBloc.close();
    _serviceBloc.close();
    _updateServiceBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get service info
      _serviceBloc.add(ArtisanServiceEvent.getServiceById(id: widget.service));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return BlocBuilder<ArtisanServiceBloc, BlocState>(
      cubit: _serviceBloc,
      buildWhen: (previous, current) => previous != current,
      builder: (_, state) => state is SuccessState<BaseArtisanService>
          ? InkWell(
        splashColor: kTheme.splashColor,
        borderRadius: BorderRadius.circular(kSpacingX8),
        onTap: () async {
          final data = await showCustomDialog(
            context: context,
            builder: (_) => ReplyMessageDialog(
              title: 'Set price for service',
              controller: _controller,
              hintText: 'e.g. 200',
            ),
          );
          if (data != null) {
            _updateServiceBloc.add(
              ArtisanServiceEvent.updateArtisanService(
                service:
                state.data.copyWith(price: double.tryParse(data)),
              ),
            );
            _controller.clear();

            /// get service details
            _serviceBloc.add(
                ArtisanServiceEvent.getServiceById(id: state.data.id));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kSpacingX16,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: kTheme.colorScheme.secondary,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(kSpacingX8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatCurrency(state.data.price),
                textAlign: TextAlign.center,
                style: kTheme.textTheme.headline4,
              ),
              SizedBox(height: kSpacingX8),
              Text(
                state.data.name,
                textAlign: TextAlign.center,
                style: kTheme.textTheme.bodyText1,
              ),
            ],
          ),
        ),
      )
          : SizedBox.shrink(),
    );
  }
}

class ArtisanServiceListView extends StatefulWidget {
  const ArtisanServiceListView({
    Key key,
    @required this.services,
    this.onItemSelected,
    this.selected,
    this.selectedColor,
    this.unselectedColor,
    this.checkable = false,
  }) : super(key: key);

  final List<BaseArtisanService> services;
  final Function(BaseArtisanService) onItemSelected;
  final BaseArtisanService selected;
  final Color selectedColor;
  final Color unselectedColor;
  final bool checkable;

  @override
  _ArtisanServiceListViewState createState() => _ArtisanServiceListViewState();
}

class _ArtisanServiceListViewState extends State<ArtisanServiceListView> {
  @override
  Widget build(BuildContext context) => Container(
    width: SizeConfig.screenWidth,
    height: SizeConfig.screenHeight,
    child: ListView.builder(
      itemBuilder: (_, index) {
        final item = widget.services[index];
        return ArtisanServiceListTile(
          service: item,
          showLeadingIcon: widget.checkable,
          onTap: () {
            if (widget.onItemSelected != null) widget.onItemSelected(item);
          },
          selected: widget.selected == item,
          selectedColor: widget.selectedColor,
          unselectedColor: widget.unselectedColor,
          showPrice: true,
        );
      },
      itemCount: widget.services.length,
      padding: EdgeInsets.zero,
    ),
  );
}

class ArtisanServiceListTile extends StatefulWidget {
  const ArtisanServiceListTile({
    Key key,
    @required this.service,
    this.onTap,
    this.selected = false,
    this.selectedColor,
    this.unselectedColor,
    this.showLeadingIcon = true,
    this.showTrailingIcon = true,
    this.showPrice = false,
  }) : super(key: key);

  final BaseArtisanService service;
  final bool selected;
  final bool showPrice;
  final bool showLeadingIcon;
  final bool showTrailingIcon;
  final Function() onTap;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  _ArtisanServiceListTileState createState() => _ArtisanServiceListTileState();
}

class _ArtisanServiceListTileState extends State<ArtisanServiceListTile> {
  /// blocs
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _updateServiceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  final _controller = TextEditingController();
  BaseArtisanService _currentService;

  @override
  void dispose() {
    _categoryBloc.close();
    _serviceBloc.close();
    _updateServiceBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _currentService = widget.service;
      if (mounted) setState(() {});
      _categoryBloc
          .add(CategoryEvent.observeCategoryById(id: widget.service.category));

      _serviceBloc
        ..add(ArtisanServiceEvent.getServiceById(id: widget.service.id))
        ..listen((state) {
          if (state is SuccessState<BaseArtisanService>) {
            _currentService = state.data;
            if (mounted) setState(() {});
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return BlocBuilder<ArtisanServiceBloc, BlocState>(
      bloc: _serviceBloc,
      builder: (_, serviceState) => BlocBuilder<CategoryBloc, BlocState>(
        bloc: _categoryBloc,
        builder: (_, state) => AnimatedContainer(
          duration: kScaleDuration,
          margin: EdgeInsets.symmetric(vertical: kSpacingX4),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.selected
                  ? widget.selectedColor ?? kTheme.colorScheme.secondary
                  : widget.unselectedColor ?? kTheme.cardColor,
            ),
            borderRadius: BorderRadius.circular(kSpacingX4),
          ),
          child: ListTile(
            onTap: widget.onTap ??
                    () async {
                  final data = await showCustomDialog(
                    context: context,
                    builder: (_) => ReplyMessageDialog(
                      title: 'Set price for service',
                      controller: _controller,
                      hintText: 'e.g. 99.99',
                    ),
                  );
                  if (data != null) {
                    _currentService =
                        _currentService.copyWith(price: double.tryParse(data));
                    setState(() {});
                    _controller.clear();
                    logger.d(_currentService);

                    _updateServiceBloc.add(
                      ArtisanServiceEvent.updateArtisanService(
                          service: _currentService),
                    );

                    _serviceBloc.add(ArtisanServiceEvent.getServiceById(
                        id: _currentService.id));
                  }
                },
            title: Text(
              _currentService.name,
              style: TextStyle(
                color: widget.selected
                    ? widget.selectedColor ?? kTheme.colorScheme.secondary
                    : kTheme.colorScheme.onBackground
                    .withOpacity(kEmphasisHigh),
              ),
            ),
            leading: state is SuccessState<Stream<BaseServiceCategory>> &&
                widget.showLeadingIcon
                ? StreamBuilder<BaseServiceCategory>(
                stream: state.data,
                builder: (_, snapshot) => UserAvatar(
                    url: snapshot.hasData ? snapshot.data.avatar : ''))
                : null,
            subtitle: state is SuccessState<Stream<BaseServiceCategory>>
                ? StreamBuilder<BaseServiceCategory>(
                stream: state.data,
                builder: (_, snapshot) => Text(
                  widget.showPrice || snapshot.hasError
                      ? formatCurrency(_currentService.price)
                      : snapshot.hasData
                      ? snapshot.data.name
                      : '...',
                  style: TextStyle(
                    color: widget.selected
                        ? widget.selectedColor ??
                        kTheme.colorScheme.secondary
                        : kTheme.colorScheme.onBackground
                        .withOpacity(kEmphasisMedium),
                  ),
                ))
                : SizedBox.shrink(),
            trailing: widget.showTrailingIcon
                ? IconButton(
              icon: Icon(kHelpIcon),
              color: widget.selected
                  ? widget.selectedColor ?? kTheme.colorScheme.secondary
                  : kTheme.colorScheme.onBackground
                  .withOpacity(kEmphasisHigh),
              onPressed: () => showCustomDialog(
                context: context,
                builder: (_) => InfoDialog(
                  title: _currentService.name,
                  message: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: kServiceHelperText),
                        TextSpan(
                            text: '\n\nPrice range starts from\t',
                            style: kTheme.textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600,
                            )),
                        TextSpan(
                          text: formatCurrency(_currentService.price),
                          style: kTheme.textTheme.bodyText1.copyWith(
                            color: kTheme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                : null,
            selected: widget.selected,
            tileColor: widget.unselectedColor ?? kTheme.cardColor,
          ),
        ),
      ),
    );
  }
}
