resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
    require_uppercase = false
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  sign_in_policy {
    # allowed_first_auth_factors
    # "PASSWORD": Traditional username/password authentication.
    # "EMAIL_OTP": Passwordless sign-in via a one-time passcode sent to the user's email.
    allowed_first_auth_factors = var.allowed_first_auth_factors
  }

  tags = merge(var.tags, { Name = var.user_pool_name })
}

resource "aws_cognito_user_pool_client" "this" {
  count = length(var.client_names)

  name                 = var.client_names[count.index]
  user_pool_id         = aws_cognito_user_pool.this.id
  allowed_oauth_scopes = var.allowed_oauth_scopes

  # explicit_auth_flows
  # ALLOW_USER_AUTH: Allows clients to exchange refresh tokens for new access tokens
  # ALLOW_REFRESH_TOKEN_AUTH: Powers choice-based authentication (PASSWORD & EMAIL_OTP)
  generate_secret     = var.generate_secret
  explicit_auth_flows = var.explicit_auth_flows

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls

  prevent_user_existence_errors = "ENABLED"
}
