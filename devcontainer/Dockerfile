FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN curl -fsSL https://deno.land/install.sh | sh -s -- --no-modify-path && \
    mv /root/.deno/bin/deno /usr/local/bin/deno

# Install mise system-wide (like deno above) so it survives container rebuilds.
# mise then provisions uv + Python for the ./gq CLI from the repo's .mise.toml.
RUN curl -fsSL https://mise.run | MISE_INSTALL_PATH=/usr/local/bin/mise sh
