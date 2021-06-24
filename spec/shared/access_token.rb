RSpec.shared_context 'admin', :shared_context => :metadata do
  let(:admin) {create(:user, :admin)}
  let(:access_token) {admin.jwt}
end

RSpec.configure do |rspec|
  rspec.include_context 'admin', include_shared: true
end