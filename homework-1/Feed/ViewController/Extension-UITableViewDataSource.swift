

import Foundation
import UIKit

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ?  viewModel.filteterdDataItems.count :  viewModel.dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = isFiltered ?  viewModel.filteterdDataItems[indexPath.row] :  viewModel.dataItems[indexPath.row]
        
        return cell
    }
}
