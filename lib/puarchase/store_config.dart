import 'dart:io';
import 'package:logomaker/Upsellscreen/constant.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store,this.apiKey);

  static StoreConfig get instance {
    return _instance!;
  }

  static bool isForAppleStore() => instance.store == Store.appStore || instance.store == Store.macAppStore;

  static bool isForGooglePlay() => instance.store == Store.playStore;

  static bool isForAmazonAppstore() =>
      instance.store == Store.amazon;
}

Future<void> configureStore() async {
  try {
    if (Platform.isIOS || Platform.isMacOS) {
      StoreConfig(
        store: Store.appStore,
        apiKey: appleApiKey,
      );
    } else if (Platform.isAndroid) {
      const useAmazon = bool.fromEnvironment("amazon");
      StoreConfig(
        store: useAmazon ? Store.amazon : Store.playStore,
        apiKey: useAmazon ? amazonApiKey : googleApiKey,
      );
    }
    await configurePurchaseSDK();
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> configurePurchaseSDK() async {
  try{
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration configuration;
    if (StoreConfig.isForAmazonAppstore()) {
      configuration = AmazonConfiguration(StoreConfig.instance.apiKey);
    } else {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
    }
    configuration.entitlementVerificationMode =
        EntitlementVerificationMode.informational;
    await Purchases.configure(configuration);
    await Purchases.enableAdServicesAttributionTokenCollection();
  }catch(e){
    return;
  }
}
