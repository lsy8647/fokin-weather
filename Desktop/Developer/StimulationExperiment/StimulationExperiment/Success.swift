import UIKit

class Success: UIViewController{

    @IBOutlet var tv_load: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tv_load.isEditable = false
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_load(_ sender: UIButton) {
        //UIApplication.shared.openURL(NSURL(string: "http://www.naver.com/")! as URL)
        let url = URL(string:"https://sites.google.com/view/psylingposter/experiment-page") // 실험목적 링크 열기
        UIApplication.shared.open(url!, options: [:])
    }
}
