RSpec::Matchers.define :render_error_code do |expected|
  match do |_actual|
    json[:errors]&.first&.dig(:extensions, :code).to_s == expected.to_s
  end

  failure_message do |_actual|
    "Expected request to render in the json a status code of #{expected} but #{reason}" \
    "\nThe json obtained was: #{json}"
  end

  def reason
    errors = json[:errors]
    return "it did not contain the key 'errors'." unless errors

    error = errors.first
    return "'errors' was empty." unless error

    actual_code = error.dig(:extensions, :code)
    return "no 'code' key was present." unless actual_code

    "it was #{actual_code}"
  end
end
