package com.nagopy.multiplatform.sandbox

import androidx.compose.ui.window.ComposeUIViewController
import platform.UIKit.UIDevice

class IOSPlatform: Platform {
    override val name: String = UIDevice.currentDevice.systemName() + " " + UIDevice.currentDevice.systemVersion
}

actual fun getPlatform(): Platform = IOSPlatform()

@Suppress("unused", "FunctionName")
fun HorizontalScrollRowViewController() = ComposeUIViewController { HorizontalScrollRow() }

