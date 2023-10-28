package com.nagopy.multiplatform.sandbox

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform