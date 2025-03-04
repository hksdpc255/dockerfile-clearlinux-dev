FROM docker.io/library/clearlinux:latest

# Configure Go
ENV GOPATH /home/clr/go
ENV PATH="/home/clr/go/bin:${PATH}"

# Add bundles and misc patch
RUN swupd bundle-add --skip-diskspace-check \
        mixer os-clr-on-clr-dev user-basic-dev containers-basic-dev R-extras-dev cryptoprocessor-management-dev kde-frameworks5-dev clr-devops sudo \
        $(swupd bundle-list --all --has-dep=c-basic | awk '/[[:space:]]*c-extras-gcc[0-9]*[[:space:]]*$/{for(i=1;i<=NF;i++)if($i~"^c-extras-gcc[0-9]*$")print$i}') && \
    swupd clean --all && \
    mkdir -p /run/lock && \
    mv /usr/sbin/sss_cache /usr/sbin/sss_cache_ && \
    useradd -G wheelnopw clr && \
    usermod -p "*" root && \
    passwd -el root && \
    chage -d -1 -m -1 -M -1 -W -1 -I -1 -E -1 root
USER clr
RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name"
