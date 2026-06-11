"""Module extension: fetch the per-arch polyglot atlas olean from this repo's
GitHub release assets.

The private engine's release CI (gitlab aion/polyglot, `publish_atlas_olean`)
builds `polyglot_atlas-<os>_<arch>.tar.gz` and attaches it to the matching
`atlas-v<ver>` release here. `//lean:atlas` (a lean_imported_library) selects
the arch-matching archive — no engine source, no recompile.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_ATLAS_BUILD = """exports_files([".lean_root"])

filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

_BASE = "https://github.com/fastverk/rules_lang/releases/download/atlas-v0.1.0"

def _atlas_ext_impl(_ctx):
    http_archive(
        name = "polyglot_atlas_linux_x86_64",
        url = _BASE + "/polyglot_atlas-linux_x86_64.tar.gz",
        sha256 = "007aee5277d38b84de77caadf46353aff90fd47a08df00c41a1b28c9434c6e72",
        build_file_content = _ATLAS_BUILD,
    )
    http_archive(
        name = "polyglot_atlas_darwin_arm64",
        url = _BASE + "/polyglot_atlas-darwin_arm64.tar.gz",
        sha256 = "fc2dc919ba44e788d3bf37a99ab16a0cad431e3765c943f2357883d5e5384fb6",
        build_file_content = _ATLAS_BUILD,
    )

atlas_ext = module_extension(implementation = _atlas_ext_impl)
