require_relative '../_plugins/image'

describe Image do

  describe 'self.all' do
    subject { Image.all }
    before do
      Dir.should_receive(:glob)
        .with('photos/*.*').and_return(images)
      Image.should_receive(:new)
        .with('foo.jpg').and_return(image_1)
      Image.should_receive(:new)
        .with('bar.jpg').and_return(image_2)
    end
    let(:images) { ['photos/foo.jpg', 'photos/bar.jpg'] }
    let(:image_1) { double(:image_1, to_hash: image_1_hash) }
    let(:image_2) { double(:image_2, to_hash: image_2_hash) }
    let(:image_1_hash) { double(:image_1_hash) }
    let(:image_2_hash) { double(:image_2_hash) }

    it { should == [image_1_hash, image_2_hash] }
  end

  describe 'to_hash' do
    subject { image.to_hash }
    let(:image) { Image.new('foo.jpg') }

    it { subject['url'].should == '/photos/foo.jpg' }
    it { subject['thumb_url'].should == '/photos/thumb/foo.jpg' }
  end
end
