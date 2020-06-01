require_relative 'models'
# require_relative 'services/basic_service'
require_relative 'services/create_service'
require_relative 'serializers/error_serializer'

require 'byebug'
require 'roda'

class Ads < Roda
  plugin :json, classes: [Array, Hash, Sequel::Model]
  plugin :json_parser
  plugin :all_verbs

  route do |r|
    r.is 'ads' do
      r.get do
        page = r.params[:page] || 1
        { ads: Ad.paginate(page, 20).order(Sequel.desc(:updated_at)).to_a }
      end

      r.post do
        result = CreateService.call(
            ad: ad_params(r),
        )

        if result.success?
          { ad: result.ad }
        else
          error_response(r, result.ad, 422)
        end
      end
    end
  end

  private

  def error_response(r, error_messages, status)
    errors = case error_messages
             when Ad
               ErrorSerializer.from_messages(error_messages.errors.full_messages)
             else
               ErrorSerializer.from_messages(error_messages)
             end

    response.status = status
    errors
  end

  def ad_params(r)
    { title: r.params['title'], description: r.params['description'], city: r.params['city'],
      user_id: r.params['user_id'] }
  end
end
