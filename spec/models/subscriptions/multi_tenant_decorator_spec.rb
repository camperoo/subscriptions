require 'spec_helper'

Subscriptions.model_names.each do |model_name|

  describe model_name do
    describe '#tenant' do
      it "is defined" do
        model = model_name.new
        model.should respond_to(:tenant_id)
      end
    end
  end

end
