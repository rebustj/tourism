import SwiftUI

class NewCategoriesViewController: UIViewController {
  private var categoriesVM: NewCategoriesViewModel
  private var searchVM: SearchViewModel
  private var goToMap: () -> Void
  private let onCreateRoute: (PlaceLocation) -> Void
  
  init(
    categoriesVM: NewCategoriesViewModel,
    searchVM: SearchViewModel,
    goToMap: @escaping () -> Void,
    onCreateRoute: @escaping (PlaceLocation) -> Void
  ) {
    self.categoriesVM = categoriesVM
    self.searchVM = searchVM
    self.goToMap = goToMap
    self.onCreateRoute = onCreateRoute
    
    super.init(
      nibName: nil,
      bundle: nil
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    integrateSwiftUIScreen(
      NewCategoriesScreen(
        categoriesVM: categoriesVM,
        goToSearchScreen: { query in
          self.searchVM.query = query
          let destinationVC = SearchViewController(
            searchVM: self.searchVM,
            goToMap: self.goToMap,
            onCreateRoute: self.onCreateRoute
          )
          self.navigationController?.pushViewController(destinationVC, animated: true)
        },
        goToCategoryScreen: { id in
          // TODO: navigate to Places by category screen
        },
        goToMap: goToMap
      )
    )
  }
}

struct NewCategoriesScreen: View {
  @ObservedObject var categoriesVM: NewCategoriesViewModel
  var goToSearchScreen: (String) -> Void
  var goToCategoryScreen: (Int64) -> Void
  var goToMap: () -> Void
  
  private let columns = [
      GridItem(.flexible()),
      GridItem(.flexible())
  ]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        VerticalSpace(height: 16)
        VStack {
          AppTopBar(
            title: L("categories"),
            actions: [
              TopBarActionData(
                iconName: "map",
                onClick: goToMap
              )
            ]
          )
          
          AppSearchBar(
            query: $categoriesVM.query,
            onSearchClicked: { query in
              goToSearchScreen(query)
            },
            onClearClicked: {
              categoriesVM.clearQuery()
            }
          )
        }
        .padding(16)
        
        LazyVGrid(columns: columns, spacing: 16) {
          ForEach(Constants.categories) { item in
            CategoriesItemView(item: item)
              .onTapGesture {
                goToCategoryScreen(item.id)
              }
          }
        }
        .padding(.horizontal, 16)
        VerticalSpace(height: 32)
      }
    }
  }
}

struct CategoryItem: Identifiable {
  let id: Int64
  let title: String
  let imageName: String
}

struct CategoriesItemView: View {
  let item: CategoryItem
  private let aspectRatio: CGFloat = 1.07
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      Image(item.imageName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: .infinity)
        .clipped()
      
      Text(item.title)
        .font(.system(size: 12, weight: .semibold))
        .foregroundColor(.white)
        .padding(16)
    }
    .aspectRatio(aspectRatio, contentMode: .fit)
    .cornerRadius(22)
  }
}
