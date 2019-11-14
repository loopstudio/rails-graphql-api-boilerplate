if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = lambda { |_context|
    'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.p32Tb_dytmQl2FhzdP6Tmwa4LBH4Ci_8_oit02Cw5H0'
  }
end
