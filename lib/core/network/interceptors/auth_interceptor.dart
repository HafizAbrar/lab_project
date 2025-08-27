import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final FlutterSecureStorage _storage;
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await _storage.read(key: _accessTokenKey);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        print('✅ Auth token added to ${options.method} ${options.path}');
      } else {
        print('⚠️ No auth token found for ${options.method} ${options.path}');
      }
      handler.next(options); // ✅ only continue after token is checked
    } catch (e) {
      print('❌ Error reading auth token: $e');
      handler.next(options); // still continue the request
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('❌ Request failed: ${err.response?.statusCode} ${err.requestOptions.path}');

    if (err.response?.statusCode == 401) {
      print('🔄 Attempting token refresh...');

      try {
        final refreshToken = await _storage.read(key: _refreshTokenKey);
        if (refreshToken == null) {
          print('❌ No refresh token available');
          await _clearTokens();
          return handler.next(err);
        }

        // Use a temporary Dio only for refresh
        final refreshDio = Dio(BaseOptions(baseUrl: err.requestOptions.baseUrl));
        final response = await refreshDio.post(
          '/auth/refresh',
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          final data = response.data['data'];
          final newAccessToken = data['accessToken'] as String?;
          final newRefreshToken = data['refreshToken'] as String?;

          if (newAccessToken != null) {
            await _storage.write(key: _accessTokenKey, value: newAccessToken);
            print('✅ New access token stored');
          }
          if (newRefreshToken != null) {
            await _storage.write(key: _refreshTokenKey, value: newRefreshToken);
            print('✅ New refresh token stored');
          }

          // Retry the original request with updated token
          if (newAccessToken != null) {
            final cloneReq = await _retryRequest(err.requestOptions, newAccessToken);
            return handler.resolve(cloneReq);
          }
        }
      } catch (refreshError) {
        print('❌ Token refresh failed: $refreshError');
        await _clearTokens();
      }
    }

    handler.next(err);
  }
  Future<void> printStoredToken() async {
    String? token = await _storage.read(key: 'access_token');
    if (token != null) {
      print("🔑 Stored Access Token: $token");
    } else {
      print("⚠️ No access_token found in storage!");
    }
  }
  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions, String token) async {
    final dio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
    requestOptions.headers['Authorization'] = 'Bearer $token';
    return dio.fetch(requestOptions);
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    print('🗑️ Tokens cleared');
  }
}

