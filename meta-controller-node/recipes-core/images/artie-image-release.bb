DESCRIPTION = "Artie image for releases. Same as dev, but with added security."
LICENSE = "MIT"

inherit artie-image-base

# Remove debug-tweaks
# Add a non-root user as the default
# Force user to change password
# Add the user to i2c group
