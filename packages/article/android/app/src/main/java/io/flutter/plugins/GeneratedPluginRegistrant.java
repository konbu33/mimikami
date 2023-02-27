package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.tundralabs.fluttertts.FlutterTtsPlugin;
import com.kasem.receive_sharing_intent.ReceiveSharingIntentPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterTtsPlugin.registerWith(registry.registrarFor("com.tundralabs.fluttertts.FlutterTtsPlugin"));
    ReceiveSharingIntentPlugin.registerWith(registry.registrarFor("com.kasem.receive_sharing_intent.ReceiveSharingIntentPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
