import UIKit

class Practice: UIViewController {
    
    
    @IBOutlet var tv_word: UIButton! // 텍스트 출력 버튼
    @IBOutlet var btn_left: UIButton! // 왼쪽 버튼 (비단어)
    @IBOutlet var btn_right: UIButton! // 오른쪽 버튼 (단어)
    
    // 이전view에서 입력한 인적사항 전달받기 위한 변수
    var paramName : String = ""
    var paramSex : Int = 0
    var paramBirth : String = ""
    var paramAge : String = ""
    var paramHand : Int = 0
    var paramArea : String = ""
    var paramYear : String = ""
    var paramPhone : String = ""
    

    var name : String = "" // 이름을 저장할 변수
    var information : String = "" // 모든 정보(인적 사항)를 저장할 변수

    
    var duration : Double = 0 // 단어가 제시되는 시간
    var latency : Double = 0// 단어를 클릭할 수 있는 시간
    var ITI : Double = 0 // 대기 시간
    var practice_count : Int = 0 // 연습실험 횟수
    var count : Int = 0 // 연습 실험 횟수 count
    
    var word_array : Array<String> = Array<String>() // word_array 배열 선언
    var random_number : Int = 0 // 랜덤 숫자
    var word_count : Int = 0 // 총 단어 개수
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tv_word.isEnabled = true // 버튼 비활성화
        btn_left.backgroundColor = UIColor.black // 왼쪽 버튼 색 지정
        btn_right.backgroundColor = UIColor.black // 오른쪽 버튼 색 지정
        
        // 불러온 데이터 확인
        name = paramName
        information = paramName + "___" + String(paramSex) + "___" + paramBirth + "___" + paramAge  + "___" + String(paramHand) + "___" + paramArea + "___" + paramYear + "___" + paramPhone
        
        print(name)
        print(information)
        
        /*** Read from project time.txt file ***/
        // File location
        let text_time = Bundle.main.path(forResource: "time", ofType: "txt")
        
        // Read from the file
        var readText_time = ""
        do {
            readText_time = try String(contentsOfFile: text_time!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed reading from URL: \(String(describing: text_time)), Error: " + error.localizedDescription)
        }
        print(readText_time)
        
        // time_array 배열 선언
        var time_array: Array<String> = Array<String>()
        // time_array에 readText_time내용을 "," 기준으로 나누어 time_array 배열에 저장
        time_array.append(contentsOf: readText_time.components(separatedBy: ","))
        
        print(time_array)
        
        duration = Double((time_array[0] as NSString).intValue) / 1000 // 첫 번째 텍스트를 duraion 변수에 저장 (단어가 제시되는 시간)
        print(duration) // 확인 출력문
        latency = Double((time_array[1] as NSString).intValue) / 1000 // 두 번째 텍스트를 lantency 변수에 저장 (단어를 클릭할 수 있는 시간)
        print(latency) // 확인 출력문
        ITI = Double((time_array[2] as NSString).intValue) / 1000 // 세 번째 텍스트를 ITI 변수에 저장 (대기 시간)
        print(ITI) // 확인 출력문
        practice_count = Int((time_array[3] as NSString).intValue)// 네 번째 텍스트를 practive_count 변수에 저장 (대기 시간)
        print(practice_count) // 확인 출력문
        
        /*** Read from project word.txt file ***/
        // File location
        let word = Bundle.main.path(forResource: "word", ofType: "txt")
        
        // Read from the file
        var readText_word = ""
        do {
            readText_word = try String(contentsOfFile: word!, encoding: String.Encoding.utf8)

        } catch let error as NSError {
            print("Failed reading from URL: \(String(describing: word)), Error: " + error.localizedDescription)
        }
        print(readText_word)
        
        // 문자열 word에서 "/n"(띄어쓰기)를 "/"으로 변경
        let ch_word = readText_word.replacingOccurrences(of: "\n", with: "/")

        // word_array에 문자열 ch_word내용을 "/" 기준으로 나누어 word_array 배열에 저장
        word_array.append(contentsOf: ch_word.components(separatedBy: "/"))
        
        
        // word_array 크기 (총 단어의 갯수)
        word_count = word_array.count
        print(word_count) // 확인 출력문
        
        perform(#selector(ITI_handler)) // 액티비티 시작과 동시에 ITI_handler에 메시지 전달
        
    }
    // 왼쪽 버튼을 클릭했을 떄
    @IBAction func Btn_left(_ sender: UIButton) {
        buttonClick() // 버튼 비활성화 함수 호출
    }
    // 오른쪽버튼 클릭했을 때
    @IBAction func Btn_right(_ sender: UIButton) {
        buttonClick() // 버튼 비활성화 함수 호출
    }
    
    private func buttonClick(){
        tv_word.backgroundColor = UIColor.darkGray // textView_word 의 backgroundColor 를 진한 회색으로 변경
        btn_left.isEnabled = false // 왼쪽 버튼 비활성화
        btn_right.isEnabled = false // 오른쪽 버튼 비활성화
    }
    
    // 단어 제시(duration) Handler
    // #selector에 사용할 수 있는 메소드는 Objective-C 메소드여야 하기 때문에 Swift 함수 앞에 @objc 를 붙여줘야 함.
    @objc func dulation_Handler(){
        let duration_queue = DispatchQueue(label: "duration")
        duration_queue.sync {
            print("duration")
            random_number = Int.random(in: 0..<word_count) // 0부터 word_count-1 사이의 random 정수를 random_number에 저장
            btn_left.isEnabled = true // 왼쪽 버튼 활성화
            btn_right.isEnabled = true // 오른쪽 버튼 활성화
            tv_word.setTitle(String(word_array[random_number].split(separator: ",")[1]), for: .normal) // random_number의 단어 출력
            /*
            tv_word.text = String(word_array[random_number].split(separator: ",")[1]) // random_number의 단어 출력
             */
        }
        // 메세지를 처리하고 duration 후 click_handler 에 메세지 전달
        perform(#selector(click_handler), with: nil, afterDelay: TimeInterval(duration))
        print(456)
    }
    
    // 단어가 제시된 후 (latency - duration) Handler
    @objc func click_handler() {
        print("click")
        let click_queue = DispatchQueue(label: "click")
        click_queue.sync {
            tv_word.setTitle("", for: .normal) // 단어 공백 출력 (duration 후)
            /*
            tv_word.text = "" // 단어 공백 출력 (duration 후)
             */
        }
        // 메세지를 처리하고 latency - duration 후 ITI_Handler 에 메세지 전달
        perform(#selector(ITI_handler), with: nil, afterDelay: TimeInterval(latency - duration))
        print(789)
    }
    
    // 대기 시간(ITI) Handler
    @objc func ITI_handler(){
        let ITI_queue = DispatchQueue(label: "ITI")
        ITI_queue.sync{
            print("ITI")
            btn_left.isEnabled = false
            btn_right.isEnabled = false // 오른쪽 버튼 비활성화
            tv_word.backgroundColor = UIColor.black // textView_word 의 backgroundColor 를 검정색으로 변경
            if(count == practice_count){ // count가 연습 횟수(practice_count)랑 같으면
                guard let ready = storyboard?.instantiateViewController(withIdentifier: "Ready") as? Redy else{
                    return
                }
                ready.paramname = name // name 값 실험준비(Ready)로 전달
                ready.paraminformation = information // information 값 실험준비(Ready)로 전달
                self.navigationController?.pushViewController(ready, animated: true) // 화면 전환
                self.removeFromParent() // viewController 종료
                return; // 험수 종료
            }else{// count가 연습횟수(practice_count)랑 다르면
                self.tv_word.setTitle(" [         ] ", for: .normal) // 텍스트 변경 (대기시간 나타냄)
                /*
                self.tv_word.text = " [         ] " // 텍스트 변경 (대기시간 나타냄)
                */
                self.count+=1 // count 1 증가 (연습 횟수 count 증가)
            }
            perform(#selector(dulation_Handler), with: nil, afterDelay: TimeInterval(ITI))
            print(123)
        }
    }
}
