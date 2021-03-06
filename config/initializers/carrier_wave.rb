CarrierWave.configure do |config|
  if Rails.env.production? 
    config.storage :fog                       
    config.fog_credentials = {
      provider:              'AWS',                        
      aws_access_key_id:     ENV['aws_access_key_id'],      # 你的 key           

      aws_secret_access_key: ENV['aws_secret_access_key'] ,      # 你的 secret key         

      region:                ENV['region']
    }
    config.fog_directory  = 'autherticate' # 你設定的 bucket name 

  else
    config.storage :file
  end
end