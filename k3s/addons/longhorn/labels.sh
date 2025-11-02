#!/bin/bash

kubectl label node k3s-agent-01 longhorn.io/node=true
kubectl label node k3s-agent-02 longhorn.io/node=true
kubectl label node k3s-agent-03 longhorn.io/node=true