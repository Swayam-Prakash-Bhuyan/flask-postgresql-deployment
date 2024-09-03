output "cluster_id" {
  value = aws_eks_cluster.swayam_dev.id
}

output "node_group_id" {
  value = aws_eks_node_group.swayam_dev.id
}

output "vpc_id" {
  value = aws_vpc.swayam_dev_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.swayam_dev_subnet[*].id
}
