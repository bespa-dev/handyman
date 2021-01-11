import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/src/dialogs.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ArtisanServiceListItem extends StatefulWidget {
  final String service;

  const ArtisanServiceListItem({Key key, @required this.service})
      : super(key: key);

  @override
  _ArtisanServiceListItemState createState() => _ArtisanServiceListItemState();
}

class _ArtisanServiceListItemState extends State<ArtisanServiceListItem> {
  /// blocs
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());
  final _updateServiceBloc = ArtisanServiceBloc(repo: Injection.get());

  /// UI
  final _controller = TextEditingController();

  @override
  void dispose() {
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
      builder: (_, state) => state is SuccessState<BaseArtisanService>
          ? InkWell(
              splashColor: kTheme.splashColor,
              borderRadius: BorderRadius.circular(kSpacingX8),
              onTap: () async {
                final data = await showCustomDialog(
                  context: context,
                  builder: (_) => ReplyMessageDialog(
                    title: "Set price for service",
                    controller: _controller,
                    hintText: "e.g. 200",
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
