class Image
  def self.all
    Dir.glob('photos/*.*').map do |image|
      new(File.basename(image)).to_hash
    end
  end

  def initialize(name)
    @name = name
  end

  def to_hash
    {
      'url'       => url,
      'thumb_url' => thumb_url
    }
  end

  private

  def url
    "/photos/#{@name}"
  end

  def thumb_url
    "/photos/thumb/#{@name}"
  end
end
