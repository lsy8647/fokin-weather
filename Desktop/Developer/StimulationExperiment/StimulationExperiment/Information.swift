import UIKit

class Information: UIViewController {
    
    @IBOutlet var segmentedControl_sex: UISegmentedControl!
    @IBOutlet var segmentedControl_hand: UISegmentedControl!
    @IBOutlet var tf_name: UITextField!
    @IBOutlet var tf_birth: UITextField!
    @IBOutlet var tf_age: UITextField!
    @IBOutlet var tf_area: UITextField!
    @IBOutlet var tf_year: UITextField!
    @IBOutlet var tf_phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func indexChanged_sex(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("selected male")
        }
        else if sender.selectedSegmentIndex == 1{
            print("selected female")
        }
    }
    
    @IBAction func indexChanged_hand(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("selected lefthand")
        }
        else if sender.selectedSegmentIndex == 1{
            print("selected righthand")
            
        }
    }
    
    @IBAction func clickBtn_prac(_ sender: Any) {
        if (tf_name.text?.isEmpty)! || (tf_age.text?.isEmpty)! || (tf_area.text?.isEmpty)! || (tf_year.text?.isEmpty)! || (tf_birth.text?.isEmpty)! || (tf_phone.text?.isEmpty)!{
            let show_alert = UIAlertController(title: "경고", message: "인적사항을 모두 입력해주십시오.",preferredStyle: UIAlertController.Style.alert)
            let alert_ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            show_alert.addAction(alert_ok)
            present(show_alert, animated: true, completion: nil) // alert view 화면에 뜨게
        }else {
            // ThirdViewController로 다운캐스팅 하는 이유는 해당 뷰 컨트롤러에 저장할 변수들이 선언되어있기 때문,
            // 다른 뷰 컨트롤러에는 해당 오류가 발생할 수 있기 때문에 다운캐스팅한다.
            guard let next = self.storyboard?.instantiateViewController(withIdentifier: "NEXT") as? Practice else{
                return
            }
            
            next.paramName = self.tf_name.text!
            next.paramSex = self.segmentedControl_sex.selectedSegmentIndex
            next.paramBirth = self.tf_birth.text!
            next.paramAge = self.tf_age.text!
            next.paramHand = self.segmentedControl_hand.selectedSegmentIndex
            next.paramArea = self.tf_area.text!
            next.paramYear = self.tf_year.text!
            next.paramPhone = self.tf_phone.text!
            
            // 네비게이션 방식으로 화면 전환
            self.navigationController?.pushViewController(next, animated: false)
        }
    }
}

