import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'ad_manager.dart';
import 'package:pvstore/in_app_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final AdManager _adManager = AdManager();
  bool _isAdLoaded = false;
  String bearerToken = "";
  String allowedUrlSet = "https://pvstore.padhaivadhai.com";
  bool isLoading = false;
  String username = "";
SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    SharedPreferences.getInstance().then((prefs) {
       prefs = prefs;
       print(prefs.getKeys());
      // Retrieve the bearer token from SharedPreferences;
      setState(() {
        username = prefs.getString('userName') ?? '';
        bearerToken = prefs.getString('accessToken') ?? '';
        isLoading = false;
        allowedUrlSet =
            "https://pvstore.padhaivadhai.com/auto-login?token=$bearerToken";
      });
    });
    // Add a small delay to ensure MobileAds is fully initialized
    Future.delayed(const Duration(seconds: 1), () {
      _adManager.loadRewardedAd(
        onAdLoaded: (ad) {
          _isAdLoaded = true;
          setState(() {}); // Update UI to show ad loaded
          print('RewardedAd loaded.');
        },
      );
    });
  }

  void _showRewardedAd() {
    if (_isAdLoaded) {
      _adManager.showRewardedAd(
        onUserEarnedReward: (reward) async {
          print('User earned reward: ${reward.amount} ${reward.type}');
          setState(() {
            _counter += reward.amount.toInt(); // Add reward points
          });

          print("----------------");
          print(bearerToken);

          // Update the balance using the API
          await updateBalance(reward.amount.toInt(), bearerToken);
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Congratulations!',
            text: 'You have been rewarded with ${reward.amount} PV coin(s).',
            confirmBtnText: 'OK',
          );
        },
        onAdClosed: () {
          _adManager.loadRewardedAd(
            onAdLoaded: (ad) {
              print('RewardedAd reloaded.');
            },
          );
        },
      );
    }
  }

  Future<void> updateBalance(int balance, String bearerToken) async {
    final Uri url = Uri.parse(
      'https://pvstore.padhaivadhai.com/api/wallet/update?balance=$balance',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Balance updated successfully: ${data['message']}');
      } else {
        print('Failed to update balance: ${response.body}');
      }
    } catch (e) {
      print('Error updating balance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(prefs?.getKeys());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
        (bearerToken.isEmpty)
            ? "Hi!"
            : "Hi ${username}!",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
                top: 5,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _showRewardedAd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/watchad.jpg', // Path to the logo
                    // Adjust the height as needed
                  ),
                ),

                SizedBox(width: 10),
                Text("Earn Points"),
              ],
            ),
          ),

          SizedBox(width: 10),
        ],
        // Make AppBar background transparent
        elevation: 0, // Remove shadow
      ),
      body: isLoading?Center(child: CircularProgressIndicator()): InAppBrowser(
        allowedUrl: allowedUrlSet, // Replace with your allowed URL
      ),
    );
  }
}
