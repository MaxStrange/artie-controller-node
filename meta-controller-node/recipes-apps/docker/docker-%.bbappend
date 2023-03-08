SUMMARY = "Recipe for adding a Docker configuration file."
DESCRIPTION = "${SUMMARY}"

# We place some JSON files here and need to combine them
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
JSON_FRAGMENTS = "${S}/daemon-fragment.json"

# Run a Python script to combine all the JSON fragments into one
python combine_jsons() {
    import json
    basejsonfpath = f"{d.getVar('S')}/daemon.json"
    with open(basejsonfpath, 'r') as f:
        basejson = json.load(f)

    combined = basejson
    json_fragments_fpaths = d.getVar('JSON_FRAGMENTS')
    for fpath in json_fragments_fpaths.split(','):
        with open(fpath, 'r') as f:
            fragmentjson = json.load(f)
            combined.update(fragmentjson)

    combined_fpath = f"{d.getVar('S')}/daemon-combined.json"
    with open(combined_fpath, 'w') as f:
        json.dump(combined, f, indent=2)
}
do_install[prefuncs] += " combine_jsons"

# Add the combined daemon.json into the right location for Docker to pick it up
do_install:append() {
    install -d ${D}${sysconfdir}/docker
    install -m 0644 ${WORKDIR}/daemon-combined.json ${D}${sysconfdir}/docker/daemon.json
}
