
import UIKit

class DetailVC: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    
    //MARK: - Default Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Initialization

    func fetchData(detail: Item){
        lblTitle.text = detail.data?.first?.title ?? ""
        lblDescription.text = detail.data?.first?.description ?? ""
        lblCreatedAt.text = detail.data?.first?.date_created ?? ""
    }
    deinit {
        
            print("deinit") // gets called
        }
}
