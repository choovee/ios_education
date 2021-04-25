import UIKit

/*
1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
3. Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
*/

protocol HeightNWeight: class {
  var height: Double { get }
  var weight: Double { get }
}

class Man: HeightNWeight {
  let name: String
  let age: Int
  var height: Double
  var weight: Double
  
  init(name: String, age: Int, height: Double, weight: Double) {
    self.name = name
    self.age = age
    self.height = height
    self.weight = weight
  }
}

extension Man: CustomStringConvertible {
  var description: String {
    return """
    Name: \(self.name) Age: \(self.age) Height: \(self.height) Weight: \(self.weight)
    """
  }
}


class Woman: HeightNWeight {
  let name: String
  let age: Int
  var height: Double
  var weight: Double
  
  init(name: String, age: Int, height: Double, weight: Double) {
    self.name = name
    self.age = age
    self.height = height
    self.weight = weight
  }
}

extension Woman: CustomStringConvertible {
  var description: String {
    return """
    Name: \(self.name) Age: \(self.age) Height: \(self.height) Weight: \(self.weight)
    """
  }
}


struct Queue<T: HeightNWeight> {
  
  private var elements = [T]()
  
  mutating func push(_ element: T) {
    elements.append(element)
  }
  
  mutating func pop() -> T? {
    guard elements.count > 0 else { return nil }
    
    return elements.removeFirst()
  }
  
  func filter(prediction: (T) -> Bool) -> [T] {
    var array = [T]()
    
    for element in elements {
      if prediction(element) {
        array.append(element)
      }
    }
    return array
  }
  
  mutating func sort(prediction: (T, T) -> Bool) -> [T] {
    for i in 0..<elements.count {
      let index = (elements.count - 1) - i

      for j in 0..<index {
        let firstElement = elements[j]
        let secondElement = elements[j + 1]

        if prediction(firstElement, secondElement) {
          elements[j] = secondElement
          elements[j + 1] = firstElement
        }
      }
    }
    return elements
  }
}

extension Queue {
  
  subscript(index: Int) -> String? {
    guard index < elements.count && index >= 0 else { return nil }
    
    let some = elements[index]
    return "Height: \(some.height), Weight:\(some.weight)"
  }
  
  subscript(indexes: Int ...) -> String? {
    var totalWeight = 0.0
    
    for index in indexes where index < elements.count && index >= 0 {
      totalWeight += elements[index].weight
    }
    
    return "Total weight: \(totalWeight)"
  }
}


var manStack = Queue<Man>()
var womanStack = Queue<Woman>()

manStack.push(Man(name: "Bro", age: 25, height: 178, weight: 65))
manStack.push(Man(name: "Chovie", age: 39, height: 195, weight: 110))
manStack.push(Man(name: "Nick", age: 14, height: 132, weight: 45))

womanStack.push(Woman(name: "Chris", age: 27, height: 156, weight: 60))
womanStack.push(Woman(name: "Warshawa", age: 35, height: 182, weight: 71))
womanStack.push(Woman(name: "Ella", age: 11, height: 130, weight: 34))
womanStack.push(Woman(name: "Mary", age: 23, height: 194, weight: 88))
womanStack.push(Woman(name: "Lisa", age: 16, height: 151, weight: 41))

manStack[0]
manStack[2]
manStack[-1]

manStack[0, 2, -1, 99]

print(manStack.filter{ $0.weight < 100 })

manStack.filter{ $0.weight > 100 }

print(womanStack.sort { $0.age < $1.age })
