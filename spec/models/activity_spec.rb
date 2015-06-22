require 'spec_helper'

describe Activity do
  #pending "add some examples to (or delete) #{__FILE__}"
# responds to action, 
let(:activity){ create(:activity)}
it {should respond_to(:action)}
end
