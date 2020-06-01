require_relative '../services/basic_service'

class CreateService
  prepend BasicService

  option :ad do
    option :title
    option :description
    option :city
    option :user_id
  end

  attr_reader :ad

  def call
    @ad = ::Ad.new(@ad.to_h)
    return fail!(@ad.errors.full_messages) unless @ad.save(raise_on_failure: false)

    # GeocodingJob.perform_later(@ad)
  end
end
