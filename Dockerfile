FROM mambaorg/micromamba:0.23.2

COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/env.yaml
RUN micromamba install -y -f /tmp/env.yaml && \
    micromamba clean --all --yes

RUN apt-get update && apt-get install openjdk-18-jre -y