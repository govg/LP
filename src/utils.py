import numpy as np

def irls(A, y, maxiter = 100, init = None, d = 0.001):

    N, D = A.shape

    assert N == y.shape[0], "Number of samples don't match"

    if init is None:
        x = np.ones((D, 1))
    else:
        x = init

    xiters = x.transpose()

    for i in range(maxiter):

        # Account for small values of x
        x[abs(x) < d] = d

        X = np.diagflat(x)

        intm1 = np.matmul(X, A.transpose())
        intm2 = np.linalg.pinv(np.matmul(A, intm1))
        intm3 = np.matmul(intm2, y)

        x = np.matmul(intm1, intm3)

        xiters = np.vstack((xiters, x.transpose()))


    return xiters, x

def sparsitycount(X, eps = 0.1, support = None):

    counts = np.zeros((X.shape[0], 1))

    for i in range(X.shape[0]):
        counts[i] += (abs(X[i, :]) > eps).sum()

    return counts

def normlist(X):

    norms = np.zeros((X.shape[0], 1))

    for i in range(X.shape[0]):
        norms[i] = np.linalg.norm(X[i])

    return norms

def diffs(X):

    diff = np.zeros((X.shape[0] - 1, X.shape[1]))

    for i in range(X.shape[0] - 1):
        diff[i, :] = X[i+1, :] - X[i, :]

    return diff

