# yq

<https://github.com/mikefarah/yq>

```bash
git remote add upstream git@github.com:mikefarah/yq.git

git fetch upstream

git merge v4.9.8
```

## build

```bash
# cross
docker run -it \
--rm \
-v $PWD/:/go/src/github.com/mikefarah/yq/v4 \
-w /go/src/github.com/mikefarah/yq/v4 \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.22 \
bash .beagle/build.sh

# loong64
docker run -it \
--rm \
-v $PWD/:/go/src/github.com/mikefarah/yq/v4 \
-w /go/src/github.com/mikefarah/yq/v4 \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.22-loongnix \
bash .beagle/build-loong64.sh
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="yq" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="yq" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
