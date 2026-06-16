"""Module extensions for this language module."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def _download_plugins(module_ctx):
    """Download plugins."""

    # Breaking plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.71.0", "darwin-arm64", "455fdebef6afd85d18c2593d80b4545ac637620e2025c68b89f99d0b503e9f6f"),
        ("v1.71.0", "darwin-x86_64", "0c717ceaeea7cf6b0b0a26c65c95d204e24aa69799a1e10d3b9043f35633b639"),
        ("v1.71.0", "linux-arm64", "925a9c466e18a6803b89364b7306d8a3ad4517005c79f8a064d23593763481e7"),
        ("v1.71.0", "linux-x86_64", "86df2635b2cf6a32f3d2c19bf187899650f372204c0987b935373696ef70d95f"),
        ("v1.71.0", "windows-arm64", "670b54ea542ca02fd5cbed09d2741ba3ec59159b355a18993d56641e2d719396"),
        ("v1.71.0", "windows-x86_64", "fa1e3b023c295476137284d84d0333c5fbceb67e801f202d43a7b15ec9c263b5"),
    ]:
        http_file(
            name = "buf_breaking_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/{0}/protoc-gen-buf-breaking-{1}{2}".format(
                version,
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    # Lint plugin
    for version, platform, hash in [
        # renovate-gh-plugin: bufbuild/buf
        ("v1.71.0", "darwin-arm64", "33602deb9c8a7b547b7e22d77a4bd843ea68b15c64e50afa26d838739d47b8ee"),
        ("v1.71.0", "darwin-x86_64", "effa4482476cdb36ad79f25f473eba283f8da86aec53885c532b1d2b8fbd0d1f"),
        ("v1.71.0", "linux-arm64", "3ae5fb371be514e44e3c7a1d1575d8bc67c977159b216eb5bf4152d898b94496"),
        ("v1.71.0", "linux-x86_64", "018abc4d811d3061fa7eadcd0d97bd32d6897f0c8f270286eba3ab66b67e7d5c"),
        ("v1.71.0", "windows-arm64", "69e77d50adc415b61981b7b16f91ca509b70f0e505c2c92e03c1f4cec4fcd0dc"),
        ("v1.71.0", "windows-x86_64", "e405a2e1fdda0094e245842a46a649a1a63b938a0e8a0f9d50fc8264f5a66291"),
    ]:
        http_file(
            name = "buf_lint_plugin_{}".format(platform.replace("-", "_")),
            executable = True,
            sha256 = hash,
            url = "https://github.com/bufbuild/buf/releases/download/{0}/protoc-gen-buf-lint-{1}{2}".format(
                version,
                ("linux-aarch64" if platform == "linux-arm64" else platform).title(),
                ".exe" if "windows" in platform else "",
            ),
        )

    return module_ctx.extension_metadata(
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

download_plugins = module_extension(
    implementation = _download_plugins,
)
