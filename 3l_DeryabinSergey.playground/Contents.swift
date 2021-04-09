import UIKit

//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum Actions {
  case startEngine, stopEngine, openWindows, closeWindows
}

enum Engine: String {
  case start = "Engine started"
  case stop = "Engine stopped"
}

enum Windows: String {
  case open = "Windows are open"
  case close = "Windows are closed"
}

struct SportCar {
  let model: String
  let yearOfIssue: Int
  let maxVolume: Double
  var currentVolume: Double
  var freeVolume: Double {
    return maxVolume - currentVolume
  }
  var engineInfo: Engine
  var windowsInfo: Windows
  
  init(model: String, yearOfIssue: Int, maxVolume: Double, engineInfo: Engine, windowsInfo: Windows, currentVolume: Double) {
    self.model = model
    self.yearOfIssue = yearOfIssue
    self.maxVolume = maxVolume
    self.currentVolume = currentVolume
    self.engineInfo = engineInfo
    self.windowsInfo = windowsInfo
    printInfo()
  }
  
  mutating func action(_ action: Actions) {
    switch action {
    case .startEngine:
      engineInfo = Engine.start
    case .stopEngine:
      engineInfo = Engine.stop
    case .openWindows:
      windowsInfo = Windows.open
    case .closeWindows:
      windowsInfo = Windows.close
    }
  }
  
  mutating func addCargo(volume: Double) {
    guard volume > 0 && volume <= freeVolume else { return }
    
    currentVolume += volume
  }
  
  mutating func removeCargo(volume: Double) {
    guard volume > 0 && volume <= currentVolume else { return }
    
    currentVolume -= volume
  }
  
  func printInfo() {
    print("---===INFO===---")
    print("Model: \(self.model)")
    print("Year of issue: \(self.yearOfIssue)")
    print("Max volume: \(self.maxVolume)")
    print("Current volume: \(self.currentVolume)")
    print("\(self.engineInfo.rawValue)")
    print("\(self.windowsInfo.rawValue)")
  }
}

struct TrunkCar {
  let model: String
  let yearOfIssue: Int
  let maxVolume: Double
  var currentVolume: Double
  var freeVolume: Double {
    return maxVolume - currentVolume
  }
  var engineInfo: Engine
  var windowsInfo: Windows
  
  init(model: String, yearOfIssue: Int, maxVolume: Double, engineInfo: Engine, windowsInfo: Windows, currentVolume: Double) {
    self.model = model
    self.yearOfIssue = yearOfIssue
    self.maxVolume = maxVolume
    self.currentVolume = currentVolume
    self.engineInfo = engineInfo
    self.windowsInfo = windowsInfo
    printInfo()
  }
  
  mutating func action(_ action: Actions) {
    switch action {
    case .startEngine:
      engineInfo = Engine.start
    case .stopEngine:
      engineInfo = Engine.stop
    case .openWindows:
      windowsInfo = Windows.open
    case .closeWindows:
      windowsInfo = Windows.close
    }
  }
  
  mutating func addCargo(volume: Double) {
    guard volume > 0 && volume <= freeVolume else { return }

    currentVolume += volume
  }

  mutating func removeCargo(volume: Double) {
    guard volume > 0 && volume <= currentVolume else { return }

    currentVolume -= volume
  }
  
  func printInfo() {
    print("---===INFO===---")
    print("Model: \(self.model)")
    print("Year of issue: \(self.yearOfIssue)")
    print("Max volume: \(self.maxVolume)")
    print("Current volume: \(self.currentVolume)")
    print("\(self.engineInfo.rawValue)")
    print("\(self.windowsInfo.rawValue)")
  }
}

var trunkCar = SportCar.init(model: "BMW", yearOfIssue: 2020, maxVolume: 1250, engineInfo: .stop, windowsInfo: .close, currentVolume: 150)
var sportCar = TrunkCar.init(model: "UAZ", yearOfIssue: 2000, maxVolume: 5000, engineInfo: .start, windowsInfo: .open, currentVolume: 1000)

trunkCar.addCargo(volume: 124)
trunkCar.currentVolume
trunkCar.maxVolume
trunkCar.action(.openWindows)
trunkCar.windowsInfo
trunkCar.action(.closeWindows)
trunkCar.windowsInfo
sportCar.currentVolume
sportCar.freeVolume
sportCar.removeCargo(volume: 333)
sportCar.currentVolume
sportCar.action(.startEngine)
sportCar.engineInfo
sportCar.action(.stopEngine)
sportCar.engineInfo
