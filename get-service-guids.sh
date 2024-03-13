#!/bin/bash

# get service plans as list
SERVICE_OFFERING=$(cf curl '/v3/service_offerings?per_page=5000' | jq -r '.resources[] | select(.name=='\"$1\"').guid')
SERVICE_PLANS=$(cf curl "/v3/service_plans?per_page=5000&service_offering_guids=$SERVICE_OFFERING" | jq -r '.resources[].guid' | tr '\n' ',')

# get service instance GUIDs
cf curl "/v3/service_instances?per_page=5000&service_plan_guids=$SERVICE_PLANS" | jq -r '.resources[].guid'
