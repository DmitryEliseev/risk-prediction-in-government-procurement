#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
Конфигурация, доступная всем файлам
"""

import configparser

config = configparser.ConfigParser()
config.read('sys_config.ini', encoding='UTF8')
