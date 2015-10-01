# [START docker]
FROM google/python
# [END docker]

ADD . /tmp

# [START system dependencies]
RUN echo '\n' >> /tmp/system-requirements.txt
RUN while read p; \
      do apt-get install -y $p; \
    done < /tmp/system-requirements.txt
# [END system dependencies]

# [START app environment]
RUN virtualenv /tmp/env
# [END app environment]

# [START install & configure wheel]
RUN /tmp/env/bin/pip install wheel
ENV PIP_WHEEL_DIR=/wheelhouse
ENV WHEELHOUSE=/wheelhouse
ENV PIP_FIND_LINKS=/wheelhouse
# [START install & configure wheel]

# [START create wheels]
RUN while read p; \
      do /tmp/env/bin/pip wheel $p; \
    done < /tmp/requirements.txt
# [END create wheels]

# [START cleanup]
RUN rm -rf /tmp/
# [END cleanup]
