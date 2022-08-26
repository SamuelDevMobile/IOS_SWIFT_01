import Foundation
import Security

// Enumeradores
enum Compass {
    case north
    case south
    case west
    case east
}

//var heading: Compass = Compass.north
//var heading = Compass.north
var heading: Compass = .south
print(heading)
//var name: String = String("")
//var name: String = String.init("")
var name: String = .init()

switch heading {
case .south:
    print("Estou indo para o sul")
case .north:
    print("Estou indo para o norte")
case .east:
    print("Estou indo para o lest")
case .west:
    print("Estou indo para o oeste")
}

//Enumerador com valor padrão

enum WeekDay: String {
    case sunday = "domingo"
    case monday = "segunda"
    case tuesday = "terca"
    case wednesday = "quarta"
    case thursday = "quinta"
    case friday = "sexta"
    case saturday = "sabado"
}

let weekDay: WeekDay = .thursday
print(weekDay.rawValue)

let friday = WeekDay(rawValue: "sexta")
//print(friday)

//Enumeradores com valor atribuido (associated value)
enum Measure {
    case weight(Double)
    case size(Double, Double)
    case age(Int)
}

let measure1: Measure = .age(32)
let measure2: Measure = .size(25, 15)
let measure3: Measure = .weight(73)

switch measure1 {
case .weight(let weight):
    print("A medida é de peso e o valor é \(weight)")
case .size(let width, let heigth):
    print("A medida é de tamanho e o tamanho é \(width)x\(heigth)")
case .age(let age):
    print("A medida é de idade e a idade é \(age)Kg")
}

enum APIError {
    case noData
    case invalidStatusCode(Int)
    case decodingError(Error)
    case badRequest
    case invalidURL(URL)
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "A requisição foi inválida"
        case .invalidStatusCode(let statusCode):
            return "O servidor retornou o status code \(statusCode)"
        default:
            return "Error desconhecido"
            
        }
    }
}

let error: APIError = .badRequest
print(error.errorMessage)

// Estruturas (Structs)
struct Driver {
    var name: String
    var registration: String
    var age: Int
            
    //Memberwise Initializer
    mutating func changeAge(newAge: Int) {
        age = newAge
    }
}

//Copy-on-write

//var driver: Driver = Driver()
//Imutáveis
var driver = Driver(name: "Samuel", registration: "123456-7", age: 24)
var driver2 = driver

driver.name = "Regina"
print(driver.name)
print(driver2.name) //Uma Copia de Driver

//Funções
/*
 func nomeDaFuncao(parm1: Tipo, param2: Tipo2) -> Int {
    //Código da função
 }
 */

func doNothing() -> Void {}
doNothing()

func doubles(number: Int) -> Int {
    print("Vou duplicar o numbe, \(number)")
    return number * 2
}
print(doubles(number: 4))

func sumNumber(a: Int, b: Int) -> (Int) {
    a + b
}
sumNumber(a: 20, b: 30)

func sum(value: Int, with: Int...) -> Int {
    var result = value
    for number in with {
        result += number
    }
    
    return result
}

sum(value: 8, with: 7, 4, 3, 12, 9, 1000)

print(driver.name, driver2.name, 12, sum(value: 8, with: 7, 4, 3, 12, 9, 1000))

func power(_ a: Double, _ b: Double) -> Double {
    pow(a, b)
}
power(2, 3)

func say(_ greeting: String, to person: String) {
    print(greeting, person)
}
say("Ola", to:"Samuel")

//First Class Citizen
func multiply(a: Int, b: Int) -> Int {
    a * b
}

func divide(a: Int, b: Int) -> Int {
    a / b
}

func sumy(a: Int, b: Int) -> Int {
    a + b
}

func subtract(a: Int, b: Int) -> Int {
    a - b
}

typealias MathOperation = (Int, Int) -> Int
func calculate(a: Int, b: Int, operation: MathOperation) -> Int {
    operation(a, b)
}

calculate(a: 45, b: 5, operation: sumy)

func getOperation(named: String) -> MathOperation {
    switch named {
    case "soma":
        return sumy
    case "subtracao":
        return subtract
    case "divisao":
        return divide
    default:
        return multiply
    }
}

var soma = getOperation(named: "soma")
soma(2, 7)

//Closures

/*
 { (parm1: Tipo, param2: Tipo2) -> Int in
    //Código da função
    // return tipo
 }
 */

calculate(a: 12, b: 5, operation: { (x: Int, y: Int) -> Int in
    return x % y
})

calculate(a: 12, b: 5, operation: { (x, y) -> Int in
    return x % y
})

calculate(a: 12, b: 5, operation: { x, y -> Int in
    return x % y
})

calculate(a: 12, b: 5, operation: { x, y in
    return x % y
})

calculate(a: 12, b: 5, operation: {
    return $0 % $1
})

calculate(a: 12, b: 5) {$0 % $1}

calculate(a: 12, b: 5, operation: %)

//High Order Function
var names = ["Ana", "Juliana", "Pedro", "Zé", "Paulo", "Eric"]
var namesUpperCased: [String] = []
for name in names {
    namesUpperCased.append(name.uppercased())
}
print(namesUpperCased)

print(names.map(){$0.uppercased()})

print(names.filter(){$0.count < 5})

print(names.reduce(0) {$0 + $1.count})
print(names.joined().count)
print(names.sorted())
print(names.sorted(by: <))

//>-8
prefix operator >-
prefix func >-(rhs: Int) -> Int {
    rhs * rhs
}

>-8

//8-<
postfix operator -<
postfix func -<(lhs: Int) -> Int {
    Int(Double(lhs) / Double.pi)
}

12345687-<

// >-<
infix operator >-<
func >-<(lhs: Int, rhs: Int) -> [Int] {
    var result: Set<Int> = []
    while result.count < lhs {
        result.insert(Int.random(in: 1...rhs))
    }
    return result.sorted()
}

6>-<60

//Tratamento de Erros
enum AccessError: Error {
    case invalidUser
    case invalidPassword
    case invalidData
}

func login(userName: String, password: String) throws -> String {
    let validUser = "alunofiap"
    let validPassword = "abc@123"
    if userName != validUser && password != validPassword {
        throw AccessError.invalidData
    } else if userName != validUser {
        throw AccessError.invalidUser
    } else if password != validPassword {
        throw AccessError.invalidPassword
    } else {
        return "Usuario logado com sucesso"
    }
}

do {
    var result: String = ""
    try result = login(userName: "alunofiap", password: "abc@123")
    print(result)
} catch {
    switch error as? AccessError {
    case .invalidPassword:
        print("Senha inválida")
    case .invalidUser:
        print("Usuário inválido")
    case .invalidData:
        print("Dados inválidos")
    default:
        print("Algum filha de uma egua mudou o AccessError. Azara de quem fez as!")
    }
}

//Generics
var x = 10
var y = 15

func swapInt(a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

swapInt(a: &x, b: &y)

print(x) //15
print(y) //10

func swapValues<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

var z = true
var w = false

swapValues(a: &z, b: &w)

print(z)
print(w)
