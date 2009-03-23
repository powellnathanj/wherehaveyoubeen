require 'rubygems'
require 'sinatra'
require 'sequel'

configure do
  db = Sequel.connect('sqlite://wherehaveyoubeen.db')
  unless db.table_exists?('urls')
    db.create_table :urls do
      primary_key :id
      text :url, :null => false
      datetime :visit_time, :null => false
    end
  end
end

class Url < Sequel::Model; end

get "/" do
  redirect "/where"
end

get "/where" do
  @urls = Url.all
  erb :where
end

get "/here" do
  callback = "";
  url = "something went wrong"

  unless params[:url].nil?; url = params[:url]; end
  unless params[:callback].nil?; callback = params[:callback]; end

  Url.create(:url => url, :visit_time => Time.now)

  return "({'success':1})"
end
