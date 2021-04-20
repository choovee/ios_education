import UIKit

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

enum Engine: String {
  case start = "Engine started", stop = "Engine stopped"
}

enum Windows: String {
  case open = "Windows are open", close = "Windows are closed"
}

enum Wheels: String {
  case toDefault = "Standart tire pressure", pumpUp = "Increased tire pressure", blowOff = "Low tire pressure"
}

enum SportMode: String {
  case on = "Sport mode activated", off = "Sport mode deactivated"
}


protocol CarProtocol: class, CustomStringConvertible {
  var model: String { get }
  var yearOfIssue: Int { get }
  var color: String { get set }
  var engineVolume: Double { get set }
  var engineInfo: Engine { get set }
  var windowsInfo: Windows { get set }
  var tirePressure: Wheels { get set }
  
}

extension CarProtocol {
  func startEngine() {
    engineInfo = .start
  }
  
  func stopEngine() {
    engineInfo = .stop
  }
  
  func openWindows() {
    windowsInfo = .open
  }
  
  func closeWindows() {
    windowsInfo = .close
  }
}

extension CarProtocol {
  func changeTirePressure(to value: Wheels) {
    switch value {
    case .pumpUp:
      self.tirePressure = .pumpUp
    case .blowOff:
      self.tirePressure = .blowOff
    case .toDefault:
      self.tirePressure = .toDefault
    }
  }
  
  func changeColor(to newColor: String) {
    color = newColor
  }

  func printInfo() {
    print(description)
  }
}


class TrunkCar: CarProtocol {
  let model: String
  let yearOfIssue: Int
  var color: String
  var engineVolume: Double
  var engineInfo: Engine
  var windowsInfo: Windows
  var tirePressure: Wheels
  let wheelsAmount: Int
  
  let maxVolume: Double
  var currentVolume: Double
  var freeVolume: Double {
    return maxVolume - currentVolume
  }
  
  init(model: String, yearOfIssue: Int, color: String, engineVolume: Double, engineInfo: Engine,
       windowsInfo: Windows, tirePressure: Wheels, wheelsAmount: Int, maxVolume: Double, currentVolume: Double) {
    self.model = model
    self.yearOfIssue = yearOfIssue
    self.color = color
    self.engineVolume = engineVolume
    self.engineInfo = engineInfo
    self.windowsInfo = windowsInfo
    self.tirePressure = tirePressure
    self.wheelsAmount = wheelsAmount
    self.maxVolume = maxVolume
    self.currentVolume = currentVolume
  }
  
  func addCargo(volume: Double) {
    guard volume > 0 && volume <= freeVolume else { return }
    
    currentVolume += volume
  }
  
  func removeCargo(volume: Double) {
    guard volume > 0 && volume <= currentVolume else { return }
    
    currentVolume -= volume
  }
}

extension TrunkCar: CustomStringConvertible {
  var description: String {
    return """
    ---===INFO===---
    Model: \(model)
    Year of issue: \(yearOfIssue)
    Color: \(color)
    Wheels amount: \(wheelsAmount)
    Max cargo volume: \(maxVolume)
    Current cargo volume: \(currentVolume)
    \(engineInfo.rawValue)
    \(windowsInfo.rawValue)
    Engine volume: \(engineVolume)
    \(tirePressure.rawValue)
    """
  }
}

class SportCar: CarProtocol {
  let model: String
  let yearOfIssue: Int
  var color: String
  var engineVolume: Double
  var engineInfo: Engine
  var windowsInfo: Windows
  var tirePressure: Wheels
  let maxSpeed: Double
  var currentSpeed: Double? = 0
  var sportMode: SportMode

  init(model: String, yearOfIssue: Int, color: String, engineVolume: Double, engineInfo: Engine,
       windowsInfo: Windows, tirePressure: Wheels, maxSpeed: Double, sportMode: SportMode) {
    self.model = model
    self.yearOfIssue = yearOfIssue
    self.color = color
    self.engineVolume = engineVolume
    self.engineInfo = engineInfo
    self.windowsInfo = windowsInfo
    self.tirePressure = tirePressure
    self.maxSpeed = maxSpeed
    self.sportMode = sportMode
  }
  
  func changeSportMode(to value: SportMode) {
    switch value {
    case .on:
      self.sportMode = .on
    case .off:
      self.sportMode = .off
    }
  }
  
  func correctSpeed(to value: Double) {
    guard value >= 0 && engineInfo == .start else { fatalError("Turn on engine") }
    
    currentSpeed = value
  }
}

extension SportCar: CustomStringConvertible {
  var description: String {
    return """
    ---===INFO===---
    Model: \(model)
    Year of issue: \(yearOfIssue)
    Color: \(color)
    \(engineInfo.rawValue)
    \(windowsInfo.rawValue)
    Engine volume: \(engineVolume)
    \(tirePressure.rawValue)
    Max speed: \(maxSpeed)
    \(sportMode.rawValue)
    """
  }
}

var trunkCar = TrunkCar(model: "UAZ", yearOfIssue: 2015, color: "black", engineVolume: 12, engineInfo: .stop, windowsInfo: .close, tirePressure: .toDefault, wheelsAmount: 8, maxVolume: 25000, currentVolume: 5200)
trunkCar.changeColor(to: "white")
trunkCar.color
trunkCar.changeTirePressure(to: .pumpUp)
trunkCar.tirePressure
trunkCar.freeVolume
trunkCar.addCargo(volume: 350)
print(trunkCar)


var sportCar = SportCar(model: "BMW", yearOfIssue: 2020, color: "black", engineVolume: 6.0, engineInfo: .stop, windowsInfo: .close, tirePressure: .toDefault, maxSpeed: 315, sportMode: .off)
sportCar.changeSportMode(to: .on)
sportCar.engineInfo = .start
sportCar.correctSpeed(to: 120)
sportCar.currentSpeed
print(sportCar)
