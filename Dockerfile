FROM getfemdoc/getfem:latest
ENV DEBIAN_FRONTEND noninteractive
RUN source /venv/bin/activate

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER root
COPY . ${HOME}
RUN pip install -r requirements.txt
RUN chown -R ${NB_USER} ${HOME}
USER ${USER}
