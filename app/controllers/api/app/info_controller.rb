class Api::App::InfoController < ApplicationController
  def index
    package_json_file = Rails.root.join("package.json").read
    json = JSON.parse(package_json_file)
    render json: { version: json["version"], commit: json["sha"] || "n/a" }
  end
end
