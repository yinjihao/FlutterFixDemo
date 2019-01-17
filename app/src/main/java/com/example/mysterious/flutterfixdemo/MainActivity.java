package com.example.mysterious.flutterfixdemo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FlutterView mFlutterView = Flutter.createView(this, getLifecycle(), "");
        setContentView(mFlutterView);
    }
}
