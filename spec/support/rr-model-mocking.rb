require 'rr/adapters/rspec'

module RspecRailsRR
  
  def have_received(method = nil)
    RR::Adapters::Rspec::InvocationMatcher.new(method)
  end

  module ActiveModelExtensions

    def as_new_record
      stub(self).persisted? { false }
      stub(self).id { nil }
      self
    end

    def persisted?
      true
    end

  end

  module ActiveRecordExtensions
    
    def as_new_record
      self.__send__("id=", nil)
      super
    end

    def new_record?
      !persisted?
    end

    def connection
      raise RSpec::Rails::IllegalDataAccessException.new("stubbed models are not allowed to access the database")
    end
    
  end

  def stub_model(model_class, stubs={})
    stubs = stubs.reverse_merge(:id => next_id)
    model_class.new.tap do |m|
      m.extend ActiveModelExtensions
      m.extend ActiveRecordExtensions
      stubs.each do |k,v|
        if m.respond_to?("#{k}=")
          m.send("#{k}=", v)
        else
          stub(m).__send__(k) { v }
        end
      end
      yield m if block_given?
    end
  end

  @@model_id = 1000

  def next_id
    @@model_id += 1
  end
      
end

RSpec.configure do |config|
  config.include RspecRailsRR
end

