import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.

func isEven(number: Int) -> Bool {
  guard number % 2 == 0 && number != 0 else { return false }
  
  return true
}


// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func isDivisibleBy3WithoutRemainder(number: Int) -> Bool {
  guard number % 3 == 0 && number != 0 else { return false }
  
  return true
}


// 3. Создать возрастающий массив из 100 чисел.

var increasingArray = [Int]()

var number = 0
while increasingArray.count < 100 {
  number += 1
  increasingArray.append(number)
}


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for value in increasingArray {
  if isEven(number: value) || !isDivisibleBy3WithoutRemainder(number: value) {
    if let index = increasingArray.index(of: value) {
      increasingArray.remove(at: index)
    }
  }
}


// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

var fibonacciArray = [1, 1]

func addSomeFibonacciNumbers(to array: inout [Int]) {
  for _ in 1...50 {
    let firstNumber = array.count - 1
    let secondNumber = array.count - 2
    let nextNumber = array[firstNumber] + array[secondNumber]
    array.append(nextNumber)
//    array.append(array[array.count - 1] + array[array.count - 2]) // - Не знаю как по читабильности будет правильнее
  }
}

addSomeFibonacciNumbers(to: &fibonacciArray)


// 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу.

var numbers = [Int]()
var startNumber = 2

while numbers.count < 100 {
  for _ in numbers.count...100 {
    numbers.append(startNumber)
    startNumber += 1
  }
  
  guard var p = numbers.first else { break }

  while p != numbers.last {
    for value in numbers {
      if value % p == 0 && value != p {
        if let index = numbers.index(of: value) {
          numbers.remove(at: index)
        }
      }
    }
    for value in numbers {
      if value > p {
        p = value
        
        break
      }
    }
  }
}
