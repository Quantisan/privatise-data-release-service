FROM julia:0.3

ENV JULIA_VER=0.3
ENV JULIA_PKGDIR=/usr/local/.julia/

RUN apt-get update \
  # Required for HttpServer
  && apt-get install build-essential curl libgmp3-dev m4 p11-kit libcurl3 libcurl4-openssl-dev autogen -y \
  && julia -e 'Pkg.init()'

COPY REQUIRE $JULIA_PKGDIR/v$JULIA_VER/
RUN julia -e 'Pkg.resolve();' \
  # TODO this should be in package manager but Pkg.resolve can't clone a repo
  && julia -e 'Pkg.clone("https://github.com/mrtzh/PrivateMultiplicativeWeights.jl.git")'

WORKDIR /usr/src/app
ADD . /usr/src/app

ENTRYPOINT ["/usr/local/julia/bin/julia"]
CMD ["src/main.jl"]
EXPOSE 8000

