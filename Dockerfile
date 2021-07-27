FROM tensorflow/tensorflow:latest-devel-gpu

RUN apt-get update \
        && apt-get install -y \
        mesa-utils \
        cmake \
        build-essential \
        python3 \
        python3-pip

RUN mkdir -p /opt/python_env
WORKDIR /opt/python_env
COPY requirements.txt .
RUN pip install -U pip
RUN pip install -r requirements.txt

RUN pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user && \
    jupyter nbextension enable highlight_selected_word/main &&\
    jupyter nbextension enable hinterland/hinterland && \
    jupyter nbextension enable toc2/main
    
RUN pip install jedi==0.17.2
RUN apt-get install -y build-essential graphviz-dev graphviz pkg-config
RUN pip install graphviz

RUN ln -s /usr/local/cuda-11.2/targets/x86_64-linux/lib/libcusolver.so.11 /usr/local/cuda-11.2/targets/x86_64-linux/lib/libcusolver.so.10

ENV TF_FORCE_GPU_ALLOW_GROWTH=true
