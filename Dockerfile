FROM getfemdoc/getfem:latest
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install the notebook package
RUN /venv/bin/pip3 install --no-cache --upgrade pip && \
    /venv/bin/pip3 install --no-cache notebook

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN . /venv/bin/activate && adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${USER}
