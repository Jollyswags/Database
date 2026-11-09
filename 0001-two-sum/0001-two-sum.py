class Solution:
    def twoSum(self, nums: list[int], target: int) -> list[int]:
        map={}
        for i in range(len(nums)):
            x=nums[i]
            y=target-x
            if y in map:
                return [i,map[y]]
            map[nums[i]]=i
        return []