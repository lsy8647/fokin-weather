import UIKit

class Experiment: UIViewController {

    
    //@IBOutlet var tv_word: UITextView! // 텍스트 출력 버튼

    @IBOutlet var tv_word: UIButton! // 텍스트 출력 버튼
    @IBOutlet var btn_left: UIButton! // 왼쪽 버튼 (비단어)
    @IBOutlet var btn_right: UIButton! // 오른쪽 버튼 (단어)

    var name : String = "" // 이름을 저장할 변수
    var information : String = "" // 모든 정보(인적 사항)를 저장할 변수
    var result : String = "" // 결과 정보를 저장할 변수
    
    var duration : Double = 0 // 단어가 제시되는 시간
    var latency : Double = 0// 단어를 클릭할 수 있는 시간
    var ITI : Double = 0 // 대기 시간
    
    var word_array : Array<String> = Array<String>() // word_array 배열 선언
    var random_number : Int = 0 // 랜덤 숫자
    var word_count : Int = 0 // 총 단어 개수
    
    var startTime : Int = 0 // 시작 시간
    var endTime : Int = 0 // 끝나는 시간
    var time : Int = 0 // click까지 걸린 시간
    
    var button_state : Bool = false // 버튼 클릭 상태
    
    var answer : Int = 0 // 정답 변수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tv_word.isEnabled = true // 버튼 비활성화
        tv_word.backgroundColor = UIColor.black 
        btn_left.backgroundColor = UIColor.black // 왼쪽 버튼 색 지정
        btn_right.backgroundColor = UIColor.black // 오른쪽 버튼 색 지정
        
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
    
    // 왼쪽 버튼 클릭했을 때
    @IBAction func Btn_left(_ sender: UIButton) {
        buttonClick(s: "2") // 매개변수가 "2"인 버튼 비활성화 함수 호출
    }
    
    // 오른쪽 버튼 클릭했을 떄
    @IBAction func Btn_right(_ sender: UIButton) {
        buttonClick(s: "1") // 매개변수가 "1"인 버튼 비활성화 함수 호출
    }
    
    // 버튼 비활성화 함수
    private func buttonClick(s : String){
        if(word_count == word_array.count){ // 처음 제시되었을 떄
            startTime = Int(CFAbsoluteTimeGetCurrent()) // 시작 시간을 startTime 에 저장
        }
        // 선택한 것(매개변수)이 정답인지 확인
        if((word_array[random_number].split(separator: ",")[3]).contains(s)){ // 정답일 경우
            answer = 1 // answer 에 1 저장
        }else{// 오답일 경우
            answer = 2 // answer 에 2 저장
        }
        
        endTime = Int(CFAbsoluteTimeGetCurrent()) // 클릭한 시간을 endTime에 저장
        time = endTime - startTime // 클릭할 때까지 걸린 시간을 계산한 후 time에 저장
        
        // word_array의 길이가 0인 경우 (모든 단어(자극) 제시)
        if(word_count == 0){
            button_state = false // 클릭한 것을 알림
            tv_word.backgroundColor = UIColor.darkGray // textView_word의 backgroundColor를 진한 회색으로 변경
            btn_left.isEnabled = false // 왼쪽 버튼 비활성화
            btn_right.isEnabled = false // 오른쪽 버튼 비활성화
            result = result + word_array[random_number] + "," + s + "," + String(answer) + "," + String(time) // result 변수에 저장
        } else{ // word_array의 길이가 0이 아닌 경우
            if(word_count != word_array[random_number].count){
                button_state = false // 클릭한 것을 알림
                tv_word.backgroundColor = UIColor.darkGray // textView_word의 backgroundColor를 진한 회색으로 변경
                btn_left.isEnabled = false // 왼쪽 버튼 비활성화
                btn_right.isEnabled = false // 오른쪽 버튼 비활성화
                result = result + word_array[random_number] + "," + s + "," + String(answer) + "," + String(time) + "<br/>" // result 변수에 저장
            }
        }
    }
    
    // 단어 제시(duration) Handler
    // #selector에 사용할 수 있는 메소드는 Objective-C 메소드여야 하기 때문에 Swift 함수 앞에 @objc 를 붙여줘야 함.
    @objc func dulation_Handler(){
        let duration_queue = DispatchQueue(label: "duration")
        duration_queue.sync {
            startTime = Int(CFAbsoluteTimeGetCurrent()) // 시작 시간을 startTime 에 저장
            button_state = true; // 클릭 상태 초기화
            print("duration")
            random_number = Int.random(in: 0..<word_count) // 0부터 word_count-1 사이의 random 정수를 random_number에 저장
            word_count -= 1; // 총 단어 개수 1 감소
            btn_left.isEnabled = true // 왼쪽 버튼 활성화
            btn_right.isEnabled = true // 오른쪽 버튼 활성화
            tv_word.setTitle(String(word_array[random_number].split(separator: ",")[1]), for: .normal) // random_number의 단어 출력
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
            if(button_state){ // 클릭을 하지 않았을 때(button_state = 0일 때)
                if (word_count == 0){ // 모든 단어가 제시되었을 떄
                    result = result + word_array[random_number] + "," + "3" + "," + "2" + "," + String(latency) // result 변수에 저장
                }else{ // 단어가 남았을 때
                    result = result + word_array[random_number] + "," + "3" + "," + "2" + "," + String(latency) + "<br/>" // result 변수에 저장
                }
            }
            
            if (word_count == 0){
                result = information + "<br/>ID,word,condition,correct,selection(선택),answer(정답),time(시간)<br/>" + result; // information 과 result 값을 합쳐 result 에 저장
                guard let link = storyboard?.instantiateViewController(withIdentifier: "Link") as? Link else{
                    return
                }
                link.paramname = name // name 값 실험준비(Link)로 전달
                link.paramresult = result // result 값 실험준비(Link)로 전달
                self.navigationController?.pushViewController(link, animated: true) // 화면 전환
                //self.removeFromParent() // viewController 종료
                return; // 함수 종료
            } else if(word_count == word_array.count){// 처음 제시되었을 때
                perform(#selector(dulation_Handler), with: nil, afterDelay: TimeInterval(ITI))
            } else{
                btn_left.isEnabled = false // 왼쪽 버튼 비활성화
                btn_right.isEnabled = false // 오른쪽 버튼 비활성화
                tv_word.backgroundColor = UIColor.black // textView_word 의 backgroundColor 를 검정색으로 변경
                word_array.remove(at: random_number)// word_array에서 random_number의 인덱스 삭제
                self.tv_word.setTitle(" [         ] " , for: .normal) // 텍스트 변경 (대기시간 나타냄)
                perform(#selector(dulation_Handler), with: nil, afterDelay: TimeInterval(ITI))
                print(123)
            }
        }
    }

}
