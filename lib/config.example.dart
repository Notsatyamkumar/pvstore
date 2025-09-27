// This is an example configuration file
// Copy this file to config.dart and update with your actual values
// Never commit config.dart to version control

class Config {
  // Ad Unit IDs
  static const String testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224350000'; // Google's test ad unit
  static const String productionRewardedAdUnitId = 'YOUR_PRODUCTION_REWARDED_AD_UNIT_ID';
  
  // API Configuration
  static const String baseApiUrl = 'https://your-api-domain.com/api';
  static const String loginEndpoint = '$baseApiUrl/login';
  static const String walletUpdateEndpoint = '$baseApiUrl/wallet/update';
  
  // App Configuration
  static const String appName = 'Your App Name';
  static const String appTagline = 'Your App Tagline';
  
  // Development Settings
  static const bool isDebugMode = true;
  static const bool useTestAds = true;
  
  // Get the appropriate ad unit ID based on environment
  static String get rewardedAdUnitId {
    if (useTestAds || isDebugMode) {
      return testRewardedAdUnitId;
    }
    return productionRewardedAdUnitId;
  }
}
