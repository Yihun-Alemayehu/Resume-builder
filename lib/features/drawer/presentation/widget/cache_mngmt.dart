import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  // Clear all cache (temporary files, network cache, optional SharedPreferences)
  static Future<bool> clearCache({bool clearPreferences = false}) async {
    try {
      // Clear temporary directory
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }

      // Clear application cache directory
      final cacheDir = await getApplicationCacheDirectory();
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }

      // Clear network cache (if using flutter_cache_manager)
      await DefaultCacheManager().emptyCache();

      // Optionally clear non-critical SharedPreferences
      if (clearPreferences) {
        final prefs = await SharedPreferences.getInstance();
        // Only clear non-critical keys, preserve user data
        final keysToRemove = prefs.getKeys().where((key) => key != 'walkthrough_completed' && key != 'exportFormat' && key != 'notificationsEnabled');
        for (final key in keysToRemove) {
          await prefs.remove(key);
        }
      }

      return true;
    } catch (e) {
      print('Error clearing cache: $e');
      return false;
    }
  }
}