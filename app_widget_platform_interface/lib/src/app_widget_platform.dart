import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AppWidgetPlatform extends PlatformInterface {
  /// Constructs a AppWidgetPlatform.
  AppWidgetPlatform() : super(token: _token);

  static final Object _token = Object();

  // static late AppWidgetPlatform _instance = MethodChannelAppWidget();
  // static AppWidgetPlatform _instance = MethodChannelAppWidget();
  static late AppWidgetPlatform _instance;

  /// The default instance of [AppWidgetPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppWidget].
  static AppWidgetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppWidgetPlatform] when
  /// they register themselves.
  static set instance(AppWidgetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  static const channel = 'tech.noxasch.flutter/app_widget_foreground';

  Future<bool?> cancelConfigureWidget() {
    throw UnimplementedError();
  }

  // the params are not require in base interface as different platform will require differet parameters
  // we handle this in platform specific and plugin interface
  Future<bool?> configureWidget({
    String? androidPackageName,
    int? widgetId,
    String? widgetLayout,
    Map<String, String>? textViews,
    String? payload,
    String? url,
  }) async {
    throw UnimplementedError();
  }

  Future<bool?> reloadWidgets({
    String? androidPackageName,
    String? androidProviderName,
  }) async {
    throw UnimplementedError();
  }

  Future<bool?> updateWidget({
    String? androidPackageName,
    int? widgetId,
    String? widgetLayout,
    Map<String, String>? textViews,
    String? payload,
    Map<String, String>? url,
  }) async {
    throw UnimplementedError();
  }

  /// get all widgets ids associated with the given provider
  /// will throw an error if the provider doesn't exist
  Future<List<int>?> getWidgetIds({
    String? androidPackageName,
    String? androidProviderName,
  }) async {
    throw UnimplementedError();
  }

  Future<bool?> widgetExist(int widgetId) async {
    throw UnimplementedError();
  }
}
