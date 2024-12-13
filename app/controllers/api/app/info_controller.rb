class Api::App::InfoController < ApplicationController
  def index
    info_json_file = Rails.root.join("info.json").read
    json = JSON.parse(info_json_file)
    render json: { version: json["version"], commit: json["sha"] || "n/a" }
  end
end
