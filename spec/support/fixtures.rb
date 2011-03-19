def image_fixture_file(name)
  Pathname("#{Rails.root}/spec/fixtures/images/#{name}")
end

def test_tmp_dir
  @test_tmp_dir ||= "#{Rails.root}/tmp/spec"
  FileUtils.mkpath(@test_tmp_dir)
  @test_tmp_dir
end
