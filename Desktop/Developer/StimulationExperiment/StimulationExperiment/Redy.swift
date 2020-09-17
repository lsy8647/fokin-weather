import UIKit

class Redy: UIViewController {
    
    var paramname : String = ""
    var paraminformation : String = ""
    @IBOutlet var tv_ready: UITextView!
    @IBOutlet var btn_experiment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(paramname)
        print(paraminformation)
        
        // 가운데 정렬
        tv_ready.textAlignment = NSTextAlignment.center
        // textview ReadOnly
        tv_ready.isEditable = false
    
    }
    
    @IBAction func Btn_experiment(_ sender: Any) {
        
        guard let experiment = self.storyboard?.instantiateViewController(withIdentifier: "Experiment") as? Experiment else{
            return
            
        }
        experiment.name = self.paramname
        experiment.information = self.paraminformation
        
        // 네비게이션 방식으로 화면 전환
        self.navigationController?.pushViewController(experiment, animated: false)
    }
    
}
