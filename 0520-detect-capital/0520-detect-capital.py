class Solution:
    def detectCapitalUse(self, word: str) -> bool:
        upper=0
        lower=0
        for l in word:
            if l.isupper()==True:
                upper+=1
            else:
                lower+=1
        if upper==len(word) or lower==len(word) or (word[0].isupper()==True and lower==len(word)-1):
            return True
        else:
            return False
        return True
        
        