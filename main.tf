module "management-groups-subscriptions-workflow" {
    source = "./modules/management-groups-subscriptions-workflow"
    
    AZ_BILLING_ACCOUNT_NAME = var.AZ_BILLING_ACCOUNT_NAME
    AZ_BILLING_PROFILE_NAME = var.AZ_BILLING_PROFILE_NAME
    AZ_INVOICE_SECTION_NAME = var.AZ_INVOICE_SECTION_NAME
    
}