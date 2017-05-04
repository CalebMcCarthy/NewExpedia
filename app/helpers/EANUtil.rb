
module EANUtil

    class EANError < StandardError
        attr_reader :category, :msg

        def initialize(category = "no category provided", msg = "no information provided")
            @category = category
            super(msg)
        end

    end

end
