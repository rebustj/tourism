import Combine

class NewCategoriesViewModel: ObservableObject {
  @Published var query = ""
  
  func clearQuery() { query = "" }
}
