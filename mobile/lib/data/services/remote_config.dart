import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:handyman/core/service_locator.dart';

/// Config parameter
const String _appFeaturesEnabled = "app_features_enabled";
const String _appConfigMessage = "app_config_message";

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{_appFeaturesEnabled: true};

  static RemoteConfigService _instance;

  RemoteConfigService({@required RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;


  static Future<RemoteConfigService> getInstance() async {
    return _instance ??=
        RemoteConfigService(remoteConfig: await sl.getAsync<RemoteConfig>());
  }

  String get configMessage => _remoteConfig.getString(_appConfigMessage);
  bool get showAppFeatures => _remoteConfig.getBool(_appFeaturesEnabled);

  Future init() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _remoteConfig.fetch(expiration: Duration(seconds: 0));
      await _remoteConfig.activateFetched();
    } on FetchThrottledException catch (e) {
      debugPrint("Remote config fetch throttled => $e");
    } catch (e) {
      debugPrint("An error occurred while activating your remote service");
    }
  }
}
