import 'package:flutter/foundation.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  String get bannerAdUnitId => '';
  String get interstitialAdUnitId => '';
  String get rewardedAdUnitId => '';

  void initialize() {
    debugPrint('AdService Web: Anúncios web ativos.');
  }

  void onGameCompleted({VoidCallback? onAdClosed}) {
    if (onAdClosed != null) onAdClosed();
  }

  void showInterstitialAd({VoidCallback? onDismissed}) {
    if (onDismissed != null) onDismissed();
  }

  void showRewardedAd({required Function(dynamic reward) onUserEarnedReward}) {
    debugPrint('Rewarded ad simulado para Web.');
    onUserEarnedReward(null);
  }
}
