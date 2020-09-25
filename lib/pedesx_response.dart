import 'dart:typed_data';
import 'package:pedesxplugin/pedesxplugin.dart';

const String _errCode = "errCode";
const String _errStr = "errStr";

typedef BasePedesxResponse _PedesxResponseInvoker(Map argument);

Map<String,_PedesxResponseInvoker> _nameAndResponseMapper = {
  "onRewardResponse": (Map argument) =>
      onRewardResponse.fromMap(argument),
};

class BasePedesxResponse {
  final int errCode;
  final String errStr;

  bool get isSuccessful => errCode == 0;

  BasePedesxResponse._(this.errCode, this.errStr);

  factory BasePedesxResponse.create(String name, Map argument) =>
      _nameAndResponseMapper[name](argument);
}

class onRewardResponse extends BasePedesxResponse {
  final bool rewardVerify;
  final int rewardAmount;
  final String rewardName;

  onRewardResponse.fromMap(Map map)
      : rewardVerify = map["rewardVerify"],
        rewardAmount = map["rewardAmount"],
        rewardName = map["rewardName"],
        super._(map[_errCode], map[_errStr]);
}