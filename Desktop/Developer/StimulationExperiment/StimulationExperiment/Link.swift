import UIKit

public class Link: UIViewController{

    var paramname : String = "" // 이름을 저장할 변수
    var paramresult : String = "" // 결과 정보를 저장할 변수
    
    var netError : Bool = true // 네트워크 상태
    
    var serverURL : String = "http://inlab.cu.ac.kr/inlabMail/StimulationData.php" // 서버 URL
    var postParameters : String = "" // 보낼 데이터
    
    // HttpURLConnetcion 클래스를 사용하여 POST 방식으로 데이터를 전송
    public func sendPost(paramText: String, urlString: String){
        // postParameters를 데이터 형태로 변환
        let paramData = postParameters.data(using: .utf8)
        
        // URL 객체 정의
        let url = URL(string: serverURL) // 주소가 저장된 변수를 입력하여 URL 객체 생성
                
        // URL Request 객체 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST" // 요청 방식 = POST
        request.httpBody = paramData
                
        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //  서버가 응답이 없거나 통신이 실패
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                
                DispatchQueue.main.async() {
                    // 네비게이션 방식으로 화면 전환 - fail
                    guard let fail = self.storyboard?.instantiateViewController(withIdentifier: "Fail") as? Fail else{
                        return
                    }
                    
                    fail.postParameters = self.postParameters
                    
                    self.navigationController?.pushViewController(fail, animated: false)
                }
            }
            // 응답 처리 로직
            DispatchQueue.main.async() {
                // 서버로 부터 응답된 스트링 표시
                
                let outputStr = String(data: paramData!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
        }
        // POST 전송
        task.resume()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("link")
        print(paramname)
        print(paramresult)
        
        postParameters = "name=" + paramname + "&data=" + paramresult // 보낼 데이터

        sendPost(paramText: postParameters, urlString: serverURL)
        print("success")
        // 네비게이션 방식으로 화면 전환 - success
        guard let success = self.storyboard?.instantiateViewController(withIdentifier: "Success") as? Success else{
            return
        }
        self.navigationController?.pushViewController(success, animated: false)
    }
}
