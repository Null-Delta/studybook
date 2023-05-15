module StudentsHelper
    class StudentEditingStrategy
        def isFieldEditable(field)
            return true
        end
    end

    class StudentFIOEditingStrategy
        def isFieldEditable(field)
            if field == 'firstname' || field =='lastname' || field == 'patronymic'
                return true
            end

            return false
        end
    end

    class StudentGitEditingStrategy
        def isFieldEditable(field)
            if field == 'git'
                return true
            end

            return false
        end
    end

    class StudentContactsEditingStrategy
        def isFieldEditable(field)
            if field == 'phone' || field =='email' || field == 'telegram'
                return true
            end

            return false
        end
    end
end
