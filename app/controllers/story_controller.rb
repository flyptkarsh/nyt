class StoryController < ApplicationController

  def index
    @stories = HTTParty.get('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    @old_stories = HTTParty.get('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion.js')

    render :json => @stories.parsed_response
  end

  def show
   render  "story/show"
  end

end
