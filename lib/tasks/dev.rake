

 DEFAULT_PASSWORD  = "123456"

namespace :dev do
  desc "Restaura Banco de Dados para default"
  task restore_db: :environment do
    if Rails.env.development?
      show_spinner("Deletando Banco de Dados ...", msg_end ="Banco de Dados Deletado com Sucesso") do
        puts %x(rails db:drop:_unsafe)
      end
      show_spinner("Criando Banco de Dados ...", msg_end ="Banco de Dados Criado com Sucesso") do
        puts %x(rails db:create)
      end
      #quando em apenas uma linha, yield pode ser substituido por {}
      show_spinner("Iniciando Migração...", msg_end ="Migração Finalizada com Sucesso") {%x(rails db:migrate)}
      
      #Adiciona Pratico padrão
      show_spinner("Cadastrando Prático Default", msg_end ="Fim do Cadastro de Prático Default") do
        %x(rails dev:add_default_pilot)
      end

      #Adiciona Operador default
      show_spinner("Cadastrando Operador Default", msg_end ="Fim do Cadastro do Operador Default") do
        %x(rails dev:add_default_operator)
      end

      #Adiciona Operadores Extra
      show_spinner("Iniciando Cadastro de Operadores Extras...", msg_end ="Fim do Cadastro de Operadores Extras") {%x(rails dev:add_extra_operators)}
      
      #Adiciona praticos Extra
      show_spinner("Iniciando Cadastro de praticos Extras...", msg_end ="Fim do Cadastro de Praticos Extras") {%x(rails dev:add_extra_pilots)}
      
      #show_spinner("Criando Assuntos Padrão...", msg_end ="Fim da Criação de Assuntos Padrão.") {%x(rails dev:add_subjects)}
      #show_spinner("Cadastrando Perguntas e Respostas...", msg_end ="Fim do Cadastro de Perguntas e Respostas") {%x(rails dev:add_answers_and_questions)}
    else
      puts "Alterações não realizadas. Environment não é Desenvolvimento"
    end

  end

  desc "Adiciona Operador Default"
  task add_default_operator: :environment do
      #cria o model Operator
      operator_obj = Operator.create!(
        email: 'operador@operador.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
      #cria o model OperatorProfile associado ao model Pilot
      OperatorProfile.create!(create_operator_profile_params(operator_obj))
  end

  desc "Adiciona Operadores Extras"
  task add_extra_operators: :environment do
    10.times do |i|
       #cria o model Operator
        operator_obj = Operator.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
      #cria o model OperatorProfile associado ao model Pilot
      OperatorProfile.create!(create_operator_profile_params(operator_obj))
    end
   
  end

  desc "Adiciona Prático Default"
  task add_default_pilot: :environment do
    #cria o model Pilot
    pilot_obj = Pilot.create!(
      email: 'pratico@pratico.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
    #cria o model PilotProfile associado ao model Pilot
    PilotProfile.create!(create_pilot_profile_params(pilot_obj))
  end

  desc "Adiciona Práticos Extras"
  task add_extra_pilots: :environment do
    10.times do |i|
      #cria o model Pilot
      pilot_obj = Pilot.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
      #cria o model PilotProfile associado ao model Pilot
      PilotProfile.create!(create_pilot_profile_params(pilot_obj))
    end
   
  end

  desc "Adiciona assuntos padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line| 
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        #Cria a estrutura das questões junto com seus parametros associados
        params = create_question_params(subject)
        answer_array = params[:question][:answers_attributes]
        #Cria de 2 a 5 respostas por questão
        add_answers(answer_array)

        #escolhe uma aleatoria para ser a verdadeira
        elect_true_answer(answer_array)

        Question.create!(params[:question])
      end
    end
  end

  
  desc "Reseta o contador dos assuntos"
  task reset_subject_counter: :environment do
    show_spinner("Resetando questions_num counter no subject...", msg_end ="Fim do Reset") do
        Subject.find_each do |subject|
          Subject.reset_counters(subject.id, :questions)
        end
    end


  end


end

private
  def create_pilot_profile_params(pilot_obj)
    {
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name, 
      address: Faker::Address.street_address,
      birthdate: Faker::Date.between(from: '1950-09-23', to: '2020-09-25'),
      pilot: pilot_obj
    }
  end

  def create_operator_profile_params(operator_obj)
    {
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name, 
      address: Faker::Address.street_address,
      birthdate: Faker::Date.between(from: '1950-09-23', to: '2020-09-25'),
      operator: operator_obj
    }
  end

  def create_answer_params(correct = false)
    {description: Faker::Lorem.sentence, correct: correct}
  end

  def add_answers(answer_array = [])
    rand(2..5).times do |j|
      answer_array.push(
        create_answer_params(false)
      )
    end
  end

  def elect_true_answer(answer_array = [])
    index = rand(answer_array.size)
    answer_array[index] = create_answer_params(true)
  end

  def show_spinner(msg_start, msg_end ="Concluído")
    spinner = TTY::Spinner.new(":spinner #{msg_start}", format: :bouncing_ball)
    spinner.auto_spin
    yield
    spinner.stop("#{msg_end}")
  end
