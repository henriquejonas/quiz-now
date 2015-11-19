# Disponibiliza globalmente o objeto APP_CONFIG que pode ser utilizado
# pela aplicação para obter os valores definidos em config/app_config.yml
raw_config = File.read("#{Rails.root}/config/app_config.yml")
raw_config = ERB.new(raw_config).result # para processar códigos ERB

# APP_CONFIG = YAML.load(raw_config)['constants'].symbolize_keys
APP_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys