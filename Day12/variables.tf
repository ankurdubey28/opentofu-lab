variable "tags" {
  description = "Common tags to apply to Day12 resources"
  type        = map(string)

  default = {
    Environment = "dev"
    Project     = "opentofu-lab"
    Day         = "Day12"
    ManagedBy   = "OpenTofu"
  }
}
