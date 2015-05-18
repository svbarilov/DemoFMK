class App

  class << self

    def register_page_object(klass)
      method_name = klass.name.scan(/[A-Z][a-z]+/).map(&:downcase).join('_').to_sym
      return if self.method_defined?(method_name)

      define_method(method_name) do
        klass.new
      end
    end

  end

end