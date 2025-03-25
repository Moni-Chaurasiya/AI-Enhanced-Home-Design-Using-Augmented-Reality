/* 
package com.interiordesign.visionaryhome;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.media.MediaScannerConnection;
import android.os.Bundle;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.interiordesign.visionaryhome/arcore";

    // This is the MethodChannel for scanning media files (like screenshots)
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("scanMedia")) {
                        String path = call.argument("path");
                        if (path != null) {
                            MediaScannerConnection.scanFile(
                                    this,
                                    new String[]{path}, // Pass path as String array
                                    null,
                                    (path1, uri) -> { // Optional: Callback after scan is complete
                                        // You can add logs or further actions here if needed
                                        result.success("Media scanner notified.");
                                    }
                            );

                        } else {
                            result.error("INVALID_PATH", "Path is null or invalid", null);
                        }
                    }
                   
                    else {
                        result.notImplemented();
                    }
                });
    }

}
*/
package com.interiordesign.visionaryhome;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.media.MediaScannerConnection;
import android.os.Bundle;
import android.content.pm.PackageManager;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import android.Manifest;
import android.util.Log; // Import Log


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.interiordesign.visionaryhome/arcore";
    private static final int STORAGE_PERMISSION_CODE = 24; // Request code

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("MainActivity", "onCreate called"); // Add Log

        // Check and request storage permission directly in MainActivity's onCreate
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            Log.d("MainActivity", "Storage permission NOT granted, requesting..."); // Add Log
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, STORAGE_PERMISSION_CODE);
        } else {
            Log.d("MainActivity", "Storage permission already granted in onCreate."); // Add Log
        }
    }


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("scanMedia")) {
                        String path = call.argument("path");
                        if (path != null) {
                            MediaScannerConnection.scanFile(
                                    this,
                                    new String[]{path}, // Pass path as String array
                                    null,
                                    (path1, uri) -> { // Optional: Callback after scan is complete
                                        // You can add logs or further actions here if needed
                                        result.success("Media scanner notified.");
                                    }
                            );

                        } else {
                            result.error("INVALID_PATH", "Path is null or invalid", null);
                        }
                    }

                    else {
                        result.notImplemented();
                    }
                });
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Log.d("MainActivity", "onRequestPermissionsResult called, requestCode: " + requestCode); // Add Log

        if (requestCode == STORAGE_PERMISSION_CODE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Log.d("MainActivity", "Storage permission GRANTED in onRequestPermissionsResult."); // Add Log
                // Permission granted, you can proceed with storage operations here if needed in Java.
            } else {
                Log.d("MainActivity", "Storage permission DENIED in onRequestPermissionsResult."); // Add Log
                // Permission denied
            }
        }
    }
}