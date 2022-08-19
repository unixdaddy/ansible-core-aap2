# login to the registry
podman login registry.redhat.io

# builder images
podman search registry.redhat.io/ansible-builder
podman search --list-tags registry.redhat.io/ansible-automation-platform-21/ansible-builder-rhel8

# 3 Base Images 
# minimal - only ansible.builtin - used for creating custom images
# supported - includes some of the collections supported by Red Hat
# 29 - compatibility with Ansible 2.9 - everything in it 
# search for minimal
podman search registry.redhat.io/ee-minimal-rhel8
podman search --list-tags registry.redhat.io/ansible-automation-platform-21/ee-minimal-rhel8
### search for all ee
podman search registry.redhat.io/ee-rhel8

#edit execution-environment.yml 

version: 1
build_arg_defaults:
  EE_BASE_IMAGE: 'ee-base-image-from-above'
  EE_BUILDER_IMAGE: 'ee-builder-image-from-above'
dependencies:
  galaxy: requirements.yml
  python: requirements.txt
  system: bindep.txt

rm -rf context
# create the structure but don't build
# Note: can copy your CUSTOM collection file into context directory
ansible-builder create
# Build and tag
ansible-builder build --tag localhost/my_images -v 3
