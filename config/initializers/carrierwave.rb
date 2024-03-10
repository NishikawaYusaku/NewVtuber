
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
	CarrierWave.configure do |config|
	  config.fog_credentials = {
	  	provider: 'AWS',
	    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
	    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
	    region: 'ap-northeast-1',
	  }

	  config.fog_directory  = 'newvtuber'
	  config.cache_storage = :fog
	  config.fog_provider = 'fog/aws'
	  config.fog_public = false
	end
end

# S3のバケットに設定していたポリシー
=begin
{
	"Version": "2012-10-17",
	"Id": "Policy1706344998797",
	"Statement": [
		{
			"Sid": "Stmt1706344992452",
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::624415733626:user/S3_newvtuber"
			},
			"Action": "*",
			"Resource": "arn:aws:s3:::newvtuber/*"
		}
	]
}
=end
