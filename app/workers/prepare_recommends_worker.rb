require 'recommends/test_t_recommends'

class TestTemplatesRecommendsWorker
  include Sidekiq::Worker
  include Recommends::TestTemplates

  sidekiq_options queue: :recommendations

  def perform
    User.find_each(batch_size: 25) do |user|
      destroy_expired_recommends(user.recommends)

      return popular_init_seq if user.recommends.empty?

      popular_seq_by_tag!(user) # returns [{DateTime => [id1, id2, ... idn]}, ... ]
    end
  end
end