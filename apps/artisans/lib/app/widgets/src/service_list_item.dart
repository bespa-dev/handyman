import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

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
  final _prefsBloc = PrefsBloc(repo: Injection.get());

  /// UI
  final _controller = TextEditingController();
  String _userId;

  @override
  void dispose() {
    _categoryBloc.close();
    _serviceBloc.close();
    _updateServiceBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get service info
      _serviceBloc.add(ArtisanServiceEvent.getServiceById(id: widget.service));

      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _userId = state.data;
            if (mounted) setState(() {});
          }
        });
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
                if (data != null && _userId != null) {
                  _updateServiceBloc.add(
                    ArtisanServiceEvent.updateArtisanService(
                      id: _userId,
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
              onTap: () {
                if (widget.onItemSelected != null) widget.onItemSelected(item);
              },
              selected: widget.selected == item,
              selectedColor: widget.selectedColor,
              unselectedColor: widget.unselectedColor,
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
    this.service,
    this.serviceId,
    this.onTap,
    this.onLongTap,
    this.selected = false,
    this.selectedColor,
    this.unselectedColor,
    this.showTrailingIcon = true,
    this.showPrice = false,
  })  : assert(serviceId != null || service != null),
        super(key: key);

  final BaseArtisanService service;
  final String serviceId;
  final bool selected;
  final bool showPrice;
  final bool showTrailingIcon;
  final Function() onTap;
  final Function(BaseArtisanService) onLongTap;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  _ArtisanServiceListTileState createState() => _ArtisanServiceListTileState();
}

class _ArtisanServiceListTileState extends State<ArtisanServiceListTile> {
  /// blocs
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _updateServiceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());

  /// UI
  final _controller = TextEditingController();
  BaseArtisanService _currentService;
  String _userId;

  @override
  void dispose() {
    _serviceBloc.close();
    _updateServiceBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _currentService = widget.service;
      setState(() {});

      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _userId = state.data;
            if (mounted) setState(() {});
          }
        });

      _serviceBloc
        ..add(ArtisanServiceEvent.getServiceById(
            id: widget.serviceId ?? widget.service?.id))
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

    return _currentService == null
        ? SizedBox.shrink()
        : BlocBuilder<ArtisanServiceBloc, BlocState>(
            cubit: _serviceBloc,
            builder: (_, serviceState) => AnimatedContainer(
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
                onLongPress: () => widget.onLongTap(_currentService),
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
                      if (data != null && _userId != null) {
                        _currentService = _currentService.copyWith(
                          price: double.tryParse(data),
                          artisanId: _userId,
                        );
                        setState(() {});
                        _controller.clear();

                        _updateServiceBloc.add(
                          ArtisanServiceEvent.updateArtisanService(
                            id: _userId,
                            service: _currentService,
                          ),
                        );

                        _serviceBloc.add(ArtisanServiceEvent.getServiceById(
                            id: _currentService.id));
                      }
                    },
                title: Text(
                  _currentService?.name ?? '...',
                  style: TextStyle(
                    color: widget.selected
                        ? widget.selectedColor ?? kTheme.colorScheme.secondary
                        : kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisHigh),
                  ),
                ),
                subtitle: Text(
                  _currentService.hasIssues
                      ? '${_currentService.issues.length} fixable issues'
                      : widget.showPrice
                          ? formatCurrency(_currentService.price)
                          : '...',
                  style: TextStyle(
                    color: widget.selected
                        ? widget.selectedColor ?? kTheme.colorScheme.secondary
                        : kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisMedium),
                  ),
                ),
                trailing: widget.showTrailingIcon
                    ? IconButton(
                        icon: Icon(kHelpIcon),
                        color: widget.selected
                            ? widget.selectedColor ??
                                kTheme.colorScheme.secondary
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
                                      style:
                                          kTheme.textTheme.bodyText1.copyWith(
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
          );
  }
}
