## Magic move

````md magic-move
```kotlin
fun hello(): String {
}
```
```kotlin
fun hello(): String {
    return "Hello, World!"
}
```
````

## Highlighting Error

```kotlin {2}
fun hello(who: String?): String {
🚫  val upper: String = who?.uppercase()
    return "Hello, $upper!"
}
```
