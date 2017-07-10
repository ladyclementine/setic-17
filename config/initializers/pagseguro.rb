PagSeguro.configure do |config|
  if Rails.env.production?
    config.environment = :production
    config.token       = ENV['PAGSEGURO_TOKEN']
    config.email       = ENV['PAGSEGURO_EMAIL']
  else
    config.environment = :sandbox  # ou :sandbox. O padrão é production.
    config.token       = 'ED99460F3C75449E9F5F665AED134105'
    config.email       = 'pixelzip0@gmail.com'
  end
  config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end
