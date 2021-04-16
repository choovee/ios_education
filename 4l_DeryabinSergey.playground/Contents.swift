import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum Actions {
  case startEngine, stopEngine, openWindows, closeWindows,
       sportModeOn, sportModeOff, pumpWheels, blowOffWheels
}

enum Wheels: String {
  case pumpUp = "Increased tire pressure"
  case blowOff = "Low tire pressure"
}

enum SportMode: String {
  case on = "Sport mode activated"
  case off = "Sport mode deactivated"
}

enum Engine: String {
  case start = "Engine started"
  case stop = "Engine stopped"
}

enum Windows: String {
  case open = "Windows are open"
  case close = "Windows are closed"
}

class Car {
  var model: String
  let yearOfIssue: Int
  let color: String
  let engineVolume: Double
  var engineInfo: Engine
  var windowsInfo: Windows
  
  init(model: String, yearOfIssue: Int, color: String, engineVolume: Double, engineInfo: Engine, windowsInfo: Windows) {
    self.model = model
    self.yearOfIssue = yearOfIssue
    self.color = color
    self.engineVolume = engineVolume
    self.engineInfo = engineInfo
    self.windowsInfo = windowsInfo
  }
  
  func action(_ action: Actions) {
    switch action {
    case .startEngine:
    engineInfo = Engine.start
    case .stopEngine:
    engineInfo = Engine.stop
    case .openWindows:
    windowsInfo = Windows.open
    case .closeWindows:
    windowsInfo = Windows.close
    default:
      return
    }
  }
  
  func printInfo() {
    print("---===INFO===---")
    print("Model: \(self.model)")
    print("Year of issue: \(self.yearOfIssue)")
    print("Color: \(self.color)")
    print("\(self.engineInfo.rawValue)")
    print("\(self.windowsInfo.rawValue)")
    print("Engine volume: \(self.engineVolume)")
  }
}

class TrunkCar: Car {
  let numberOfWheels: Int
  let height: Double
  let maxVolume: Double
  var currentVolume: Double
  var freeVolume: Double {
    return maxVolume - currentVolume
  }
  var tirePressure: Wheels
  
  init(model: String, yearOfIssue: Int, color: String, engineVolume: Double,
       engineInfo: Engine, windowsInfo: Windows,numberOfWheels: Int,
       height: Double, maxVolume: Double, currentVolume: Double, tirePressure: Wheels) {
    
    self.numberOfWheels = numberOfWheels
    self.height = height
    self.maxVolume = maxVolume
    self.currentVolume = currentVolume
    self.tirePressure = tirePressure
    
    super.init(model: model, yearOfIssue: yearOfIssue, color: color, engineVolume: engineVolume,
               engineInfo: engineInfo, windowsInfo: windowsInfo)
  }
  
  override func action(_ action: Actions) {
    switch action {
    case .pumpWheels:
      tirePressure = Wheels.pumpUp
    case .blowOffWheels:
      tirePressure = Wheels.blowOff
    default:
      return
    }
  }
  
  func addCargo(volume: Double) {
    guard volume > 0 && volume <= freeVolume else { return }
    
    currentVolume += volume
  }
  
  func removeCargo(volume: Double) {
    guard volume > 0 && volume <= currentVolume else { return }
    
    currentVolume -= volume
  }
  
  override func printInfo() {
    super.printInfo()
    print("Height: \(self.height)")
    print("Max cargo volume: \(self.maxVolume)")
    print("Current cargo volume: \(self.currentVolume)")
    print("Current tire pressure: \(self.tirePressure.rawValue)")
    print("")
  }
}

class SportCar: Car {
  let maxSpeed: Double
  var currentSpeed: Double? = 0
  let sizeOfWheels: Int
  var sportMode: SportMode
  
  init(model: String, yearOfIssue: Int, color: String, engineVolume: Double, engineInfo: Engine,
       windowsInfo: Windows, maxSpeed: Double, sizeOfWheels: Int, sportMode: SportMode) {
    self.maxSpeed = maxSpeed
    self.sizeOfWheels = sizeOfWheels
    self.sportMode = sportMode
    
    super.init(model: model, yearOfIssue: yearOfIssue, color: color, engineVolume: engineVolume,
               engineInfo: engineInfo, windowsInfo: windowsInfo)
  }
  
  override func action(_ action: Actions) {
    switch action {
    case .sportModeOn:
      sportMode = SportMode.on
    case .sportModeOff:
      sportMode = SportMode.off
    default:
      return
    }
  }
  
  func correctSpeed(to value: Double) {
    guard value >= 0 && engineInfo == .start else { fatalError("Turn on engine") }
    
    currentSpeed = value
  }
  
  override func printInfo() {
    super.printInfo()
    print("Max speed: \(self.maxSpeed)")
    print("Size of wheels: \(self.sizeOfWheels)")
    print("\(self.sportMode.rawValue)")
    print("")
  }
}

var trunkCar = TrunkCar(model: "UAZ", yearOfIssue: 2000, color: "Black", engineVolume: 12, engineInfo: .stop,
                    windowsInfo: .close, numberOfWheels: 8, height: 3, maxVolume: 20000, currentVolume: 5000, tirePressure: .pumpUp)

var sportCar = SportCar(model: "BMW", yearOfIssue: 1950, color: "White", engineVolume: 6, engineInfo: .start,
                        windowsInfo: .open, maxSpeed: 250, sizeOfWheels: 16, sportMode: .on)

trunkCar.addCargo(volume: 140)
trunkCar.currentVolume
trunkCar.numberOfWheels
trunkCar.action(.blowOffWheels)
trunkCar.tirePressure


sportCar.correctSpeed(to: 150)
sportCar.currentSpeed
sportCar.action(.sportModeOff)
sportCar.sportMode


trunkCar.printInfo()
sportCar.printInfo()

