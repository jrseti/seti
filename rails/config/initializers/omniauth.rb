Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '4XkBJGIiCicyioal0j4DyA', 'tVxfBS9NaeUa6f3B7AcL9tpL7F76Q9Xr5EEuT4U0'
  provider :facebook, '201723139838082', '2b7f180d598b61763c686d50fbf7e546'
end