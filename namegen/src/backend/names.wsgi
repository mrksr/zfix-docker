#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask
import numpy as np
import markov as m

application = Flask(__name__)
mythM = np.load('myth.npy')
maleM = np.load('male.npy')
femaleM = np.load('female.npy')

def getName(matrix):
    name = ''
    while not name:
        candidate = ''.join(m.noTriConsonants(m.toLetters(m.sample(matrix))))
        if len(candidate) >= 3 and len(candidate) <= 12:
            name = candidate
    name = name[0].upper() + name[1:]
    return name

@application.route("/dynamic/myth")
def myth():
    return getName(mythM)

@application.route("/dynamic/male")
def male():
    return getName(maleM)

@application.route("/dynamic/female")
def female():
    return getName(femaleM)

if __name__ == "__main__":
    application.run()
