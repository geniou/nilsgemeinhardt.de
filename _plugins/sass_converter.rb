module Jekyll
  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      '.css'
    end

    def convert(content)
      engine(content).render
    end

    def engine(content)
      Sass::Engine.new(content, syntax: :scss, load_paths: ['./styles/'])
    end
  end
end
