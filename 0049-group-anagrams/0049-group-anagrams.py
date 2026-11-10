class Solution:
    def groupAnagrams(self, strs: list[str]) -> list[list[str]]:
        dict={}
        for s in strs:
            sorted_s="".join(sorted(s))
            if sorted_s not in dict:
                dict[sorted_s]=[s]
            else:
                dict[sorted_s].append(s)
        return list(dict.values())