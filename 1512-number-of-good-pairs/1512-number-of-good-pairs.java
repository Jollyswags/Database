class Solution {
    public int numIdenticalPairs(int[] nums) {
         int l=nums.length;
        HashMap<Integer, Integer> map= new HashMap<>();
        int i;
        int count = 0;
    for(i=0;i<l;i++){
        if(map.containsKey(nums[i])){
            count += map.get(nums[i]);
            map.put(nums[i],map.get(nums[i])+1);
        }
        else
            map.put(nums[i],1);
    }
      return count;
    }
}
//n
//n