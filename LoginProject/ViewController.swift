//
//  ViewController.swift
//  LoginProject
//
//  Created by 노민우 on 2023/01/07.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - email을 입력하는 Text View
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        /**
         * masksToBounds 와 clipsToBounds
         - masksToBounds : layer 의 프로퍼티
         - clipsToBounds :  UIView 의 프로퍼티 (자식들은 다 호출가능)
         * false의 경우 -> 안의 내용물((ex) text)이 짤리지 않음
         * true의 경우 -> view 의 기준으로 안의 내용물((ex) text)이 잘리게됨
         **/
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    // [Label] "이메일 또는 전화번호" 안내문구
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    // [TextField] 로그인 - 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48 // 높이 48
        tf.backgroundColor = .clear // .clear는 투명
        tf.textColor = .white
        tf.tintColor = .white // 시각적으로 화면상의 어떤요소가 현재 활성화되어있는지를 보여주는 요소
        tf.autocapitalizationType = .none // 앞의 글자를 자동으로 대문자로 바쭤 줄것인지
        tf.autocorrectionType = .no // 틀린글자가 있을때 자동으로 잡아(correction: 정정) 줄지
        tf.spellCheckingType = .no // 스펠링 체크
        tf.keyboardType = .emailAddress
        //        tf.addTarget(self(), action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호를 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        //        view.addSubview()
        //        view.addSubview()
        //        view.addSubview()
        return view
    }()
    
    // 패스워드 필드의 안내문구
    private var passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    // 로그인 비밀번호 입력 필드
    private let passwordField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true // 비밀번호를 가리는 설정
        tf.clearsContextBeforeDrawing = false // 그리기 전에 뷰의 경계를 자동으로 지울지 여부를 결정하는 값????
        //        tf.addTarget(self(), action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        button.addSubview(<#T##view: UIView##UIView#>)
        return button
    }()
    
    // MARK: - 로그인 버튼
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1 // 끄트머리 선의 넓이
        button.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.isEnabled = false // 버튼 동작설정 (false 비활성화)
//        button.addSubview(<#T##view: UIView##UIView#>)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18 // 내부 간격
        st.axis = .vertical // 세로로 묶을건지 가로로 묶을건지
        st.distribution = .fillEqually // 분배를 어떻게 할것인지
        st.alignment = .fill// 좌, 우 어디로 정렬할것인지 fill (완전히 채우는 설정)
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        view.addSubview(emailTextFieldView)
        
        // 정식 코드
        // AutoLayout을 잡을때는 translatesAutoresizingMaskIntoConstraints(자동으로 제약을 잡아주는) 비활성화 시켜줘야한다.
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        // emailInfoLabel을 emailTextFieldView 앞쪽(leadingAnchor)에 잡아주고 제약(constant)8만큼 뛰워준다.
        emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
        // emailInfoLabel을 emailTextFieldView 뒤쪽(trailingAnchor)에 잡아주고 제약(constant)8만큼 뛰워준다.
        emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8).isActive = true
        // emailInfoLabel을 emailTextFieldView 센터 emailTextFieldView을 기준으로(centerYAnchor)에 중앙에 맞춘다.
        emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor).isActive = true
        
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        // 중복 되는 isActive를 생략하기위해 NSLayoutConstraint.activate([])사용해 배열로 집어 넣어준다.
        NSLayoutConstraint.activate([
            // 앞
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            // 뒤
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            // 위
            emailTextField.topAnchor.constraint(equalTo: emailInfoLabel.topAnchor, constant: 15),
            // 아래
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2)
        ])
        
    }
}

#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
}

struct ViewController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            Preview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
        }
    }
}
#endif
