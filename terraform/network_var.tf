
variable "ep_vpc" {
  type        = map(string)
  description = "Infomartion utilisé pour le vpc de l'épreuve finale"
  default = {
    "vpc_plage_adr" = "10.0.0.0/16"
    "vpc_name"      = "VPC-EpreuveFinale"
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Plages d'adresses des sous-réseaux publics"
  default     = ["10.0.0.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Plages d'adresses des sous-réseaux privés"
  default     = ["10.0.1.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a"]
}

variable "internet_gateway" {
    type = string
    description = "Nom de la passerel internet"
    default = "epreuve-final-igw"
}

variable "public_route_table" {
    type = string
    description = "Nom de la table public pour le routage"
    default = "ep_public_route_table"
}

variable "private_route_table" {
  type = string
  description = "Nom de la table priver pour le routage"
  default = "ep_private_route_table"
}