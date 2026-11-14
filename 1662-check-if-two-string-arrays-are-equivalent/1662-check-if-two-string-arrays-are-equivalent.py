class Solution:
    def arrayStringsAreEqual(self, word1: list[str], word2: list[str]) -> bool:
        s1="".join(word1)
        s2="".join(word2)
        if s1==s2:
            return True
        else:
            return False