# AquaEcho

AquaEcho is a revolutionary sound-based navigation system designed to assist visually impaired and competitive swimmers with real-time lane guidance using haptic feedback (Apple Watch) and spatial audio cues (AirPods).

## Features

- 🏊‍♂️ Real-time lane position tracking using CoreMotion
- 🎧 Spatial audio feedback via AirPods
- ⌚️ Haptic feedback through Apple Watch
- 🤖 AI-powered lap detection
- ❤️ HealthKit integration for swim analytics
- 📊 Detailed swimming statistics and progress tracking
- 🎯 Goal setting and achievement system
- 🔐 Secure authentication with Sign in with Apple
- 🌙 Dark mode support
- 🔄 Automatic session syncing

## Requirements

- iOS 16.0+
- watchOS 9.0+
- Xcode 14.0+
- Swift 5.7+
- AirPods Pro (recommended for spatial audio)
- Apple Watch Series 4 or later

## Installation

### Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/aquaecho.git
   ```

2. Open the project in Xcode:
   ```bash
   cd aquaecho
   open AquaEcho.swiftpm
   ```

3. Configure signing capabilities in Xcode:
   - Select the project in the navigator
   - Select the target
   - Go to the Signing & Capabilities tab
   - Add your development team

4. Install development dependencies:
   - Xcode Command Line Tools
   - Swift Package Manager dependencies will be installed automatically

### Running the Project

1. Select your target device (iPhone or Simulator)
2. Build and run the project (⌘R)
3. Grant required permissions when prompted:
   - HealthKit access
   - Motion & Fitness access
   - Notification permissions

## Usage

1. **Initial Setup**
   - Sign in with your Apple ID
   - Complete the onboarding process
   - Set your pool length and preferences

2. **Before Swimming**
   - Connect your AirPods
   - Ensure your Apple Watch is paired
   - Calibrate the system using the calibration wizard

3. **During Swimming**
   - Start a new swimming session
   - Receive real-time audio and haptic feedback
   - System automatically tracks laps and position

4. **After Swimming**
   - Review your session statistics
   - Check your achievements
   - View your progress in the Health app

## Architecture

AquaEcho follows the MVVM (Model-View-ViewModel) architecture pattern and uses SwiftUI for the user interface.

### Core Components

- **MotionManager**: Handles device motion tracking
- **AudioFeedback**: Manages spatial audio cues
- **HapticFeedback**: Controls Apple Watch haptics
- **HealthKitManager**: Manages health data integration
- **LapDetection**: Processes motion data for lap counting
- **AuthenticationManager**: Handles user authentication
- **SettingsManager**: Manages user preferences

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Privacy

AquaEcho takes user privacy seriously:
- All data is stored locally or in HealthKit
- Authentication uses Sign in with Apple
- No third-party analytics
- No data sharing without explicit consent

## Support

For support, please:
1. Check the [Documentation](docs/README.md)
2. Search [Issues](https://github.com/yourusername/aquaecho/issues)
3. Create a new issue if needed

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Apple for SwiftUI, HealthKit, and CoreMotion frameworks
- The swimming community for valuable feedback
- All contributors who have helped shape this project