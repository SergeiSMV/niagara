# Правила proguard позволяют избежать удаления зависимостей для YooKassa,
# которые вырезаются R8 при сборке приложения в релизном режиме.
-dontwarn com.google.api.client.http.GenericUrl
-dontwarn com.google.api.client.http.HttpHeaders
-dontwarn com.google.api.client.http.HttpRequest
-dontwarn com.google.api.client.http.HttpRequestFactory
-dontwarn com.google.api.client.http.HttpResponse
-dontwarn com.google.api.client.http.HttpTransport
-dontwarn com.google.api.client.http.javanet.NetHttpTransport$Builder
-dontwarn com.google.api.client.http.javanet.NetHttpTransport
-dontwarn com.vk.api.sdk.VK
-dontwarn kotlinx.parcelize.Parceler$DefaultImpls
-dontwarn kotlinx.parcelize.Parceler
-dontwarn kotlinx.parcelize.Parcelize
-dontwarn org.joda.time.Instant

-keep class com.jivosite.sdk.** { *; }
-keep class androidx.lifecycle.LiveData { *; }

-keep,allowobfuscation,allowshrinking interface retrofit2.Call
-keep,allowobfuscation,allowshrinking class retrofit2.Response

-keep,allowobfuscation,allowshrinking class com.jivosite.sdk.model.** { *; }
-keep,allowobfuscation,allowshrinking class com.jivosite.sdk.network.** { *; }
