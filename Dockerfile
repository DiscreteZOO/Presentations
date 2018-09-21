# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/dockerfile.html#preparing-your-dockerfile

# Temporary work around: the first 8.2 image that was pushed to dockerhub was incompatible
FROM sagemath/sagemath@sha256:e933509b105f36b9b7de892af847ade7753e058c5d9e0c0f280f591b85ad996d
# FROM sagemath/sagemath:8.2

# Copy the contents of the repo in ${HOME}
COPY --chown=sage:sage . ${HOME}

USER root
RUN    apt-get update -qq \
    && apt-get install -y git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER sage
RUN git clone --recursive https://github.com/DiscreteZOO/DiscreteZOO-sage.git ${HOME}/DiscreteZOO-sage
RUN mkdir ${HOME}/.discretezoo
RUN wget http://discretezoo.xyz/discretezoo.db -o ${HOME}/.discretezoo/discretezoo.db
RUN ln -s ${HOME}/DiscreteZOO-sage/discretezoo ${HOME}/discretezoo
