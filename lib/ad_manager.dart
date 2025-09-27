import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pvstore/config.dart';

class AdManager {
  RewardedAd? _rewardedAd;

  void loadRewardedAd({required Function(RewardedAd) onAdLoaded}) {
    final adUnitId = Config.rewardedAdUnitId;
    print('Loading rewarded ad with ad unit ID: $adUnitId');
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          print('RewardedAd loaded successfully');
          onAdLoaded(ad);
        },
        onAdFailedToLoad: (error) {
          print('RewardedAd failed to load: $error');
          print('Error code: ${error.code}');
          print('Error domain: ${error.domain}');
          print('Error message: ${error.message}');
        },
      ),
    );
  }

  void showRewardedAd({
    required Function(RewardItem reward) onUserEarnedReward,
    required Function() onAdClosed,
  }) {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          onAdClosed();
          _rewardedAd = null;
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Ad failed to show: $error');
          ad.dispose();
        },
      );

      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onUserEarnedReward(reward);
      });
    } else {
      print('RewardedAd is not ready yet.');
    }
  }
}