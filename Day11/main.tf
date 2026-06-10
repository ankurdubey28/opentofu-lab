locals {
  # String functions
  formatted_project_name = lower(var.project_name)
  project_name_upper     = upper(var.project_name)
  project_name_slug      = replace(lower(var.project_name), " ", "-")
  project_name_parts     = split(" ", lower(var.project_name))
  joined_project_name    = join("-", local.project_name_parts)
  trimmed_project_name   = trimspace(var.raw_project_name)
  project_name_prefix    = substr(local.trimmed_project_name, 0, 7)

  # Numeric functions
  max_port     = max(var.ports...)
  min_port     = min(var.ports...)
  rounded_cost = ceil(var.monthly_cost)

  # Collection functions
  port_count      = length(var.ports)
  first_port      = element(var.ports, 0)
  merged_tags     = merge(var.default_tags, var.extra_tags)
  unique_ports    = distinct(concat(var.ports, [443, 8080]))
  flattened_ports = flatten(var.nested_ports)
  tag_keys        = keys(local.merged_tags)
  tag_values      = values(local.merged_tags)

  # Type conversion functions
  server_count_number = tonumber(var.server_count)
  ports_as_strings    = [for port in var.ports : tostring(port)]
  ports_as_set        = toset(var.ports)
  ports_from_set      = tolist(local.ports_as_set)
  tags_from_object    = tomap(local.merged_tags)

  # Lookup function
  selected_instance_type = lookup(var.environment_instance_types, var.environment, "t2.micro")
  effective_region       = coalesce(var.preferred_region, var.fallback_region)

  # Error handling functions
  first_tag_key       = try(local.tag_keys[0], "no-tag")
  has_fourth_port     = can(var.ports[3])
  optional_port_value = try(var.ports[3], 0)

  # File function
  notes_first_line = split("\n", file("${path.module}/notes.txt"))[0]

  # JSON functions
  tags_json         = jsonencode(local.merged_tags)
  decoded_tags_json = jsondecode(local.tags_json)

  # Date and time functions
  build_timestamp = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}
