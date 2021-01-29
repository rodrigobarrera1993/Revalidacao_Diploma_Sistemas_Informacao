class Site::WelcomeController < SiteController
    http_basic_authenticate_with name: "sistemas_informacao", password: "1993", only: "index"
    def index
        
    end
    
end
