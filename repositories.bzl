load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

PANDOC_VERSION = "3.1.13"

BUILD_CONTENT_UNIX = """
filegroup(
    name = "pandoc",
    srcs = ["bin/pandoc"],
    visibility = ["//visibility:public"],
)"""

BUILD_CONTENT_WINDOWS = """
filegroup(
    name = "pandoc",
    srcs = ["pandoc.exe"],
    visibility = ["//visibility:public"],
)"""

def pandoc_repositories():
    http_archive(
        name = "pandoc_bin_linux-arm64",
        build_file_content = BUILD_CONTENT_UNIX,
        sha256 = "678c09ac4227c88b491f6e75491e6da871fd08d79b8c0f0ee37b611f01ad3d25",
        strip_prefix = "pandoc-{v}".format(v = PANDOC_VERSION),
        url = "https://github.com/jgm/pandoc/releases/download/{v}/pandoc-{v}-linux-arm64.tar.gz".format(v = PANDOC_VERSION),
    )

    http_archive(
        name = "pandoc_bin_linux-x86_64",
        build_file_content = BUILD_CONTENT_UNIX,
        sha256 = "db556c98cf207d2fddc088d12d2e2f367d9401784d4a3e914b068fa895dcf3f0",
        strip_prefix = "pandoc-{v}".format(v = PANDOC_VERSION),
        url = "https://github.com/jgm/pandoc/releases/download/{v}/pandoc-{v}-linux-amd64.tar.gz".format(v = PANDOC_VERSION),
    )

    http_archive(
        name = "pandoc_bin_macOS-x86_64",
        build_file_content = BUILD_CONTENT_UNIX,
        sha256 = "324995643ab4273be9b52e1bfd88f4909d9238f3dafd49cb1681a8ca374336bd",
        strip_prefix = "pandoc-{v}-x86_64".format(v = PANDOC_VERSION),
        url = "https://github.com/jgm/pandoc/releases/download/{v}/pandoc-{v}-x86_64-macOS.zip".format(v = PANDOC_VERSION),
    )

    http_archive(
        name = "pandoc_bin_macOS-arm64",
        build_file_content = BUILD_CONTENT_UNIX,
        sha256 = "76b1722c81f0f9349b6eef1bf387226f2eb277a7ed47641475b9edb53403b980",
        strip_prefix = "pandoc-{v}-arm64".format(v = PANDOC_VERSION),
        url = "https://github.com/jgm/pandoc/releases/download/{v}/pandoc-{v}-arm64-macOS.zip".format(v = PANDOC_VERSION),
    )

    http_archive(
        name = "pandoc_bin_windows-x86_64",
        build_file_content = BUILD_CONTENT_WINDOWS,
        sha256 = "347b250e855d0cb4bf9e7dcda3b55a2b5bdae588e637a363810008b75be5ca81",
        url = "https://github.com/jgm/pandoc/releases/download/{v}/pandoc-{v}-windows-x86_64.zip".format(v = PANDOC_VERSION),
    )

    native.register_toolchains(
        "@bazel_pandoc//:pandoc_toolchain_linux-arm64",
        "@bazel_pandoc//:pandoc_toolchain_linux-x86_64",
        "@bazel_pandoc//:pandoc_toolchain_macOS-arm64",
        "@bazel_pandoc//:pandoc_toolchain_macOS-x86_64",
        "@bazel_pandoc//:pandoc_toolchain_windows-x86_64",
    )
