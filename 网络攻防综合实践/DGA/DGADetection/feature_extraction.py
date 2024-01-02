# -*- coding: utf-8 -*-
"""
Created on 2020/9/13 18:11

__author__ = "Congyi Deng"
__copyright__ = "Copyright (c) 2021 NKAMG"
__license__ = "GPL"
__contact__ = "dengcongyi0701@163.com"

Description:

"""
import re
import pickle
import math
import wordfreq
import operator
import string
import numpy as np
import pandas as pd
from collections import Counter, defaultdict
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import tld

#————————读取统计依赖文件————————
gib_add = r"./static/gib_model.pki"
white_file_add = r"./data/sample/sample_white.csv"
black_file_add = r"./data/sample/sample_black.csv"
accepted_chars = 'abcdefghijklmnopqrstuvwxyz '
pos = dict([(char, idx) for idx, char in enumerate(accepted_chars)])
DGATLD_LIST = ['email', 'fit', 'tk', 'fail', 'run', 'rest', 'ml', 'cn', 'viajes', 'cf', 'recipes', 'gq', 'ga']
#————————END————————

# 特征存放文件夹
feature_dir = r"./data/feature"
# 模型存放文件夹
model_dir = r"./data/model"


def get_name(url):
    """
    用python自带库进行域名提取
    :param url: url
    :return: 二级域名，顶级域名
    """
    url = url.strip(string.punctuation)             #string.punctuation将给出所有的标点符号。去除url前后所有符号
    try:
        TLD = tld.get_tld(url, as_object=True, fix_protocol=True)
        SLD = tld.get_tld(url, as_object=True, fix_protocol=True).domain

    except Exception as e:
        na_list = url.split(".")
        TLD = na_list[-1]
        SLD = na_list[-2]
    return str(TLD), str(SLD)

def cal_rep_cart(ns):
    """
    计算字符串中重复出现的字符个数
    :param SLD: 字符串
    :return: 重复字符个数
    """
    count = Counter(i for i in ns).most_common()
    sum_n = 0
    for letter, cnt in count:
        if cnt > 1:
            sum_n += 1
    return sum_n

def cal_gib(SLD):
    """
    计算gib标签
    :param SLD:
    :return: 1: 正常 0: 异常
    """
    gib_model = pickle.load(open(gib_add, 'rb'))
    mat = gib_model['mat']
    threshold = gib_model['thresh']

    log_prob = 0.0
    transition_ct = 0
    SLD = re.sub("[^a-z]", "", SLD)
    gram2 = [SLD[i:i + 2] for i in range(len(SLD) - 1)]
    for a, b in gram2:
        log_prob += mat[pos[a]][pos[b]]
        transition_ct += 1
    # The exponentiation translates from log probs to probs.
    prob = math.exp(log_prob / (transition_ct or 1))
    return int(prob > threshold)


def load_gramdict():
    """
    加载n元排序字典
    :return: 字典
    """
    rank_dict = dict()
    with open(gramfile_add, 'r') as f:
        for line in f:
            cat, gram, freq, rank = line.strip().split(',')
            rank_dict[gram] = int(rank)
    return rank_dict



def get_feature(dn):
    """
    域名特征提取
    :param dn: 域名
    :return: 15维特征
    """
    TLD, SLD = get_name(dn)
    url = SLD + "." + TLD
    url_rm = re.sub(r"\.|_|-", "", url)
    TLD_rm = re.sub(r"\.|_|-", "", TLD)
    SLD_rm = re.sub(r"\.|_|-", "", SLD)
    #ADD BY ZiyueShi
    # 1. 域名总长度
    domain_len = len(url)
    # 2. SLD长度
    sld_len = len(SLD)
    # 3. TLD长度，请补充
    tld_len = len(TLD)
    # 4. 是否包含某些恶意顶级域名 https://www.spamhaus.org/statistics/tlds/
    flag_dgatld = 0
    for t in DGATLD_LIST:
        if t in url:
            flag_dgatld = 1
    # 5. 域名字符总数（去重）
    uni_domain = len(set(url_rm))
    # 6. SLD字符总数（去重）
    uni_sld = len(set(SLD_rm))
    # 7. TLD字符总数（去重），请补充
    uni_tld = len(set(TLD_rm))
    # 8. SLD中数字总数，请补充
    digits_sld = len(re.findall(r"[0-9]", SLD))
    # 9. SLD中数字占比，请补充
    digits_ratio_sld = digits_sld/ sld_len
    # 10. 特殊符号在SLD中占比
    sym_ratio_sld = len(re.findall(r"_|-", SLD)) / sld_len
    # 11. 十六进制字符在SLD中占比，请补充
    hex_ratio_sld = len(re.findall(r"[0-9a-fA-F]",SLD)) / sld_len
    # 12. 元音字母在SLD中占比
    vow_ratio_sld = len(re.findall(r"a|e|i|o|u", SLD)) / sld_len
    # 13. 辅音字母在SLD中占比，请补充
    con_ratio_sld = len(re.findall(r"b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|y|z", SLD)) / sld_len
    # 14. SLD中重复字符/字符总数（去重）
    rep_char_ratio_sld= cal_rep_cart(SLD_rm) / uni_sld
    # 15. SLD中连续辅音占比
    con_list = re.findall(r"[b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|y|z]{2,}", SLD)
    con_len = [len(con) for con in con_list]
    cons_con_ratio_sld = sum(con_len) / sld_len
    # 16. SLD中连续数字占比，请补充
    digits_list_sld = re.findall(r"[0-9]{2,}", url)
    dig_len = [len(dig) for dig in digits_list_sld]
    cons_dig_ratio_sld = sum(dig_len) / sld_len
    # 17. SLDgib成文检测
    sld_gib = cal_gib(SLD)

    #MODIFIED BY ZiyueShi
    # feature = [domain_len, sld_len, flag_dgatld, uni_domain, uni_sld, sym_ratio_sld, vow_ratio_sld,
    #            rep_char_ratio_sld, cons_con_ratio_sld, sld_gib]
    feature = [domain_len,sld_len,tld_len,flag_dgatld,uni_domain,
               uni_sld,uni_tld,digits_sld,digits_ratio_sld,sym_ratio_sld,
               hex_ratio_sld,vow_ratio_sld,con_ratio_sld,rep_char_ratio_sld,cons_con_ratio_sld,
               cons_dig_ratio_sld,sld_gib]
    return feature

def feature_extraction(df):

    """
    特征提取, 归一化
    :param df:
    :return:
    """
    #MODIFIED BY ZiyueShi
    # col = ["domain_name", "label", "domain_len", "sld_len", "flag_dgatld", "uni_domain", "uni_sld", "sym_ratio_sld",
    #        "vow_ratio_sld", "rep_char_ratio_sld", "cons_con_ratio_sld", "sld_gib"]
    col = ["domain_name", "label","domain_len","sld_len","tld_len","flag_dgatld","uni_domain",
           "uni_sld","uni_tld","digits_sld","digits_ratio_sld","sym_ratio_sld",
           "hex_ratio_sld","vow_ratio_sld","con_ratio_sld","rep_char_ratio_sld","cons_con_ratio_sld",
           "cons_dig_ratio_sld","sld_gib"]
    fea_list = list()
    for ind in df.index:
        fea = df.loc[ind].tolist()
        if ind % 1000 == 0:
            print("{}...".format(ind))
        fea.extend(get_feature(df.at[ind, 0]))
        fea_list.append(fea)
    fea_df = pd.DataFrame(fea_list, columns=col)

    return fea_df


def dataset_generation():
    """
    数据集划分,
    :return:
    """

    bk_df = pd.read_csv(black_file_add, header=None)
    wh_df = pd.read_csv(white_file_add, header=None)

    df = bk_df.append(wh_df, ignore_index=True)
    df_train, df_test = train_test_split(df, test_size=0.2, stratify=df[1], random_state=23)
    df_train = df_train.reset_index(drop=True)
    df_test = df_test.reset_index(drop=True)

    print("__________Generating Train Set__________")
    train_feature = feature_extraction(df_train)
    # train_feature.to_csv(r"{}\raw_train_features.csv".format(feature_dir), index=None)
    train_feature = train_feature.set_index(['domain_name', 'label'])
    standardScaler = StandardScaler()#标准化工具
    standardScaler.fit(train_feature.values)

    print("__________Generating Test Set__________")
    test_feature = feature_extraction(df_test)
    # test_feature.to_csv(r"{}\raw_test_features.csv".format(feature_dir), index=None)
    test_feature = test_feature.set_index(['domain_name', 'label'])

    train_feature = pd.DataFrame(standardScaler.transform(train_feature), index=train_feature.index,
                                 columns=train_feature.columns)
    train_feature = train_feature.reset_index()
    train_feature.to_csv(r"{}/train_features.csv".format(feature_dir), index=None)
    test_feature = pd.DataFrame(standardScaler.transform(test_feature), index=test_feature.index,
                                columns=test_feature.columns)
    test_feature = test_feature.reset_index()
    test_feature.to_csv(r"{}/test_features.csv".format(feature_dir), index=None)
    pickle.dump(standardScaler, open(r"{}/standardscalar.pkl".format(model_dir), 'wb'))
    return

if __name__ == "__main__":
    dataset_generation()



