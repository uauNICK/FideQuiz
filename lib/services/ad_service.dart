import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:fidequiz/config/constants.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _isInterstitialLoading = false;
  bool _isRewardedLoading = false;

  int _gamesPlayedSinceLastAd = 0;

  void initialize() {
    if (kIsWeb) return;
    loadInterstitialAd();
    loadRewardedAd();
  }

  // ─── Banner Ad Helper ───────────────────────────────────────────
  String get bannerAdUnitId {
    if (kIsWeb) return '';
    if (Platform.isAndroid) {
      return AppConstants.adMobBannerIdAndroid;
    } else if (Platform.isIOS) {
      return AppConstants.adMobBannerIdIos;
    }
    return '';
  }

  // ─── Interstitial Ad ────────────────────────────────────────────
  String get interstitialAdUnitId {
    if (kIsWeb) return '';
    if (Platform.isAndroid) {
      return AppConstants.adMobInterstitialIdAndroid;
    } else if (Platform.isIOS) {
      return AppConstants.adMobInterstitialIdIos;
    }
    return '';
  }

  void loadInterstitialAd() {
    if (kIsWeb || _isInterstitialLoading || _interstitialAd != null) return;
    _isInterstitialLoading = true;

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoading = false;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (err) {
          _isInterstitialLoading = false;
          _interstitialAd = null;
          debugPrint('Falha ao carregar Interstitial: $err');
        },
      ),
    );
  }

  void onGameCompleted({VoidCallback? onAdClosed}) {
    _gamesPlayedSinceLastAd++;
    if (_gamesPlayedSinceLastAd >= AppConstants.adFrequencyGames) {
      showInterstitialAd(onDismissed: () {
        _gamesPlayedSinceLastAd = 0;
        if (onAdClosed != null) onAdClosed();
      });
    } else {
      if (onAdClosed != null) onAdClosed();
    }
  }

  void showInterstitialAd({VoidCallback? onDismissed}) {
    if (kIsWeb || _interstitialAd == null) {
      if (onDismissed != null) onDismissed();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
        if (onDismissed != null) onDismissed();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
        if (onDismissed != null) onDismissed();
      },
    );

    _interstitialAd!.show();
  }

  // ─── Rewarded Ad ────────────────────────────────────────────────
  String get rewardedAdUnitId {
    if (kIsWeb) return '';
    if (Platform.isAndroid) {
      return AppConstants.adMobRewardedIdAndroid;
    } else if (Platform.isIOS) {
      return AppConstants.adMobRewardedIdIos;
    }
    return '';
  }

  void loadRewardedAd() {
    if (kIsWeb || _isRewardedLoading || _rewardedAd != null) return;
    _isRewardedLoading = true;

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoading = false;
        },
        onAdFailedToLoad: (err) {
          _isRewardedLoading = false;
          _rewardedAd = null;
          debugPrint('Falha ao carregar Rewarded: $err');
        },
      ),
    );
  }

  void showRewardedAd({required Function(RewardItem reward) onUserEarnedReward}) {
    if (kIsWeb || _rewardedAd == null) {
      debugPrint('Rewarded ad indisponível no momento.');
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _rewardedAd = null;
        loadRewardedAd();
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      onUserEarnedReward(reward);
    });
  }
}
