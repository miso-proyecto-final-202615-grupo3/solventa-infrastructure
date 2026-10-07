resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  username_attributes = var.username_attributes

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  schema {
    name                = "company_name"
    attribute_data_type = "String"
    required            = false
    mutable             = true
  }

  tags = merge(var.tags, { Name = var.user_pool_name })
}

resource "aws_cognito_user_pool_client" "this" {
  count = length(var.client_names)

  name                         = var.client_names[count.index]
  user_pool_id                 = aws_cognito_user_pool.this.id
  allowed_oauth_scopes         = var.allowed_oauth_scopes
  supported_identity_providers = var.supported_identity_providers
  generate_secret              = var.generate_secret
  callback_urls                = var.callback_urls
  logout_urls                  = var.logout_urls
}
