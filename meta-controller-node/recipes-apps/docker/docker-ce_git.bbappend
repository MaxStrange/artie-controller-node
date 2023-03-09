SUMMARY = "Recipe for adding a Docker configuration file."
DESCRIPTION = "${SUMMARY}"

# We place some JSON files here and need to combine them
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
JSON_FRAGMENTS = "${WORKDIR}/daemon-fragment.json"
SRC_URI += " file://daemon.json \
             file://daemon-fragment.json \
           "

# Run a Python script to combine all the JSON fragments into one
python combine_jsons() {
    import json
    basejsonfpath = f"{d.getVar('WORKDIR')}/daemon.json"
    with open(basejsonfpath, 'r') as f:
        basejson = json.load(f)

    combined = basejson
    json_fragments_fpaths = d.getVar('JSON_FRAGMENTS')
    for fpath in json_fragments_fpaths.split(','):
        with open(fpath, 'r') as f:
            fragmentjson = json.load(f)
            combined.update(fragmentjson)

    combined_fpath = f"{d.getVar('WORKDIR')}/daemon-combined.json"
    with open(combined_fpath, 'w') as f:
        json.dump(combined, f, indent=2)
}
do_install[prefuncs] += " combine_jsons"

# Add the combined daemon.json into the right location for Docker to pick it up
do_install:append() {
    # Install Docker into systemd (for some reason it doesn't work automatically)
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
    ln -s -r ${D}${nonarch_base_libdir}/systemd/system/docker.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/docker.service

    # Install the custom Docker configuration
    install -d ${D}${sysconfdir}/docker
    install -m 0644 ${WORKDIR}/daemon-combined.json ${D}${sysconfdir}/docker/daemon.json
}
