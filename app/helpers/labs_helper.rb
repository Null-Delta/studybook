module LabsHelper
    class LabNonEditingStrategy
        def isFieldEditable(field)
            return false
        end
    end

    class LabEditingStrategy
        def isFieldEditable(field)
            return true
        end
    end

end
