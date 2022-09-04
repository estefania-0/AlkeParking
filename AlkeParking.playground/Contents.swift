import Foundation
import UIKit

protocol Parkable {
    var plate: String { get }
    var type: VehicleType {get}
    var checkInTime: Date {get}
    var discountCard: String? { get set }
    var parkedTime: Int { get }
}

enum VehicleType{
    case car
    case motorcycle
    case miniBus
    case bus
    
    var hourFee: Int{
        switch self {
        case .car: return 20
        case .motorcycle: return 15
        case .miniBus: return 25
        case .bus: return 30
        }
    }
}

struct Parking {
    var vehicles: Set<Vehicle> = []
    let parkingLimit = 20
    var stadistics: (vehicles: Int, earnings: Int) = (0,0)
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        
        guard vehicles.count < parkingLimit, vehicles.insert(vehicle).inserted else {
            onFinish(false)
            return
        }
        onFinish(true)
    }
    
    mutating func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: () -> Void) {
       
        let vehicleExists = vehicles.first(where: { $0.plate == plate })
        
        guard let vehicle = vehicleExists else {
            onError()
            return
        }
        
        self.vehicles.remove(vehicle)
        
        let hasDiscound = vehicle.discountCard != nil
        
        let fee = self.calculateFee(type: vehicle.type, parkedTime: vehicle.parkedTime, hasDiscountCard: hasDiscound)
        self.stadistics.earnings += fee
        self.stadistics.vehicles += 1
        onSuccess(fee)
        return
        
    }
    
    func calculateFee(type: VehicleType, parkedTime: Int, hasDiscountCard: Bool) -> Int {
        var fee = type.hourFee
        let hours = 120
        
        if parkedTime > hours {
            let reminderMins = parkedTime - 120
            fee += Int(ceil(Double(reminderMins) / 15.0)) * 5
        }
        if hasDiscountCard {
            fee = Int(Double(fee) * 0.85)
        }
        return fee
    }
    
    func showEarnings() {
        print("\(stadistics.vehicles) vehicles have checked out and have earnings of $\(stadistics.earnings)")
    }
    
    func listVehicles() {
        for vehicle in vehicles {
            print("Vehicle: \(vehicle.plate)")
        }
    }
    
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime : Date = Date()
    var discountCard: String?
    var parkedTime: Int {
        Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
    
    func checkOutVehicle(plate: String, onSuccess: (Int) -> Int, onError: ()){
        
    }
}
    
var alkeParking = Parking()

let vehicle1 = Vehicle(plate: "AA111AA", type: VehicleType.car,discountCard: "DISCOUNT_CARD_001")
let vehicle2 = Vehicle(plate: "B222BBB", type: VehicleType.motorcycle, discountCard: nil)
let vehicle3 = Vehicle(plate: "CC333CC", type: VehicleType.miniBus, discountCard: nil)
let vehicle4 = Vehicle(plate: "DD444DD", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_002")
let vehicle5 = Vehicle(plate: "AA111BB", type: VehicleType.car, discountCard: "DISCOUNT_CARD_003")
let vehicle6 = Vehicle(plate: "B222CCC", type: VehicleType.motorcycle, discountCard: "DISCOUNT_CARD_004")
let vehicle7 =  Vehicle(plate: "CC333DD", type: VehicleType.miniBus, discountCard: nil)
let vehicle8 = Vehicle(plate: "DD444EE", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_005")
let vehicle9 = Vehicle(plate: "AA111CC", type: VehicleType.car, discountCard: nil)
let vehicle10 = Vehicle(plate: "B222DDD", type: VehicleType.motorcycle, discountCard: nil)
let vehicle11 = Vehicle(plate: "CC333EE", type: VehicleType.miniBus, discountCard: nil)
let vehicle12 = Vehicle(plate: "DD444GG", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_006")
let vehicle13 = Vehicle(plate: "AA111DD", type: VehicleType.car, discountCard: "DISCOUNT_CARD_007")
let vehicle14 = Vehicle(plate: "B222EEE", type: VehicleType.motorcycle, discountCard: nil)
let vehicle15 = Vehicle(plate: "CC333FF", type: VehicleType.miniBus, discountCard: nil)
let vehicle16 = Vehicle(plate: "DD444HH", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_008")
let vehicle17 = Vehicle(plate: "AA111EE", type: VehicleType.car, discountCard: "DISCOUNT_CARD_009")
let vehicle18 = Vehicle(plate: "B222FFF", type: VehicleType.motorcycle, discountCard: nil)
let vehicle19 = Vehicle(plate: "CC333GG", type: VehicleType.miniBus, discountCard: nil)
let vehicle20 = Vehicle(plate: "DD444II", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_010")

let vehicles = [Vehicle(plate: "AA111AA", type: VehicleType.car,discountCard: "DISCOUNT_CARD_001"),
                Vehicle(plate: "B222BBB", type: VehicleType.motorcycle, discountCard: nil),
                Vehicle(plate: "CC333CC", type: VehicleType.miniBus, discountCard: nil),
                Vehicle(plate: "DD444DD", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_002"),
                Vehicle(plate: "AA111BB", type: VehicleType.car, discountCard: "DISCOUNT_CARD_003"),
                Vehicle(plate: "B222CCC", type: VehicleType.motorcycle, discountCard: "DISCOUNT_CARD_004"),
                Vehicle(plate: "CC333DD", type: VehicleType.miniBus, discountCard: nil),
                Vehicle(plate: "DD444EE", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_005"),
                Vehicle(plate: "AA111CC", type: VehicleType.car, discountCard: nil),
                Vehicle(plate: "B222DDD", type: VehicleType.motorcycle, discountCard: nil),
                Vehicle(plate: "CC333EE", type: VehicleType.miniBus, discountCard: nil),
                Vehicle(plate: "DD444GG", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_006"),
                Vehicle(plate: "AA111DD", type: VehicleType.car, discountCard: "DISCOUNT_CARD_007"),
                Vehicle(plate: "B222EEE", type: VehicleType.motorcycle, discountCard: nil),
                Vehicle(plate: "CC333FF", type: VehicleType.miniBus, discountCard: nil),
                Vehicle(plate: "DD444HH", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_008"),
                Vehicle(plate: "AA111EE", type: VehicleType.car, discountCard: "DISCOUNT_CARD_009"),
                Vehicle(plate: "B222FFF", type: VehicleType.motorcycle, discountCard: nil),
                Vehicle(plate: "CC333GG", type: VehicleType.miniBus, discountCard: nil),
                Vehicle(plate: "DD444II", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_010")]

vehicles.forEach { vehicle in
    alkeParking.checkInVehicle(vehicle) { canInsert in
        if !canInsert {
            print("Sorry, the check-in failed")
        } else {
            print("Welcome to AlkeParking!")
        }
        
    }
}


print("")

//Ingresar nuevo vehiculo cuando ya existen 20
let vehicle21 = Vehicle(plate: "AA111AB", type: VehicleType.car, discountCard: "DISCOUNT_CARD_002")
alkeParking.checkInVehicle(vehicle21) { canInsert in
    if !canInsert {
        print("Sorry, the check-in failed")
    } else {
        print("Welcome to AlkeParking!")
    }
}

//Hacer checkout de un vehiculo existente
alkeParking.checkOutVehicle(plate: "DD444DD") { fee in
    print("Your fee is \(fee). Come back soon.")
} onError: {
    print("Sorry, the check-out failed")
}

//Ganancias del Parking
alkeParking.showEarnings()

//Checkout de vehiculo inexistente
alkeParking.checkOutVehicle(plate: "DD444DF") { fee in
    print("Your fee is \(fee). Come back soon.")
} onError: {
    print("Sorry, the check-out failed")
}

//Hacer checkout de un vehiculo existente
alkeParking.checkOutVehicle(plate: "AA111AA") { fee in
    print("Your fee is \(fee). Come back soon.")
} onError: {
    print("Sorry, the check-out failed")
}

//Ganancias del Parking
alkeParking.showEarnings()

print("")
print("#######Patentes#######")
//Listado de patentes de vehiculos existentes
alkeParking.listVehicles()
