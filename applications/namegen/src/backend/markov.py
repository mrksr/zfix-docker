#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
import math

MEMORY = 2
vowels = ['a', 'e', 'i', 'o', 'u', 'ö', 'ü', 'ä', '^', '$']
revChars = ['^', '$', # Start and End of name
         'a', 'b', 'c', 'd', 'e', 'f',
         'g', 'h', 'i', 'j', 'k', 'l',
         'm', 'n', 'o', 'p', 'q', 'r',
         's', 't', 'u', 'v', 'w', 'x',
         'y', 'z', 'ö', 'ü', 'ä']
chars = dict(zip(revChars, range(len(revChars))))

def tupleToState(t):
    N = len(revChars)
    state = 0
    for c, exp in zip(t, range(MEMORY)):
        state += chars[c] * int(math.pow(N, exp))
    return state

def stateToLastChar(s):
    N = len(revChars)
    return revChars[s % N]

def validCharsOnly(s):
    return ''.join(c for c in s if c in revChars)

def readName(name, array):
    lists = ['^' * (MEMORY - n) + name + '$' * (n) for n in range(MEMORY + 1)]
    for tup in zip(*lists):
        i, j = tup[:-1], tup[1:]
        array[tupleToState(i), tupleToState(j)] += 1
    return array

def toTransitionMatrix(array):
    sums = array.sum(axis=1)
    array /= sums[:,np.newaxis]
    return array

def toLetters(name):
    return ''.join(map(lambda l: stateToLastChar(l), name))[MEMORY:-1]

def transition(current, matrix):
    return np.random.choice(matrix.shape[0], p=matrix[current,:])

def sample(matrix):
    smpl = [tupleToState(('^',) * MEMORY)]
    while not smpl[-1] == tupleToState(('$',) * MEMORY):
        smpl.append(transition(smpl[-1], matrix))
    return smpl

def noTriConsonants(name):
    for x, a, b in zip(name, name[1:] + '$', name[2:] + '$$'):
        if x in vowels or \
           a in vowels or \
           b in vowels:
            yield x

if __name__ == '__main__':
    import fileinput

    numStates = math.pow(len(chars), MEMORY)

    letters = np.zeros((numStates, numStates))
    letters[:, tupleToState(('$',) * MEMORY)] = 1

    for name in fileinput.input():
        name = validCharsOnly(name.lower())
        letters = readName(name, letters)

    letters = toTransitionMatrix(letters)

    names = []
    while len(names) < 15:
        candidate = ''.join(noTriConsonants(toLetters(sample(letters))))
        if len(candidate) >= 3 and len(candidate) <= 12:
            names.append(candidate)

    np.save('letters', letters)
    print('\n'.join(names))
