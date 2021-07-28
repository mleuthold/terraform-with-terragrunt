output "config_map_name" {
  value = kubernetes_config_map.example.metadata.0.name
}
