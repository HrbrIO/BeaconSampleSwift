# BeaconSampleSwift
Sample iOS Swift application to send Harbor Beacons.

## Deployment

Add your organization API Key to the  [BeaconSampleSwift/Info.plist](BeaconSampleSwift/Info.plist) file in your Xcode Project

```
<key>Harbor</key>
<dict>
<key>APIKey</key>
<string>YOUR_ORGANIZATION API_KEY_GOES_HERE</string>
</dict>
```

Set the APP_ID and BEACON_ID in [BeaconSampleSwift/HarborLogger.swift](BeaconSampleSwift/HarborLogger.swift)

```
// From your Harbor acount page
// App Version ID
let APP_ID    = "io.hrbr.samples.halfwaterglass:1.0.0"

// Beacon Version ID
let BEACON_ID = "io.hrbr.iosswift:0.9.0"
```

## License

This project is licensed under the Apache License, Version 2.0 - see the [LICENSE](LICENSE) file for details
