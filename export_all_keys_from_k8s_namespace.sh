#!/bin/sh
export NAMESPACE=...

for i in `kubectl -n ${NAMESPACE} get secret --no-headers | awk '{print $1}'`
do
  echo "Dumping ${i}"
  kubectl -n ${NAMESPACE} get secret ${i} -o yaml \
   | yq d - 'metadata.resourceVersion' \
    | yq d - 'metadata.uid' \
    | yq d - 'metadata.annotations' \
    | yq d - 'metadata.creationTimestamp' \
    | yq d - 'metadata.selfLink' > ${i}
done
