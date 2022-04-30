# AirQualityMonitoring
Here display the live air quality monitoring data.

## Details

### Development Tools
- Xcode 12.4

### iOS Deployment Target
- 14.4

## Installation
- Open the terminal and go to the project folder using cd command.
- Enter the command pod install.
- Open the AirQualityMonitoring.xcworkspace file.

## Architecture
- Used VIPER Architecture.
- https://github.com/TheNiks/AirQualityMonitoring/blob/d3a1a04011ca9a9ae1a7ebb80e8411e3be2bae88/VIPER.png

## Storage
- CoreData

## Folder Structure
- https://github.com/TheNiks/AirQualityMonitoring/blob/bd72124ce314355f5bb0b49d40c914b1cbaa58d2/FolderStructure.png

### Third Party Library
- Websocket => https://github.com/daltoniam/Starscream
- Graphs => https://github.com/danielgindi/Charts

## Screens
- Air Quality Index List

![AirQualityMonitorList](https://github.com/TheNiks/AirQualityMonitoring/blob/e5812c84b8b4c00df5a1a8a4efbd5b0fc76a34a3/AQMList.gif)

- Air Quality Index value range its color info

![Popup](https://github.com/TheNiks/AirQualityMonitoring/blob/b330c1cf8040a68a511eadfdff15e21b41b2cc77/PopupGuide.png)

- Realtime Graph

![RealTimeGraph](https://github.com/TheNiks/AirQualityMonitoring/blob/e5812c84b8b4c00df5a1a8a4efbd5b0fc76a34a3/AQMGraph.gif)

## Tests
- Added Unit and UI Tests using XCTest.

