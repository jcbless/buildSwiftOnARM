#!/bin/sh

BRANCH=swift-4.2.1-branch
TAG=swift-4.2.1-RELEASE

echo "♻️ \033[1m Resetting the repositories...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo \\* Cleaning '{}' && cd '{}' && git reset --hard HEAD && git clean -fd" \;
echo "✳️ \033[1m Switching all the repositories to ${BRANCH} @ ${TAG}...\033[0m"
./swift/utils/update-checkout --scheme ${BRANCH} --tag ${TAG}
echo "✅ \033[1m Applying the required patches...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs ] && echo \\* Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/*.diff; do patch -p1 < \$f; done;" \;

cd clang-tools-extra
git checkout cb378eb3f37c25ae85546737c8ad442f3378e7e9
cd ..

cd icu
git checkout release-61-1
cd ..

cd libcxx
git checkout dffe9e0f1dde084f2aab8010345aeb1b7c8f7d4c
cd ..

cd ninja
git checkout 253e94c1fa511704baeb61cf69995bbf09ba435e
cd ..

cd swift-stress-tester
git checkout a7a6285a187300da18b4ee383b5acce5c5cd367f
cd ..

cd swift-syntax
git checkout aee69f4ee3dba695117d80e279eb2b0c5391512e
cd ..

