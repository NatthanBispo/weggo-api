class Api::ApiController < ActionController::API
  include ApiTokenAuthenticatable
  include ApiCommonResponses

  respond_to :json

  protected

  def serialize_resource(resource, serializer, scope: nil)
    JSON.parse(serializer.new(resource, scope: scope).to_json)
  end

  def serialize_resource_list(resources, serializer, params = {})
    JSON.parse(ActiveModelSerializers::SerializableResource.new(resources,
                                                                each_serializer: serializer,
                                                                params: params)
                                                                .to_json)
  end

end
