import 'package:common/src/localization/localization_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware localizationMiddleware() {
  return (handler) {
    return (context) {
      // Extract locale from Accept-Language header
      final acceptLanguage = context.request.headers['accept-language'];
      final locale = LocalizationService.parseLocale(acceptLanguage);

      // Create localization service with the detected locale
      final localizationService = LocalizationService(locale: locale);

      // Inject the service into the context
      return handler(
        context.provide<LocalizationService>(() => localizationService),
      );
    };
  };
}
