import 'package:app_widget_android/src/app_widget_android_platform.dart';
import 'package:app_widget_platform_interface/app_widget_platform_interface.dart';
import 'package:flutter/services.dart';

const onConfigureWidgetCallback = 'onConfigureWidget';
const onClickWidgetCallback = 'onClickWidget';
const onUpdateWidgetsCallback = 'onUpdateWidgets';
const onDeletedWidgetsCallback = 'onDeletedWidgets';

const MethodChannel _methodChannel = MethodChannel(AppWidgetPlatform.channel);

class AppWidgetAndroidPlugin extends AppWidgetAndroid {
  AppWidgetAndroidPlugin({
    void Function(int widgetId)? onConfigureWidget,
    void Function(String? payload)? onClickWidget,
  })  : _onConfigureWidget = onConfigureWidget,
        _onClickWidget = onClickWidget {
    _methodChannel.setMethodCallHandler(handleMethod);
  }

  final void Function(int widgetId)? _onConfigureWidget;
  final void Function(String? payload)? _onClickWidget;

  Future<dynamic> handleMethod(MethodCall call) async {
    switch (call.method) {
      case onConfigureWidgetCallback:
        final widgetId = call.arguments['widgetId'] as int;
        return _onConfigureWidget?.call(widgetId);
      case onClickWidgetCallback:
        return _onClickWidget?.call(call.arguments['payload'] as String);
      default:
        throw UnimplementedError('Method ${call.method} is not implemented!');
    }
  }

  @override
  Future<bool?> cancelConfigureWidget() {
    return _methodChannel.invokeMethod<bool>('cancelConfigureWidget');
  }

  @override
  Future<bool?> configureWidget({
    String? androidPackageName,
    int? widgetId,
    String? widgetLayout,
    Map<String, String>? textViews = const {},
    Map<String, String>? imageViews = const {},
    String? payload,
    Map<String, String>? url,
  }) {
    assert(widgetId != null, 'widgetId is required for android!');
    assert(widgetLayout != null, 'widgetLayout is required for android!');

    return _methodChannel.invokeMethod<bool>('configureWidget', {
      'androidPackageName': androidPackageName,
      'widgetLayout': widgetLayout,
      'widgetId': widgetId,
      'textViews': textViews,
      'imageViews': imageViews,
      'payload': payload,
      'url': url,
    });
  }

  @override
  Future<List<int>?> getWidgetIds({
    String? androidPackageName,
    String? androidProviderName,
  }) async {
    assert(
      androidProviderName != null,
      'androidProviderName is required for android!',
    );

    final widgetIds =
        await _methodChannel.invokeMethod<List<dynamic>?>('getWidgetIds', {
      'androidProviderName': androidProviderName,
      'androidPackageName': androidPackageName,
    });

    return widgetIds?.map<int>((id) => id as int).toList();
  }

  @override
  Future<bool?> reloadWidgets({
    String? androidPackageName,
    String? androidProviderName,
  }) {
    assert(
      androidProviderName != null,
      'androidProviderName is required for android!',
    );

    return _methodChannel.invokeMethod<bool>(
      'reloadWidgets',
      {'androidProviderName': androidProviderName,
       'androidPackageName': androidPackageName,},
    );
  }

  @override
  Future<bool?> updateWidget({
    String? androidPackageName,
    int? widgetId,
    String? widgetLayout,
    Map<String, String>? textViews = const {},
    String? payload,
    Map<String, String>? url,
  }) {
    assert(widgetId != null, 'widgetId is required for android!');
    assert(widgetLayout != null, 'widgetLayout is required for android!');

    return _methodChannel.invokeMethod<bool>('updateWidget', {
      'androidPackageName': androidPackageName,
      'widgetLayout': widgetLayout,
      'widgetId': widgetId,
      'textViews': textViews,
      'payload': payload,
      'url': url,
    });
  }

  @override
  Future<bool?> widgetExist(int widgetId) {
    return _methodChannel
        .invokeMethod<bool>('widgetExist', {'widgetId': widgetId});
  }
}
