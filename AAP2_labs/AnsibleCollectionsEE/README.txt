podman search registry.redhat.io/ansible-builder
podman search --list-tags registry.redhat.io/ansible-automation-platform-21/ansible-builder-rhel8
podman search registry.redhat.io/ee-minimal-rhel8
podman search --list-tags registry.redhat.io/ansible-automation-platform-21/ee-minimal-rhel8
podman login registry.redhat.io
edit execution-environment.yml 
version: 1
build_arg_defaults:
  EE_BASE_IMAGE: 'ee-base-image-from-above'
  EE_BUILDER_IMAGE: 'ee-builder-image-from-above'
dependencies:
  galaxy: requirements.yml
  python: requirements.txt
  system: bindep.txt

rm -rf context
ansible-builder create
Note: can copy your CUSTOM collection file into context directory
ansbile-builder build
