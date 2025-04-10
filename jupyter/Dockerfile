FROM python:3.12-slim

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    JUPYTER_PORT=8888 \
    JUPYTER_DIR=/opt/jupyter

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a workspace directory
WORKDIR $JUPYTER_DIR
COPY . /

# Install Jupyter and required Python packages
RUN pip install --no-cache-dir -r /requirements.txt
RUN mkdir -p $JUPYTER_DIR/workspace

# Expose Jupyter port
EXPOSE $JUPYTER_PORT

# Set up Jupyter notebook config
RUN jupyter notebook --generate-config -y && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> ~/.jupyter/jupyter_notebook_config.py  
# Disable token auth

# Start Jupyter when the container runs
CMD ["jupyter", "notebook", "--notebook-dir=/opt/jupyter/workspace", "--allow-root"]
