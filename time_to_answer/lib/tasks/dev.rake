namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") {%x(rails db:drop)}
      show_spinner("Criando DB...") {%x(rails db:create)}
      show_spinner("Migrando tabelas DB...") {%x(rails db:migrate)}
      show_spinner("Cadastrando o Admin padrão...") {%x(rails dev:add_default_admin)}
      show_spinner("Cadastrando outros administradores...") {%x(rails dev:add_others_admin)}
      show_spinner("Cadastrando o Usuário padrão...") {%x(rails dev:add_default_user)}
    else
      puts "Você não está em um ambiente de desenvolvimento"
    end
  end

  desc "Adcionando Administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: "admin@admin.com",
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Criando administradores extras"
  task add_others_admin: :environment do
    10.times do 
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end
  
  desc "Adcionando Usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: "user@user.com",
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  private
  
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
