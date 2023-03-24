variable "AZ_BILLING_ACCOUNT_NAME" {
  type        = string
  description = "MAPS TO ENVIRONMENTAL VARIABLE TF_VAR_AZ_BILLING_ACCOUNT_NAME"
}

variable "AZ_BILLING_PROFILE_NAME" {
  type        = string
  description = "MAPS TO ENVIRONMENTAL VARIABLE TF_VAR_AZ_BILLING_PROFILE_NAME"
}

variable "AZ_INVOICE_SECTION_NAME" {
  type        = string
  description = "MAPS TO ENVIRONMENTAL VARIABLE TF_VAR_AZ_INVOICE_SECTION_NAME"
}

/*

export ARM_CLIENT_ID=" "
export ARM_CLIENT_SECRET=" "
export ARM_TENANT_ID=" "
export ARM_SUBSCRIPTION_ID=" "

az login
export TF_VAR_AZ_BILLING_ACCOUNT_NAME=$(az billing account list --query "[].name" -o tsv)
export TF_VAR_AZ_BILLING_PROFILE_NAME=$(az billing profile list --account-name $TF_VAR_AZ_BILLING_ACCOUNT_NAME --query "[].name" -o tsv)
export TF_VAR_AZ_INVOICE_SECTION_NAME=$(az billing invoice section list --account-name $TF_VAR_AZ_BILLING_ACCOUNT_NAME --profile-name $TF_VAR_AZ_BILLING_PROFILE_NAME --query "[].name" -o tsv)

*/