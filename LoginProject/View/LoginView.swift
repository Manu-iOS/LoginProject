//
//  LoginView.swift
//  LoginProject
//
//  Created by 노민우 on 2023/01/22.
//

import UIKit

class LoginView: UIView {

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
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호를 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
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
    private let passwordTextField: UITextField = {
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
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 로그인 버튼
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1 // 끄트머리 선의 넓이
        button.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.isEnabled = false // 버튼 동작설정 (false 비활성화)
        button.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        return button
    }()
    // MARK: - stackView :: arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton]
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18 // 내부 간격
        st.axis = .vertical // 세로로 묶을건지 가로로 묶을건지
        st.distribution = .fillEqually // 분배를 어떻게 할것인지
        st.alignment = .fill// 좌, 우 어디로 정렬할것인지 fill (완전히 채우는 설정)
        return st
    }()
    
    // 비밀번호 재설정 버튼
    lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비민번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 3개의 각 텍스트 필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수 (애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    // MARK: - viewDidLoad()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI설정
    func makeUI() {
        backgroundColor = UIColor.black
        addSubview(stackView)
        addSubview(passwordResetButton)
        
        // AutoLayout을 잡을때는 translatesAutoresizingMaskIntoConstraints(자동으로 제약을 잡아주는) 비활성화 시켜줘야한다.
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 중복 되는 isActive를 생략하기위해 NSLayoutConstraint.activate([])사용해 배열로 집어 넣어준다.
        NSLayoutConstraint.activate([
            // emailInfoLabel을 emailTextFieldView 앞쪽(leadingAnchor)에 잡아주고 제약(constant)8만큼 뛰워준다.
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            // emailInfoLabel을 emailTextFieldView 뒤쪽(trailingAnchor)에 잡아주고 제약(constant)8만큼 뛰워준다.
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            // emailInfoLabel을 emailTextFieldView 센터 emailTextFieldView을 기준으로(centerYAnchor)에 중앙에 맞춘다.
            //emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
            emailInfoLabelCenterYConstraint,
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
            
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            //passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            passwordInfoLabelCenterYConstraint,
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            
            // 표시 버튼
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
            // stackView 오토레이아웃 설정
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: textViewHeight)
        ])
    }
    
    @objc func passwordSecureModeSetting(){
        print("표시버튼이 눌렸습니다.")
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func loginButtonTaped(){
        print("로그인 버튼이 눌렸습니다.")
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}

// MARK: - 확장
extension LoginView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아욱 업데이트 (글자를 위로 올림)
            emailInfoLabelCenterYConstraint.constant = -13
            print("emailTextField")
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트 (글자를 위로 올림)
            passwordInfoLabelCenterYConstraint.constant = -13
            print("emailTextField")
        }
        
        // 에니메이션 효과
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - textField 글자 크기 조절및 이동 메소드
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                // 글자를 위로 올림
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                // 글자를 위로 올림
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
    }
    
    // MARK: - textField에 따라 로그인 색 변경 메소드
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            // emailTextField.text 가 !email.isEmpty 비어있지 않다면 email 에 대입
            let email = emailTextField.text, !email.isEmpty,
            // passwordTextField.text 가 !password.isEmpty 비어있지 않다면 password 에 대입
            let password = passwordTextField.text, !password.isEmpty else {
            // 비어있다면 로그인 버튼 색은 흰색으로 변경 후 비활성화
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        } // 비어있지 않다면 로그인 버튼 색은 붉은색 변경 후 활성화
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
}
