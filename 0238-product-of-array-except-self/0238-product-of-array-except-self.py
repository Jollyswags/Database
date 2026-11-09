class Solution:
    def productExceptSelf(self, nums: list[int]) -> list[int]:
        length=len(nums)
        pre, suf, res=  [0] * length, [0] * length, [0] * length
        pre[0]=1
        suf[len(nums)-1]=1
        for i in range(1, len(nums)):
            pre[i]=pre[i-1]*nums[i-1]
        for i in reversed(range(len(nums)-1)):
            suf[i]=suf[i+1]*nums[i+1]
        for i in range(0,len(nums)):
            res[i]=pre[i]*suf[i]
        return res

            
        