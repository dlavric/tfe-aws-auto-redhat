variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ServerForTFE"
}


variable "key_pair" {
  description = "Daniela's Key Pair from AWS west-2"
  type        = string
  default     = "daniela-key"
}