import 'package:danim/main.dart';
import 'package:danim/models/Token.dart';
import 'package:danim/models/UserInfo.dart';
import 'package:danim/services/user_repository.dart';
import 'package:danim/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  Future<void> loginButtonPressed(context, AppViewModel appViewModel) async {
    bool isInstalled = await isKakaoTalkInstalled();
    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();
    final accessToken = token.accessToken;
    final refreshToken = token.refreshToken;
    Token ourToken = await UserRepository().kakaoLogin(
        Token(accessToken: accessToken, refreshToken: refreshToken));

    const storage = FlutterSecureStorage();

    storage.write(key: 'accessToken', value: ourToken.accessToken);
    storage.write(key: 'refreshToken', value: ourToken.refreshToken);

    UserInfo userInfo = await UserRepository().getUserInfo(context);

    storage.write(key: 'userUid', value: userInfo.userUid.toString());
    appViewModel.updateUserInfo(userInfo);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => MyHomePage(),
        ),
        (route) => false);
  }
}
