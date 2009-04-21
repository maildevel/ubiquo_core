require File.dirname(__FILE__) + "/../test_helper.rb"
require 'mocha'

class Ubiquo::AdaptersTest < ActiveSupport::TestCase
  def test_sequences
    ActiveRecord::Base.connection.create_sequence(:test)
    
    (1..10).each do |i|
      assert_equal i, ActiveRecord::Base.connection.next_val_sequence(:test)
    end
    
    ActiveRecord::Base.connection.drop_sequence(:test)
    assert_raises ActiveRecord::StatementInvalid do
      ActiveRecord::Base.connection.next_val_sequence(:test)
    end
  end
  
  def test_create_sequence
    ActiveRecord::Base.connection.expects(:create_sequence).with("test_content_id").once
    
    definition = nil
    ActiveRecord::Base.connection.create_table(:test){|table|
      definition = table
      table.sequence :test, :content_id
    }
    assert_not_nil definition[:content_id]
  end
  
  
end