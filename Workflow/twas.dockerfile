FROM gaow/base-notebook

MAINTAINER Gao Wang <wang.gao@columbia.edu>

WORKDIR /tmp
USER root

# PLINK

RUN wget http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200616.zip && \
    unzip plink_linux_x86_64_20200616.zip && mv plink /usr/local/bin && rm -rf /tmp/*

# GCTA
RUN wget https://cnsgenomics.com/software/gcta/bin/gcta_1.93.2beta.zip && \
    unzip gcta_1.93.2beta.zip && mv gcta_1.93.2beta/gcta64 /usr/local/bin && rm -rf /tmp/*

# GEMMA
RUN wget https://github.com/genetics-statistics/GEMMA/releases/download/0.98.1/gemma-0.98.1-linux-static.gz && \
    zcat gemma-0.98.1-linux-static.gz > /usr/local/bin/gemma && \
    chmod +x /usr/local/bin/gemma && rm -rf /tmp/*

# FUSION
ENV P2R_VERSION d74be015e8f54d662b96c6c2a52a614746f9030d
RUN wget https://github.com/gabraham/plink2R/archive/${P2R_VERSION}.zip && \
    unzip ${P2R_VERSION}.zip && \
    R --slave -e "install.packages(c('optparse','RColorBrewer', 'glmnet', 'RcppEigen'))" && \
    R --slave -e "install.packages('plink2R-${P2R_VERSION}/plink2R/',repos=NULL)" && \
    rm -rf /tmp/*

USER jovyan

# to build: docker build -t gaow/twas -f twas.dockerfile .