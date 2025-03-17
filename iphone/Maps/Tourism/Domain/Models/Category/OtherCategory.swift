import Foundation

enum OtherCategory: String, Codable {
  case taxi = "4"
  case orderFood = "5"
  case hotline = "6"
  
  var id: Int64 {
    Int64(self.rawValue)!
  }
}
