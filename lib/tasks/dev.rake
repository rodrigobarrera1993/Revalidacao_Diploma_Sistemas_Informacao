

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
      
      show_spinner("Criando Navios Padrão...", msg_end ="Fim da Criação de Navios Padrão.") {%x(rails dev:add_vessels)}
      show_spinner("Cadastrando Terminais...", msg_end ="Fim do Cadastro dos Terminais.") {%x(rails dev:add_terminals)}
      show_spinner("Cadastrando Manobras...", msg_end ="Fim do Cadastro de Manobras.") {%x(rails dev:add_maneuvers)}
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

  desc "Adiciona Vessels Default"
  task add_vessels: :environment do
    #Add 5 vessels that are in Suape port
    create_vessel("TOLTEN","636092678",299.94,45.63, "Containeiro", "https://photos.marinetraffic.com/ais/showphoto.aspx?shipid=755417&size=thumb600")
    create_vessel("PACIFIC ONYX","636015706",182.5,32.2, "Tanker", "https://photos.marinetraffic.com/ais/showphoto.aspx?shipid=755722&size=thumb600")
    create_vessel("SMIT TAMOIO","710010840",24.4,10.25, "Tugboat", "https://photos.marinetraffic.com/ais/showphoto.aspx?shipid=775157&size=thumb600")
    create_vessel("OSCAR NIEMEYER","710001694",117.25,19.2, "Tanker", "https://photos.marinetraffic.com/ais/showphoto.aspx?shipid=1966958&size=thumb600")
    create_vessel("BW PRINCESS","259726000",225.29,36.64, "Tanker", "https://photos.marinetraffic.com/ais/showphoto.aspx?shipid=314541&size=thumb600")
  end

  desc "Adiciona Terminals Default"
  task add_terminals: :environment do
    #Add 5 Suape Port Terminals
    create_terminal("TECON SUAPE", "Container", "https://cdn.folhape.com.br/img/c/1200/900/dn_arquivo/2018/09/por.jpg")
    create_terminal("TRANSPETRO", "Graneis Líquidos", "https://petrobras.com.br/data/files/DF/E7/B1/81/337B141071B09A146970E6A8/terminal-Suape_05.jpg")
    create_terminal("ULTRAGAZ", "Graneis Líquidos", "data:image/jpeg;base64,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")
    create_terminal("MINASGAS", "Graneis Líquidos", "https://i2.wp.com/naynneto.com.br/wp-content/uploads/2021/01/suape.png")
    create_terminal("AGROVIA DO NORDESTE", "Graneis Sólidos", "https://cdn-pen.nuneshost.com/images/190929-agrivia-d-nordeste-terminal-de-acucar-porto-de-suape.jpg")
  end

  desc "Adiciona Manobras"
  task add_maneuvers: :environment do
    array_maneuver_type = ["Entrada", "Saída"]
    (0..4).each do |value|
      vessel_obj = Vessel.find(rand(1..5).to_s)
      vessel_displacement = rand(1..55000)
      terminal_obj = Terminal.find(rand(1..5).to_s)
      operator_profile_obj = Operator.find(rand(1..5).to_s).operator_profile
      pilot_profile_obj = Pilot.find(rand(1..5).to_s).pilot_profile
      date_maneuver = Faker::Date.between(from: '2021-01-1', to: '2021-01-2')
      time_maneuver = Faker::Time.forward(days: 23, period: :all)
      type_maneuver = array_maneuver_type.sample
      relatory_obj = Relatory.create!
      create_maneuver(vessel_obj, vessel_displacement,terminal_obj,operator_profile_obj, pilot_profile_obj,
        date_maneuver, time_maneuver, type_maneuver, relatory_obj)
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

  def create_vessel(name = "default_name", mmsi="123456789",length=366,width=50,type_vessel="Containeiro",url_image="https://bloximages.newyork1.vip.townnews.com/postandcourier.com/content/tncms/assets/v3/editorial/c/48/c48dde36-fce6-11ea-ac0d-cf7c9d6ba53e/5f6a1599d0f46.image.jpg")
    Vessel.create!(name: name, mmsi: mmsi, length: length, width: width, type_vessel: type_vessel,
    url_image: url_image)
  end

  def create_terminal(name = "default_name", cargo="Container",url_image="https://cdn.folhape.com.br/img/c/1200/900/dn_arquivo/2018/09/por.jpg")
    Terminal.create!(name: name, cargo: cargo,url_image: url_image)
  end

  def create_maneuver(vessel_obj, vessel_displacement,terminal_obj,operator_profile_obj, pilot_profile_obj,
  date_maneuver, time_maneuver, type_maneuver, relatory_obj)
    Maneuver.create!(vessel: vessel_obj, vessel_displacement: vessel_displacement, terminal: terminal_obj,
    operator_profile: operator_profile_obj, pilot_profile: pilot_profile_obj, date_maneuver: date_maneuver,
    time_maneuver: time_maneuver, type_maneuver: type_maneuver, relatory: relatory_obj)
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
