class Solution:
    def groupAnagrams(self, strs: list[str]) -> list[list[str]]:
        map = {}

        for s in strs:
            sorted_s = "".join(sorted(s))

            if sorted_s not in map:
                map[sorted_s] = [s]
            else:
                map[sorted_s].append(s)

        return list(map.values())
