import UIKit

// Align text inside textView vertically
extension UITextView{
    func alignTextVerticallyInContainer(){
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}

class Main: UIViewController {

    @IBOutlet var file: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        /*** Read from project guidance.txt file ***/
        
        // File location
        let fileURLProject = Bundle.main.path(forResource: "guidance", ofType: "txt")
        
        // Read from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
            file.text = readStringProject
            // 가운데 정렬
            file.textAlignment = NSTextAlignment.center
            // 수직가운데 정렬
            file.alignTextVerticallyInContainer()
            // textview ReadOnly
            file.isEditable = false
            
        } catch let error as NSError {
            print("Failed reading from URL: \(String(describing: fileURLProject)), Error: " + error.localizedDescription)
            
        }
        
        print(readStringProject)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}

