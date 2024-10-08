FROM docker.io/library/clearlinux:latest

# Configure Go
ENV GOPATH /home/clr/go
ENV PATH="/home/clr/go/bin:${PATH}"

# Add bundles
RUN swupd bundle-add --skip-diskspace-check mixer os-clr-on-clr-dev user-basic-dev containers-basic-dev R-extras-dev sudo && \
    swupd clean --all && \
    useradd -G wheelnopw clr && \
    mkdir -p /run/lock
USER clr
RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name"
