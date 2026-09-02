# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Payment Gateways General Keep Rules
# These rules ensure that the payment SDKs are not broken by obfuscation
# Stripe
-keep class com.stripe.android.** { *; }
-keep interface com.stripe.android.** { *; }
-dontwarn com.stripe.android.**

# Razorpay
-keep class com.razorpay.* {}
-dontwarn com.razorpay.**
-keepclasseswithmembers class * {
    public void onPayment*(...);
}

# PayU
-keep class com.payu.** { *; }
-dontwarn com.payu.**

# Braintree
-keep class com.braintreepayments.api.** { *; }
-dontwarn com.braintreepayments.api.**

# Basic Obfuscation Enhancements for Security
# These rename packages and allow access modifications for better obfuscation
-repackageclasses ''
-allowaccessmodification
-optimizations !code/simplification/arithmetic,!field/,!class/merging/

# Keep standard Android classes
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Ignore missing Google Play Core classes (used by Flutter deferred components)
-dontwarn com.google.android.play.core.**

# Ignore missing classes related to payment gateways / e-sign
-dontwarn com.nsdl.egov.esignaar.**
-dontwarn com.weipl.checkout.**
-keep class com.weipl.checkout.** { *; }
-keep interface com.weipl.checkout.** { *; }