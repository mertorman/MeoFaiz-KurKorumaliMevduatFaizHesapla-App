import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../views/sonucsayfasi.dart';

class AdmobAd {
  InterstitialAd? interstitialAd;
  bool isInterstitialAdReady = false;

  BannerAd? staticAd;
  static const AdRequest request = AdRequest();
  bool staticadLoaded = false;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3905531565098628/1359291850',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this.interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              SonucSayfasi;
            },
          );

          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  void loadStaticBannerAd() {
    staticAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3905531565098628/8547156317',
        listener: BannerAdListener(onAdLoaded: (ad) {
          staticadLoaded = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print("reklamhata");
        }),
        request: request);

    staticAd?.load();
  }
}
