class Solution:
    def runningSum(self, nums: list[int]) -> list[int]:
        sum=0
        ls=[]
        for i in range(0,len(nums)):
            sum=sum+nums[i]
            ls.append(sum)
        return ls
        