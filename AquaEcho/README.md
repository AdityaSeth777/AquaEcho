# AquaEcho - Smart Swimming Assistant

AquaEcho is a revolutionary iOS application designed to assist visually impaired and competitive swimmers with real-time lane guidance using haptic feedback and spatial audio cues.

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 16.0 or later
- macOS Ventura or later
- Apple Developer Account (for testing on physical devices and App Store deployment)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/AdityaSeth777/AquaEcho.git
   ```

2. Open the project:
   - Navigate to the project directory
   - Double-click `AquaEcho.swiftpm` or open it through Xcode
   - Alternatively, use `xed .` in the terminal from the project directory

3. Configure Development Team:
   - In Xcode, select the project in the navigator
   - Select the AquaEcho target
   - Under Signing & Capabilities:
     - Select your development team
     - Bundle identifier will be automatically updated

4. Build and Run:
   - Select your target device (iOS 16.0+ required)
   - Click the Run button (⌘R) or select Product > Run

### Required Device Capabilities

- iPhone with iOS 16.0+
- Apple Watch (optional, for haptic feedback)
- AirPods Pro/Max (recommended for spatial audio)

## 🛠 Development Setup

### Project Structure

```
AquaEcho.swiftpm/
├── Package.swift           # Swift Package manifest
├── Sources/
│   ├── AquaEchoApp.swift  # Main app entry point
│   ├── Views/             # SwiftUI views
│   ├── Models/            # Data models
│   ├── Managers/          # Business logic
│   └── Components/        # Reusable UI components
```

### Key Features

- 🏊‍♂️ Real-time lane position tracking
- 🎧 Spatial audio feedback
- ⌚️ Haptic feedback
- 📊 Swimming analytics
- 🔐 Sign in with Apple
- ❤️ HealthKit integration

### Configuration

1. **HealthKit Capabilities:**
   - Enable HealthKit in Signing & Capabilities
   - Add required privacy descriptions in Info.plist

2. **Sign in with Apple:**
   - Enable Sign in with Apple capability
   - Configure your Apple Developer account

3. **Audio Session:**
   - Background audio must be enabled
   - Add required privacy descriptions for microphone usage

## 📱 Testing

### Simulator Testing

1. Select an iOS Simulator (iPhone 14 or newer recommended)
2. Some features like HealthKit may have limited functionality
3. Use the Simulator's Debug menu to simulate location and motion

### Physical Device Testing

1. Connect your iOS device
2. Trust your development certificate
3. Select your device in Xcode
4. Build and run (⌘R)

### Common Issues

1. **Preview Issues:**
   - Ensure you're using Xcode 15+
   - Clean build folder (⇧⌘K)
   - Delete derived data

2. **Build Errors:**
   - Update to latest Xcode
   - Clean build folder
   - Re-clone repository if needed

3. **Runtime Errors:**
   - Check iOS version compatibility
   - Verify all required capabilities are enabled
   - Check privacy descriptions in Info.plist

## 📦 Deployment

### TestFlight

1. Configure App Store Connect
2. Create an app record
3. Upload build through Xcode
4. Add test information
5. Invite testers

### App Store

1. Complete App Store Connect setup
2. Add required metadata
3. Submit for review
4. Monitor status in App Store Connect

## 🔒 Privacy & Security

- All data stored locally or in HealthKit
- Sign in with Apple for authentication
- No third-party analytics
- GDPR and CCPA compliant

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📞 Support

For support:
1. Check documentation
2. Open an issue
3. Contact support@aquaecho.com
