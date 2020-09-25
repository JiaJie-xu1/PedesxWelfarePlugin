import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedesxplugin/pedesxplugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('pedesxplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Pedesxplugin.platformVersion, '42');
  });
}
