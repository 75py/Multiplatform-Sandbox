import SwiftUI
import shared
import UIKit

class CustomTableViewController: UITableViewController {
    
    private let numOfRows = 100
    private let sharedViewIndex = 19
    private let sharedViewIdentifier = "shared_cell"
    private var cachedHostingControllers: [Int: UIHostingController<HorizontalScrollRowViewControllerWrapper>] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sharedViewIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // {sharedViewIndex}番目のセルにHorizontalScrollRowViewControllerWrapperを表示
        if indexPath.row == sharedViewIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: sharedViewIdentifier, for: indexPath)
            let cachedVC = cachedHostingControllers[indexPath.row]
            if cachedVC == nil {
                let hostVC = UIHostingController(rootView: HorizontalScrollRowViewControllerWrapper())
                cachedHostingControllers[indexPath.row] = hostVC
                
                self.addChild(hostVC)
                hostVC.didMove(toParent: self)
                
                hostVC.view.frame = cell.contentView.bounds
                hostVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
                cell.contentView.addSubview(hostVC.view)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Row \(indexPath.row + 1)"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

struct TableViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CustomTableViewController {
        return CustomTableViewController()
    }
    
    func updateUIViewController(_ uiViewController: CustomTableViewController, context: Context) {
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            TableViewControllerWrapper()
            TableViewControllerWrapper()
            TableViewControllerWrapper()
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HorizontalScrollRowViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return Platform_iosKt.HorizontalScrollRowViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
