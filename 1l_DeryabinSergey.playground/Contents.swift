import UIKit

//Решить квадратное уравнение.

let a: Float = 3.0
let b: Float = 13.0
let c: Float = -10.0

let discriminant = (pow(b, 2) - (4 * a * c))

if discriminant > 0 {
  let x1 = (-b + sqrt(discriminant)) / (2 * a)
  let x2 = (-b - sqrt(discriminant)) / (2 * a)
  
  print("Дискриминант больше нуля, уравнение имеет два корня \nx1 равен: \(x1) \nx2 равен: \(x2)")
} else if discriminant == 0 {
  let x1 = (-b + sqrt(discriminant)) / (2 * a)
  
  print("Дискриминант равен нулю, уравнение имеет один корень \nx1 равен: \(x1)")
} else {
  print("Дискриминант меньше нуля \nРешений нет.")
}

//Для проверки верности иксов
//let x: Double = -5
let x: Float = 0.6666667
let equation = (a * pow(x, 2) + b * x + c == 0) //уравнение


//Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

let firstLeg: Float = 3
let secondLeg: Float = 4

let hypotenuse = sqrt(pow(firstLeg, 2) + pow(secondLeg, 2))
let square = (firstLeg * secondLeg) / 2
let perimeter = firstLeg + secondLeg + hypotenuse


//Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var depositAmount = 500_000  //сумма вклада
let annualPercent = 10  //годовой процент

var countOfYears = 0 //счётчик годов
while countOfYears < 5 {
  let depositPercent = depositAmount / 100 * annualPercent //
  depositAmount += depositPercent
  countOfYears += 1
}
print("Через 5 лет пользователь получит \(depositAmount) УЕ")

