module Jekyll
  class ImageIndex < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      process(@name)
      read_yaml(base, 'index.html')
      data['images'] = images
    end

    def images
      [].tap do |images|
        Dir['photos/*.*'].each do |image|
          images << {
            'url' => "/photos/thumb/#{File.basename(image)}",
            'large_url' => "/photos/#{File.basename(image)}"
          }
        end
      end
    end
  end

  class GeneratorImage < Generator
    safe true

    def generate(site)
      Dir.chdir(site.source)
      image = ImageIndex.new(site, site.source, "/")
      image.render(site.layouts, site.site_payload)
      image.write(site.dest)

      site.pages << image
      site.static_files << image
    end
  end
end
