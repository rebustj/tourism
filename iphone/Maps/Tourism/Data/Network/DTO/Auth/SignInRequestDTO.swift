struct SignInRequestDTO: Codable {
    let email: String
    let google_id: String
}

extension SignInRequestDTO {
    init(from domainModel: SignInRequest) {
        self.email = domainModel.email
        self.google_id = domainModel.password
    }
}
