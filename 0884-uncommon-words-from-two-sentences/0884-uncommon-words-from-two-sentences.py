class Solution:
    def uncommonFromSentences(self, s1: str, s2: str) -> list[str]:
        map={}
        for w in s1.split():
            if w not in map:
                map[w]=1
            else:
                map[w]=map[w]+1
        map2={}
        for w in s2.split():
            if w not in map2:
                map2[w]=1
            else:
                map2[w]=map2[w]+1
        
        ls=[]
        for key in map.keys():
            if key not in map2 and map[key]==1:
                ls.append(key)
        for key in map2.keys():
            if key not in map and map2[key]==1:
                ls.append(key)
        return ls
            
        