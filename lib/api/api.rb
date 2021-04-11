require 'api/users/root'
require 'api/tests/root'
require 'api/questions/root'
require 'api/recommends/root'
require 'api/search/root'
require 'api/profile/root'
require 'api/debug/root'
require 'api/constructor/root'
require 'api/api_helper'
module API
  class API < Grape::API
    helpers ApiHelper

    namespace 'v1' do
      mount Users::Root
      mount Tests::Root
      mount Questions::Root
      mount Recommends::Root
      mount Search::Root
      mount Profile::Root
      mount Debug::Root
      mount Constructor::Root
    end
  end
end