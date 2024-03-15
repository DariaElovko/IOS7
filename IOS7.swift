enum ActionType {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadCargo(volume Double)
    case unloadCargo(volume Double)
}

struct Car {
    var brand String
    var year Int
    var trunkVolume Double
    var isEngineRunning Bool
    var areWindowsOpen Bool
    var loadedCargoVolume Double

    mutating func performAction(action ActionType) {
        switch action {
        case .startEngine
            isEngineRunning = true
        case .stopEngine
            isEngineRunning = false
        case .openWindows
            areWindowsOpen = true
        case .closeWindows
            areWindowsOpen = false
        case .loadCargo(let volume)
            loadedCargoVolume += volume
            if loadedCargoVolume  trunkVolume {
                loadedCargoVolume = trunkVolume
            }
        case .unloadCargo(let volume)
            loadedCargoVolume -= volume
            if loadedCargoVolume  0 {
                loadedCargoVolume = 0
            }
        }
    }
}

struct Truck {
    var brand String
    var year Int
    var cargoVolume Double
    var isEngineRunning Bool
    var areWindowsOpen Bool
    var loadedCargoVolume Double

    mutating func performAction(action ActionType) {
        switch action {
        case .startEngine
            isEngineRunning = true
        case .stopEngine
            isEngineRunning = false
        case .openWindows
            areWindowsOpen = true
        case .closeWindows
            areWindowsOpen = false
        case .loadCargo(let volume)
            loadedCargoVolume += volume
            if loadedCargoVolume  cargoVolume {
                loadedCargoVolume = cargoVolume
            }
        case .unloadCargo(let volume)
            loadedCargoVolume -= volume
            if loadedCargoVolume  0 {
                loadedCargoVolume = 0
            }
        }
    }
}

var car = Car(brand Toyota, year 2022, trunkVolume 500.0, isEngineRunning false, areWindowsOpen false, loadedCargoVolume 0.0)
var truck = Truck(brand Volvo, year 2020, cargoVolume 5000.0, isEngineRunning false, areWindowsOpen false, loadedCargoVolume 0.0)

car.performAction(action .startEngine)
car.performAction(action .openWindows)
car.performAction(action .loadCargo(volume 300.0))

truck.performAction(action .startEngine)
truck.performAction(action .loadCargo(volume 2000.0))

var vehicleDictionary [String Any] = []
vehicleDictionary[car] = car
vehicleDictionary[truck] = truck

var count = 0

let incrementCount () - Int = {
  [count] in  Capture List
  var mutableCount = count  Создаем копию count и используем ее для изменений
  mutableCount += 1
  return mutableCount
}

print(incrementCount())  1
print(incrementCount())  1 (всегда 1, так как каждый раз используется копия из Capture List)
print(incrementCount())  1 (аналогично)


В коде на скриншоте есть рядов ошибок
 1. нам не нужна библиотека UIKit. Стргоку можно удалить (import UIKit)
 Существует циклицеская зависимость между car и man. Одно ссылается на другое. 
 Мы не можем просто приравнять их к nil, так как тогда происходит утечка памяти
 Для решения проблемы используем weak, чтобы избежать циклической зависимости

class Car {
    weak var driver Man   Используем weak, чтобы избежать циклической зависимости
    
    deinit {
        print(машина удалена из памяти)
    }
}

class Man {
    weak var myCar Car   Используем weak, чтобы избежать циклической зависимости
    
    deinit {
        print(мужчина удален из памяти)
    }
}

var car Car = Car()
var man Man = Man()

car.driver = man
man.myCar = car

car = nil
man = nil

 Аналогично столкнулись с циклической зависимостью
 Добавим unowned let man Man вместо let man Man в классе Passport
 Выбрали unowned, так как ссылка на мужчину - константа
class Man{
    var pasport Passport

    deinit {
    print(мужчина удален из памяти)
    }
}

class Passport {
    unowned let man Man

    init(manMan) {
        self.man = man
    }
deinit{
        print("паспорт удален из памяти")
    }
}

var man: Man? = Man()
var passport: Passport? = Passport(man: man!)
man?.pasport = passport
passport = nil
man = nil

//Capture List - это инструмент в Swift, который позволяет "захватывать" значения извне замыкания и использовать их внутри него. Замыкание - это функция, которая может ссылаться на переменные из области видимости, в которой она была создана.
//В Swift capture list записывается в квадратных скобках после ключевого слова in в замыкании. Она предоставляет явные инструкции, какие переменные следует захватить и в каком виде, чтобы избежать цикла ссылок (retain cycles) и предотвратить утечки памяти.
//При использовании Capture List переменные становятся константами в замыкании по умолчанию. Таким образом, мы не можем изменять их значения.