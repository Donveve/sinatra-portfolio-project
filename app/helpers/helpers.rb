class Helpers

    def self.current_user(session)
        Student.find_by(id: session[:id])
    end

    def self.current_teacher_user(session)

        Teacher.find_by(id: session[:id])
    end

    def self.is_logged_in?(session)
        !!session[:id]
    end
end
