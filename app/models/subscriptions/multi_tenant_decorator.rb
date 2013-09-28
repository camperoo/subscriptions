module Subscriptions
  Subscriptions.model_names.each do |model|
    model.send(:include, Subscriptions::TenantedModel)
  end
end
