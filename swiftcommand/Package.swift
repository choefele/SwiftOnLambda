import PackageDescription

let package = Package(
  name: "swiftcommand",
  dependencies:[
    .Package(url: "https://github.com/choefele/AlexaSkillsKit", majorVersion: 0)
  ],
  exclude: ["LinuxLibraries","TestData","Resources"]
)


