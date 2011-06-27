class State < ActiveRecord::Base
has_one  :Linkrequest
has_one  :Signatures
    
end

