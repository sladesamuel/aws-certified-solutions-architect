resource "aws_db_subnet_group" "db" {
  name = "${local.prefix}-rds-cluster-subnet-group"

  subnet_ids = [
    module.network.db_subnets.subnet_a,
    module.network.db_subnets.subnet_b
  ]

  tags = {
    Name = "${local.prefix}-rds-cluster-subnet-group"
  }
}

resource "aws_rds_cluster" "db" {
  cluster_identifier   = "${local.prefix}-rds-cluster"
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.11.3"
  availability_zones   = ["eu-west-2a", "eu-west-2b"]
  database_name        = "inventory"
  master_username      = "dbadmin"
  master_password      = "LabPassword"
  db_subnet_group_name = aws_db_subnet_group.db.name

  tags = {
    Name = "${local.prefix}-rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "primary" {
  identifier           = "${local.prefix}-rds-cluster-primary-instance"
  cluster_identifier   = aws_rds_cluster.db.cluster_identifier
  instance_class       = "db.r4.large"
  engine               = aws_rds_cluster.db.engine
  engine_version       = aws_rds_cluster.db.engine_version
  db_subnet_group_name = aws_rds_cluster.db.db_subnet_group_name

  tags = {
    Name = "${local.prefix}-rds-cluster-primary-instance"
  }
}

resource "aws_rds_cluster_instance" "replica" {
  identifier           = "${local.prefix}-rds-cluster-replica-instance"
  cluster_identifier   = aws_rds_cluster.db.cluster_identifier
  instance_class       = "db.r5.large"
  engine               = aws_rds_cluster.db.engine
  engine_version       = aws_rds_cluster.db.engine_version
  db_subnet_group_name = aws_rds_cluster.db.db_subnet_group_name

  tags = {
    Name = "${local.prefix}-rds-cluster-replica-instance"
  }
}
