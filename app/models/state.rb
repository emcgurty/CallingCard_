class State < ActiveRecord::Base
has_one  :Linkrequests
has_one  :Signatures
    
end

