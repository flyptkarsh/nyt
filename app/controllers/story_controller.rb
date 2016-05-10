class StoryController < ApplicationController
  require 'open-uri'
  require 'json'

  def index

    stories = HTTParty.get('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    collections = JSON.parse( stories )["page"]["content"][1]["collections"]

    if params[:lang] == "Boinga"
      spanABTop = translate_assets_to_boinga( collections[0]["assets"])
      aColumn = translate_assets_to_boinga( collections[1]["assets"])
      bColumn = translate_assets_to_boinga( collections[2]["assets"])
      cColumn = translate_assets_to_boinga( collections[3]["assets"])
    else
      spanABTop = collections[0]["assets"]
      aColumn =  collections[1]["assets"]
      bColumn =  collections[2]["assets"]
      cColumn =  collections[3]["assets"]
    end
    @stories = [ spanABTop, aColumn, bColumn, cColumn ]
    render :json => @stories
  end

  def show
   render  "story/show"
  end

  private

  def translate_assets_to_boinga(assets)
    assets = assets.map do |a|
      a["headline"] = convert_to_boinga(a["headline"])
      a["original_headline"] = convert_to_boinga(a["original_headline"])
      a["summary"] = convert_to_boinga(a["summary"])
      a["original_summary"] = convert_to_boinga(a["original_summary"])
      a
    end
    return assets
  end

  def convert_to_boinga(string)
    a = string.split(" ")
    new_string = ""
    a.collect do |w|
      if w.length > 3
        if w.slice(0) == w.slice(0).upcase
          new_string = new_string + " Boinga" + w.gsub(/[a-zA-Z0-9\-]/,"")
        else
          new_string = new_string + " boinga" + w.gsub(/[a-zA-Z0-9\-]/,"")
        end
      else
        new_string = new_string + " " + w
      end
    end
    return new_string
  end


end
