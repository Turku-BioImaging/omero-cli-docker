FROM mambaorg/micromamba:0.23.2

USER root
RUN apt-get update && \
    apt-get install openjdk-11-jdk -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

USER $MAMBA_USER
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/env.yaml
RUN micromamba install -y -f /tmp/env.yaml && \
    micromamba clean --all --yes