data "azurerm_billing_mca_account_scope" "LocalBillingScope" {
    billing_account_name = var.AZ_BILLING_ACCOUNT_NAME
    billing_profile_name = var.AZ_BILLING_PROFILE_NAME
    invoice_section_name = var.AZ_INVOICE_SECTION_NAME
}

resource "azurerm_subscription" "LocalSubscription" {
    for_each = toset(distinct([for subscription in local.iterations: subscription.subscription_name]))
    
    alias             = each.value
    subscription_name = each.value
    billing_scope_id  = data.azurerm_billing_mca_account_scope.LocalBillingScope.id
}

resource "azurerm_management_group" "LocalParentManagementGroup" {
    for_each = toset(distinct([for parent in local.iterations: parent.parent_management_group]))
    display_name = each.value
    
    depends_on = [
        azurerm_subscription.LocalSubscription
    ]
}

resource "azurerm_management_group" "LocalChildManagementGroup" {
    for_each = {
        for i in flatten([
            for parent, child_mgmtgrps in local.child_mgmtgrps:[
                for child in child_mgmtgrps: {
                    parent   = parent
                    child = child
                }
            ]
        ]):
        "${i.parent}.${i.child}" => {
            parent_display_name = i.parent
            child_display_name = i.child
        }
    }    


    display_name               = each.value.child_display_name
    parent_management_group_id = azurerm_management_group.LocalParentManagementGroup[each.value.parent_display_name].id
    
    depends_on = [
        azurerm_management_group.LocalParentManagementGroup,
    ]
}

resource "azurerm_management_group_subscription_association" "LocalMgmtGrpSubAssoc" {
    for_each = {
        for i in flatten([
            for mgmtgrp, associations in local.associations:[
                for sub in associations: {
                    mgmtgrp = mgmtgrp
                    sub = sub
                }
            ]
        ]):
        "${i.mgmtgrp}.${i.sub}" => {
            management_group_name = i.mgmtgrp
            subscription_name = i.sub
        }
    }  


  management_group_id = azurerm_management_group.LocalChildManagementGroup[each.value.management_group_name].id
  subscription_id     = azurerm_subscription.LocalSubscription[each.value.subscription_name].id
}
