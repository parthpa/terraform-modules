locals {
  access_entries_from_users = {
    for u in var.map_users :
    u.username => {
      principal_arn     = u.userarn
      username          = u.username
      kubernetes_groups = u.groups
    }
  }
  worker_group_key = "${var.environment}-${var.cluster_name}-worker-group"
}
