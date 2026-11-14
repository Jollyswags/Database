class Solution:
    def reverseWords(self, s: str) -> str:
        ls=[]
        for w in s.split(' '):
            ls.append(w[::-1])
        return " ".join(ls)