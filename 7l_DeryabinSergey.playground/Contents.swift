import UIKit

//Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.


enum Colors: String {
  case blackNWhite = "чёрный/белый"
  case colored = "разноцветный"
  case customTest = "тестовый режим"
}

enum PrinterError: Error {
  case paperOut(paperNeeded: Int)
  case wrongColor(String)
  case noElectricity(String)
}

// MARK: первый вариант

class Printer1 {
  
  var paperCount: Int
  var electricity: Bool
  var color: Colors
  
  init(paperCount: Int, electricity: Bool, color: Colors) {
    self.paperCount = paperCount
    self.electricity = electricity
    self.color = color
  }
  
  func addPaper(by value: Int) {
    paperCount += value
  }
  
  func printSome(pages: Int, with color: Colors) -> (String?, PrinterError?) {
    guard pages <= paperCount else { return (nil, PrinterError.paperOut(paperNeeded: pages - paperCount)) }
    
    guard electricity == true else { return (nil, PrinterError.noElectricity("2")) }
    
    guard color == .blackNWhite || color == .colored else { return (nil, PrinterError.wrongColor("3")) }
    
    paperCount -= pages
    let info = """
    Распечатано \(pages) страниц с цветами: \(color.rawValue)
    Осталось страниц в принтере - \(paperCount)
    """
    
    return (info, nil)
  }
}

let printerUse1 = Printer1(paperCount: 100, electricity: true, color: .customTest)

let printTest = printerUse1.printSome(pages: 101, with: .colored)

if let successPrint = printTest.0 {
  print(successPrint)
} else if let error = printTest.1 {
  print(error.localizedDescription)
}


// MARK: второй вариант

class Printer {

  var paperCount: Int
  var electricity: Bool
  var color: Colors

  init(paperCount: Int, electricity: Bool, color: Colors) {
    self.paperCount = paperCount
    self.electricity = electricity
    self.color = color
  }

  func addPaper(by value: Int) {
    paperCount += value
  }

  func printSome(pages: Int, with color: Colors) throws -> String {
    guard pages <= paperCount else {
      throw PrinterError.paperOut(paperNeeded: pages - paperCount)
    }

    guard electricity == true else {
      throw PrinterError.noElectricity("No electricity")
    }

    guard color == .blackNWhite || color == .colored else {
      throw PrinterError.wrongColor("Wrong color")
    }

    paperCount -= pages
    let info = "Распечатано \(pages) страниц с цветами: \(color.rawValue)\nОсталось страниц в принтере - \(paperCount)"

    return info
  }
}

var printerUse = Printer(paperCount: 10, electricity: true, color: .colored)

do {
  _ = try printerUse.printSome(pages: 100, with: .colored)
} catch PrinterError.paperOut(let paperNeeded) {
  print("Need paper: \(paperNeeded)")
} catch PrinterError.noElectricity {
  print("No electricity")
} catch PrinterError.wrongColor {
  print("Wrong color")
} catch let error {
  print(error.localizedDescription)
}
