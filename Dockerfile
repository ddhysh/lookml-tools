FROM python:3.6.4

WORKDIR /workspaces/lookml-tools

# apt-getのリポジトリを修正
RUN echo "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main" > /etc/apt/sources.list \
    && echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" > /etc/apt/apt.conf.d/10no-check

# システムパッケージのインストール（--force-yes追加）
RUN apt-get update && \
    apt-get install -y --force-yes graphviz sudo

# pipを特定のバージョンに固定
RUN pip install --no-cache-dir pip==20.3.4 \
    && pip install --no-cache-dir setuptools==44.0.0 \
    && pip install --no-cache-dir setuptools_scm==6.4.2

# COPYパスを修正
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY lkmltools ./lkmltools
COPY test ./test