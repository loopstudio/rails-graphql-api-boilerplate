shared_examples 'have http status' do |status, skip_request: false|
  specify '', skip_request: skip_request do
    expect(subject).to have_http_status(status)
  end
end

shared_examples 'have http status without errors' do |status, skip_request: false|
  include_examples 'have http status', status, skip_request: skip_request

  specify '', skip_request: skip_request do
    expect(errors).to be_nil
  end
end

shared_examples 'have http status with error' do |status, error, skip_request: false|
  include_examples 'have http status', status, skip_request: skip_request

  specify '', skip_request: skip_request do
    expect(errors).to include(error)
  end
end
