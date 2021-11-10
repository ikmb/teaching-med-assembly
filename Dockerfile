FROM nfcore/base
LABEL authors="Marc Hoeppner" \
      description="Docker image containing all requirements for IKMB exome pipeline"

COPY environment.yml /
COPY FastaStat.pl /
RUN conda env create -f /environment.yml && conda clean -a
RUN mkdir -p /opt/bin && mv /FasatStat.pl /opt/bin && chmod +x /opt/bin/FastaStat.pl

ENV PATH /opt/conda/envs/teaching-assembly-2021/bin:/opt/bin:$PATH

