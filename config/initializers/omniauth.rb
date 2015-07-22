require File.expand_path('lib/omniauth/strategies/custom', Rails.root)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :custom, '36144bd23631bdfe9a069c48959758a4bd05bc0e1431f5e919a22c2b777af091', 'c5663176dfd83b18d5a583e7a35b68db9adff599d6fd67a54f31dbf47b06cbb2', provider_ignores_state: true
end
