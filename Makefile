# The MIT License (MIT)
#
# Copyright (c) 2019 Jesper Pedersen <jesper.pedersen@redhat.com>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software
# is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
IMAGE_NAME = openshift-pgsql12-primary-centos7

.PHONY: build
build:
	docker build --no-cache -t $(IMAGE_NAME) .
	docker tag openshift-pgsql12-primary-centos7 quay.io/redhatdemo/openshift-pgsql12-primary:centos7
	docker tag openshift-pgsql12-primary-centos7 quay.io/redhatdemo/openshift-pgsql12-primary:latest
	docker push quay.io/redhatdemo/openshift-pgsql12-primary:centos7
	docker push quay.io/redhatdemo/openshift-pgsql12-primary:latest

