FROM ubuntu:bionic

LABEL dev.ssrf.pwn=""

RUN dpkg --add-architecture i386
RUN apt -y update && apt -y full-upgrade
RUN apt -y install ca-certificates
RUN apt -y install --no-install-recommends zsh vim git curl python
RUN apt -y install --no-install-recommends libc6:i386 libncurses5:i386 libstdc++6:i386 multiarch-support
RUN apt -y install --no-install-recommends build-essential gdb strace ltrace socat radare2
RUN apt -y install --no-install-recommends python3 python3-pip python3-dev libssl-dev libffi-dev
RUN rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install pip
RUN python3 -m pip install setuptools
RUN python3 -m pip install git+https://github.com/Gallopsled/pwntools.git@dev3

RUN git clone https://github.com/longld/peda /root/peda
RUN curl -sL dot.sqli.moe | bash
RUN curl -sL https://starship.rs/install.sh | bash -s -- --yes

COPY ./.gdbinit /root/.gdbinit
COPY ./.zshrc.local /root/.zshrc.local
COPY ./bin /root/bin

CMD ["echo", "hoge"]
