output "formatted_project_name" {
  value = local.formatted_project_name
}

output "string_function_examples" {
  value = {
    lower_name   = local.formatted_project_name
    upper_name   = local.project_name_upper
    slug_name    = local.project_name_slug
    words        = local.project_name_parts
    joined_name  = local.joined_project_name
    trimmed_name = local.trimmed_project_name
    name_prefix  = local.project_name_prefix
  }
}

output "numeric_function_examples" {
  value = {
    max_port     = local.max_port
    min_port     = local.min_port
    rounded_cost = local.rounded_cost
  }
}

output "collection_function_examples" {
  value = {
    port_count      = local.port_count
    first_port      = local.first_port
    merged_tags     = local.merged_tags
    unique_ports    = local.unique_ports
    flattened_ports = local.flattened_ports
    tag_keys        = local.tag_keys
    tag_values      = local.tag_values
  }
}

output "type_conversion_examples" {
  value = {
    server_count_number = local.server_count_number
    ports_as_strings    = local.ports_as_strings
    ports_as_set        = local.ports_as_set
    ports_from_set      = local.ports_from_set
    tags_from_object    = local.tags_from_object
  }
}

output "lookup_function_example" {
  value = local.selected_instance_type
}

output "error_handling_function_examples" {
  value = {
    first_tag_key       = local.first_tag_key
    has_fourth_port     = local.has_fourth_port
    optional_port_value = local.optional_port_value
    effective_region    = local.effective_region
  }
}

output "file_function_example" {
  value = local.notes_first_line
}

output "json_function_examples" {
  value = {
    encoded_tags = local.tags_json
    decoded_tags = local.decoded_tags_json
  }
}

output "datetime_function_example" {
  value = local.build_timestamp
}
