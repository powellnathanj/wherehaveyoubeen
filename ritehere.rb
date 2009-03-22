require 'rubygems'
require 'sinatra'
require 'sequel'

configure do
  db = Sequel.connect('sqlite://wherehaveyoubeen.db')
  unless db.table_exists?('urls')
    db.create_table :urls do
      primary_key :id
      text :url, :null => false
    end
  end
end

class Url < Sequel::Model; end

get "/where" do
  "Eventually this should be the listing of where I have been"
end

get "/here" do
  callback = "";
  url = "something went wrong"
  unless params[:url].nil?; url = params[:url]; end
  unless params[:callback].nil?; callback = params[:callback]; end
  Url.create(:url => url)

  return "#{callback}({'success':1})"
end
