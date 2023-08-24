data "azurerm_subscription" "current" {
}

locals {
  sdp_read_user = "SDP_READ_USER"

  sdp_cft_environments_map = {
    sandbox  = "sbox"
    aat      = "dev"
    perftest = "test"
  }

  sdp_environment = lookup(local.sdp_cft_environments_map, var.env, var.env)

  sdp_vault = {
    name = "mi-vault-${local.sdp_environment}"
    rg   = "mi-${local.sdp_environment}-rg"
  }

  environment = {
    sbox = {
      subscription = "a8140a9e-f1b0-481f-a4de-09e2ee23f7ab"
    }
    dev = {
      subscription = "867a878b-cb68-4de5-9741-361ac9e178b6"
    }
    test = {
      subscription = "3eec5bde-7feb-4566-bfb6-805df6e10b90"
    }
    ithc = {
      subscription = "ba71a911-e0d6-4776-a1a6-079af1df7139"
    }
    stg = {
      subscription = "74dacd4f-a248-45bb-a2f0-af700dc4cf68"
    }
    prod = {
      subscription = "5ca62022-6aa2-4cee-aaa7-e7536c8d566c"
    }
  }
}
