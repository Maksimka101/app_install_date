# App Install Date

A flutter plugin that helps to get date of the app installation

How to use:
```dart
late String installDate;
// Platform messages may fail, so we use a try/catch 
try {
    final date = await AppInstallDate().installDate;
    installDate = date.toString();
} catch (e, st) {
    installDate = 'Failed to load install date';
}
```

## How it works
### Android
On android it is using the `PackageManager` to get install date from the package info

### IOS and MacOS
On these platforms it is using application document directory's creation date. This method is also used in [native development](https://stackoverflow.com/questions/4090512/how-to-determine-the-date-an-app-is-installed-or-used-for-the-first-time) 
