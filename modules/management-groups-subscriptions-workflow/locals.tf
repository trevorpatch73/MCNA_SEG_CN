locals {
  iterations = csvdecode(file("./data/management-groups-subscriptions-workflow.csv"))


  child_mgmtgrps = {
      for a, b in {
          for iteration in local.iterations : iteration.parent_management_group => iteration.child_management_group...
      }
      : a => distinct(b)
  }
  
  associations = {
      for a, b in {
          for iteration in local.iterations : "${iteration.parent_management_group}.${iteration.child_management_group}" => iteration.subscription_name...
      }
      : a => distinct(b)
  }
  
}