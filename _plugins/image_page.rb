module Jekyll
  class ImagePage < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      process(@name)
      read_yaml(base, 'index.html')
      data['images'] = Image.all
    end
  end

  class GeneratorImage < Generator
    safe true

    def generate(site)
      Dir.chdir(site.source)
      image = ImagePage.new(site, site.source, "/")
      image.render(site.layouts, site.site_payload)
      image.write(site.dest)

      site.pages << image
      site.static_files << image
    end
  end
end
