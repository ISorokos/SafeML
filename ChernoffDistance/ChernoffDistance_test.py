import unittest

from ChernoffDistance.ChernoffDistance import chernoff_distance

class Test_ChernoffDistance(unittest.TestCase):
    def test_A(self):
        from math import log

        s = 0.5
        means = [[1, 2], [3, 4]]
        covs = [[[1, 0], [0, 1]], [[2, 0], [0, 2]]]
        msg = 'Test checks if chernoff_distance is correct for verified result'
        self.assertEqual(chernoff_distance(s, means, covs), 2/3 + 0.5 * log(9/8), msg)

    def test_B(self):
        s = 0.5
        mean = [1, 2]
        cov = [[1, 0], [0, 1]]
        msg = 'Test checks if chernoff_distance is 0 for the same distribution'
        self.assertAlmostEqual(chernoff_distance(s, [mean, mean], [cov, cov]), 0, msg)

    def test_C(self):
        s = 0.5

        for i in range(0, 12):
            with self.subTest(i=i):
                adjust = 10 ^ (-i)
                means = [[1, 2], [1 + adjust, 2 + adjust]]
                covs = [[[1, 0], [0, 1]], [[1 + adjust, 0], [0, 1 + adjust]]]
                msg = 'Test checks if chernoff_distance is non-zero for sufficiently different distributions'
                self.assertNotEqual(chernoff_distance(s, means, covs), 0, msg)

if __name__ == '__main__':
    unittest.main()
