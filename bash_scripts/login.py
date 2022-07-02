#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

wget_exec = "/usr/bin/wget"
user_name = "againxx"
user_password = "btt19930602"
wlt_url = "http://wlt.ustc.edu.cn/cgi-bin/ip"
log_file = "/dev/null"
page_file = "/tmp/wlt_state"
cookies = "/tmp/wlt_cookies"

export_type = ("教育网出口(国际,仅用教育网访问,适合看文献)",
               "电信网出口(国际,到教育网走教育网)",
               "联通网出口(国际,到教育网走教育网)",
               "电信网出口2(国际,到教育网免费地址走教育网)",
               "联通网出口2(国际,到教育网免费地址走教育网)",
               "电信网出口3(国际,默认电信,其他分流)",
               "联通网出口3(国际,默认联通,其他分流)",
               "教育网出口2(国际,默认教育网,其他分流)",
               "移动网出口(国际,无P2P或带宽限制)")

time_limit = (3600, 14400, 39600, 50400, 0)
time_limit_str = ("1小时", "4小时", "11小时", "14小时", "永久")

# 登录网络通，用--keep-session-cookies和--save-cookies得到Cookies 
login_cmd = "cmd=login"
# 这个输出页面不需要，只需要得到cookies 
wget_options = '-o {log_file} -O {log_file} --keep-session-cookies --save-cookies {cookies} --post-data "{cmd}&name={name}&password={password}"' \
               .format(log_file=log_file, cookies=cookies, cmd=login_cmd, name=user_name, password=user_password)
print(wget_options)
