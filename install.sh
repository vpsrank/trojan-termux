#更换国内源
cp $PREFIX/etc/apt/sources.list $PREFIX/etc/apt/sources.list.bak
echo "# The termux repository mirror from TUNA:
deb http://mirrors.tuna.tsinghua.edu.cn/termux stable main" >$PREFIX/etc/apt/sources.list

#trojan
pkg install git clang cmake boost-dev openssl-dev -y
git clone https://github.com/trojan-gfw/trojan
cd trojan
sed -i '/if(WIN32)/i\target_link_libraries(trojan atomic)' CMakeLists.txt
cmake -DCMAKE_INSTALL_PREFIX=/data/data/com.termux/files/usr -DENABLE_MYSQL=OFF .
make install

#trojan配置
cp -f /data/data/com.termux/files/usr/share/doc/trojan/examples/client.json-example /data/data/com.termux/files/usr/etc/trojan/config.json
read -p "输入trojan服务器域名:" domain && read -p "输入trojan密码:" password && sed -i "s/password1/$password/g;s/example.com/$domain/g" /data/data/com.termux/files/usr/etc/trojan/config.json
