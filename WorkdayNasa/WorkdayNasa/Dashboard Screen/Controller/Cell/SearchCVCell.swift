
import UIKit

class SearchCVCell: UICollectionViewCell {
    //MARK: - Outlets
    
    @IBOutlet weak var imgSearchImage: UIImageView!
    @IBOutlet weak var lblSearchTitle: UILabel!
    
    //MARK: - Initialization
    
    func setupCell(_ data:Item) {
        lblSearchTitle.text = data.data?.first?.title
        DispatchQueue.global().async {
            
            if  let url = URL(string: data.links?.first?.href ?? ""), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.imgSearchImage.image = image
                    
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        super.awakeFromNib()
    }

}
