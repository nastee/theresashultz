require 'spec_helper'

describe Cat do
  let(:cat)     { FactoryGirl.create(:cat) }
  let(:called)  { SecureRandom.hex }
  let(:string)  { SecureRandom.hex.to_s }
  
  subject { FactoryGirl.create(:cat) }
  
  context 'attributes' do
    %w(id file_name original_url url created_at updated_at).each do |attr|
      it { should respond_to attr.to_sym }
    end
  end
  
  ### Class methods
  context 'class methods' do
    
  end
  
  ### Instances methods
  context 'instances methods' do
    context '.http' do
      it 'it should return a valid http url' do
        cat.stub(:http).and_return string
        cat.http(1).should == string
      end
    end
  end
end
