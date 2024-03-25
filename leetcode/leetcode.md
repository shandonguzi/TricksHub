# 一、C++11 tips

```c++
// 1.容器——vector
#include<vector>
vector<int> a(10) | vector<string> b | vector c(5, 1)  // 初始化，a共10个内存空间，c是5个1
vector<int> (3, 1) | vector<int> {1, 2, 3}             // 其他初始化方式
vector<int>(a.begin(), a.end())                        // 用a赋值，a可以是vector<int>，也可以是unordered_set<int>
.push_back(5) | .pop_back()                            // 尾部添加或删除元素
.size() | .resize(10)                                  // 返回vector大小，重新定义大小
.back() | .front()                                     // 返回vector首部或尾部元素的引用
.begin() | .end()                                      // 返回vector<int>::iterator，用于遍历
.insert(a.begin(), 5) | .insert(a.begin()+1, 3, 5)     // 位置0插入5，位置1插入3个5，返回插入位置的迭代器
.erase(a.begin()) | .erase(a.begin()+1, a.begin()+3)   // 删除a的0位置元素，删除a的1～3位置元素，返回删除位置的迭代器
```

```c++
// 2.哈希集——unordered_set
#include<unordered_set>
unordered_set<int> hash_set                            // 初始化
.insert(5) | .erase(4)                                 // 插入、删除
.count(5) | .size()                                    // 对某元素计数、返回哈希集大小
.begin() | .end()                                      // 返回iterator，用于遍历
.clear() | .empty()                                    // 清空、判断是否为空
```

```c++
// 3.哈希映射——unordered_map
#include<unordered_map>
unordered_map<int, int> hash_map | hash_map[1] = 2     // 初始化、为空或不空均可直接赋值，
.insert(make_pair(1, 2)) | .erase(4)                   // 插入（make_pair直接用）删除（4为key）
.count(5) | .size()                                    // 对某元素计数（5为key）、返回哈希集大小
.begin() | .end()                                      // 返回iterator，用于遍历
.clear() | .empty()                                    // 清空、判断是否为空
for (unordered_map<int, int>::iterator it = hash_map.begin(); it != hash_map.end(); it++) {
    cout << *it.first << *it.second << it->first << it->second << endl;
}

// 3.1 映射——map，用法同unordered_map
#include<map>
map<int, int> m | m[1] = 2
m[i].emplace_back(2)
```

```c++
// 4.字符串——string
#include<string>
string s = "abc" | string s(2, 'c') | to_string(123)   // 初始化
.size() | .length()                                    // 返回长度，尽量用size，length返回无符号
.resize()                                              // 调整字符串长度
.substr(5) | .substr(5, 3)                             // 取子串，从5截到尾、从5往后截3个
.push_back('a') | .append('b') ｜ += 'a'               // 末尾追加
.insert(0, "abc") | .insert(1, "abc", 1, 2)            // 0位置插入abc、1位置插入bc
.pop_back() ｜ .erase(0, 1)                            // 末尾删除、删除位置0开始数1个字符
.replace(1, 2, "abc")                                  // 位置1开始数2个字符替换为abc
.begin() | .end()                                      // 返回iterator，用于遍历
string s = "abc"; s[1] = 'm'                           // 可以直接赋值改变

// 字符串转数字
#include<cstdlib>
stoi("123") | stol("123") | stoll("123")               // 转int、long、long long

// 字符串比大小
str1.compare(str2) | strcmp(str1, str2)                // 逐位比大小，按照ascii码
  
// 大小写转换
#include<cctype>
tolower("ABC") | toupper("abc")                        // 大转小、小转大
```

```c++
// 5.栈和队列——stack、queue
#include<stack> | #include<queue>
.size()                                                // 求大小均是size
.push() | .pop() | .empty() | .top()                   // 栈
.push() | .pop() | .empty() | .front() | .back()       // 队列

// 优先队列
#include<priority_queue>
priority_queue<int> | priority_queue<int, less<int>()> // 队头大、队头小
```

```c++
// 6.各类算法函数——algorithm
#include<algorithm>
sort(起始地址, 结束地址, 排序规则) | less或great<类型>()    // 不设置规则默认小到大，即less
sort(~, ~, cmp) | static bool cmp(a, b) {return a > b} // 自定义规则，此处是降序，必须加static
reserve(起始地址, 结束地址)                               // 转换顺序
copy(a起始地址, a结束地址, b起始地址)                      // a复制到b
find(起始地址, 结束地址, 10)                              // 找到10返回指针，找不到返回.end()
count(起始地址, 结束地址, 查找字符)                        // 返回字符串中查找字符的数量
```

```c++
// 7.输入输出——printf、scanf
printf("%s%d", str, num)                               // 输出字符串和数字，不需要地址
scanf("%s%d", str, &num)                               // 输入字符串和数字，需要地址，str本身地址
%s、%c、%d、%f、%lf                                     // string、char、int、float、double
%04d、%.4f                                             // 不足4位补0、保留4位小数
```

```c++
// 8.常用函数

// 8.1 accumulate
#include<numeric>
accumulate(起始地址, 结束地址, 累加初值)
  
// 8.2 memset
#include<string.h>
dp[m][n] ——————> memset(dp, -1或0或false, m*n或sizeof(dp))  // 填1会出问题，一般填0、-1、false
  
// 8.3 is系列
isalpha() | isupper() | isdigit() | islower()          // 是否字母、大写、数字、小写，返回0或1
```

---

# 二、数组

### 2.1 二分查找（704、35、34、69、367）

- ##### 704

![image-20230507164508463](/Users/nnxs/Library/Application Support/typora-user-images/image-20230507164508463.png)

![image-20230507164635689](/Users/nnxs/Library/Application Support/typora-user-images/image-20230507164635689.png)

- ##### 35

![image-20230508163823044](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508163823044.png)

![image-20230508163854828](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508163854828.png)

- ##### 34

![image-20230508164049499](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508164049499.png)

![image-20230508164129695](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508164129695.png)

- ##### 69

![image-20230508164204547](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508164204547.png)

![image-20230508164219387](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508164219387.png)

- ##### 367

![image-20230508164255307](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508164255307.png)

![image-20230508164313707](/Users/nnxs/Library/Application Support/typora-user-images/image-20230508164313707.png)

### 2.2 移除元素（27、26、283、844）

- ##### 27

![image-20230513144759722](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513144759722.png)

![image-20230513144825090](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513144825090.png)

- ##### 26

![image-20230513145002373](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145002373.png)

![image-20230513145033859](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145033859.png)

- ##### 283

![image-20230513145141636](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145141636.png)

![image-20230513145159902](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145159902.png)

- ##### 844

![image-20230513145422540](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145422540.png)

![image-20230513145519326](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145519326.png)

### 2.3 有序数组的平方（977）

- ##### 977

![image-20230513145745290](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513145745290.png)

![image-20230513150120450](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513150120450.png)

![image-20230513150239189](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513150239189.png)

![image-20230513150546780](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513150546780.png)

### 2.4 长度最小的子数组（209、904、76）

- ##### 209

![image-20230513150904651](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513150904651.png)

![image-20230513151107343](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513151107343.png)

- ##### 904

![image-20230513151247277](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513151247277.png)

![image-20230513151533771](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513151533771.png)

- ##### 76

![image-20230513151639594](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513151639594.png)

```c++
#include<unordered_map>
class Solution {
public:
    string minWindow(string s, string t) {
        if (s.size() < t.size()) return "";
        // tm维护s子串中还需要多少个某个字母才能满足条件
        unordered_map<char, int> tm;
        for (int i = 0; i < t.size(); i++) {
            tm[t[i]] += 1;
        }
        // if_cover维护当前子串是否满足条件，解决了每次都需要遍历一遍tm的问题
        int left = 0, right = 0, if_cover = 0, min_length = s.size() + 1;
        vector<int> result = vector<int> (2, -1);
        for (; right < s.size(); right++) {
            // t中不含的字母，跳过
            if (tm.find(s[right]) == tm.end()) {
                continue;
            } else {
                // s子串中的s[right]数量等于t中s[right]数量，=0才++，s[right]第一次满足才++
                if (--tm[s[right]] == 0) if_cover++;
                // s子串已满足题目条件
                if (if_cover == tm.size()) {
                    // 子串第一次满足条件时，更新min_length和result
                    if (min_length > (right - left + 1)) {
                        min_length = (right - left + 1);
                        result[0] = left, result[1] = right;
                    }
                    // 左移left直至s子串不满足题目条件
                    while (if_cover == tm.size()) {
                        // 移除的字符在t中
                        if (tm.find(s[left]) != tm.end()) {
                            // 移除后s子串中的s[left]已不满足题目条件，跳出while循环
                            if(++tm[s[left]] == 1) {
                                if_cover--;
                                left++;
                                continue;
                            }
                            // 移除后s子串中的s[left]仍满足题目条件，left先加，然后更新
                            else {
                                left++;
                                // 更新min_length和result
                                if (min_length > (right - left + 1)) {
                                    min_length = (right - left + 1);
                                    result[0] = left, result[1] = right;
                                }
                            }
                        // 移除的字符不在t中，left先加，然后更新
                        } else {
                            left++;
                            // 更新min_length和result
                            if (min_length > (right - left + 1)) {
                                min_length = (right - left + 1);
                                result[0] = left, result[1] = right;
                            }
                        }
                    }
                }
            }
        }
        if (min_length == (s.size() + 1)) return "";
        return s.substr(result[0], result[1] - result[0] + 1);
    }
};
```

### 2.5 螺旋矩阵2⃣️（59、54）

- ##### 59

![image-20230513152538348](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513152538348.png)

![image-20230513152746447](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513152746447.png)

- ##### 54

![image-20230513154454266](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513154454266.png)

![image-20230513154547032](/Users/nnxs/Library/Application Support/typora-user-images/image-20230513154547032.png)

---

# 三、链表

### 3.1 移除链表元素（203）

- ##### 203

![image-20230514104600552](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514104600552.png)

![image-20230514104657107](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514104657107.png)

### 3.2 反转链表（206）

- ##### 206

![image-20230514104934662](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514104934662.png)

![image-20230514104950329](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514104950329.png)

![image-20230514110810267](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514110810267.png)

![image-20230514110831057](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514110831057.png)

### 3.3 两两交换链表中的节点（24）

- ##### 24

![image-20230514114210847](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514114210847.png)

![image-20230514114744376](/Users/nnxs/Library/Application Support/typora-user-images/image-20230514114744376.png)

---

# 四、哈希表

### 4.1 哈希表理论基础

|        集合        | 底层实现 | 是否有序 | 数值是否可以重复 | 能否更改数值 | 查询效率 | 增删效率 |
| :----------------: | :------: | :------: | :--------------: | :----------: | :------: | :------: |
|      std::set      |  红黑树  |   有序   |        否        |      否      | O(log n) | O(log n) |
|   std::multiset    |  红黑树  |   有序   |        是        |      否      | O(logn)  | O(logn)  |
| std::unordered_set |  哈希表  |   无序   |        否        |      否      |   O(1)   |   O(1)   |

|        映射        | 底层实现 | 是否有序 | 数值是否可以重复 | 能否更改数值 | 查询效率 | 增删效率 |
| :----------------: | :------: | :------: | :--------------: | :----------: | :------: | :------: |
|      std::map      |  红黑树  | key有序  |   key不可重复    | key不可修改  | O(logn)  | O(logn)  |
|   std::multimap    |  红黑树  | key有序  |    key可重复     | key不可修改  | O(log n) | O(log n) |
| std::unordered_map |  哈希表  | key无序  |   key不可重复    | key不可修改  |   O(1)   |   O(1)   |

### 4.2 有效的字母异位词（242、383、49、438）

- ##### 242

![image-20230519223647495](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519223647495.png)

![image-20230519223704030](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519223704030.png)

- ##### 383

![image-20230519224056808](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519224056808.png)

![image-20230519224734455](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519224734455.png)

- ##### 49

![image-20230519230915090](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519230915090.png)

![image-20230519231017556](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519231017556.png)

![image-20230519231122937](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519231122937.png)

- ##### 438

![image-20230520094554424](/Users/nnxs/Library/Application Support/typora-user-images/image-20230520094554424.png)

![image-20230520094721867](/Users/nnxs/Library/Application Support/typora-user-images/image-20230520094721867.png)

### 4.3 两个数组的交集（349、350）

- ##### 349

<img src="/Users/nnxs/Library/Application Support/typora-user-images/image-20230522105013601.png" alt="image-20230522105013601" style="zoom:100%;" />

![image-20230522105138464](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522105138464.png)

![image-20230522105243344](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522105243344.png)

![image-20230522110930289](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522110930289.png)

- ##### 350

![image-20230522110222094](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522110222094.png)

![image-20230522110334485](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522110334485.png)

![image-20230522110414622](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522110414622.png)

### 4.4 快乐数（202）

- ##### 202

![image-20230522112004616](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522112004616.png)

![image-20230522112142344](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522112142344.png)

### 4.5 两数之和（1——梦开始的地方）

- ##### 1

![image-20230522112436398](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522112436398.png)

![image-20230522155902756](/Users/nnxs/Library/Application Support/typora-user-images/image-20230522155902756.png)

### 4.6 四数之和（454）

- ##### 454

![image-20230523195503439](/Users/nnxs/Library/Application Support/typora-user-images/image-20230523195503439.png)

![image-20230523195948384](/Users/nnxs/Library/Application Support/typora-user-images/image-20230523195948384.png)

### 4.7 三数之和（15——非哈希表解法，哈希表很难写）

- ##### 15（双指针法）

![image-20230523200513959](/Users/nnxs/Library/Application Support/typora-user-images/image-20230523200513959.png)

```c++
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int>> answer;
        if(nums.size() < 3) return answer;
        sort(nums.begin(), nums.end());
        vector<int> temp;
        int size = nums.size();
        for(int i=0;i<size;i++){
            if(nums[i] > 0) return answer;
            if(i > 0 && nums[i] == nums[i-1]) continue;  //保证无重复，因为若i和i-1相等，则i-1遍历时就已经把可能的答案装进answer了，也即若i和i-1相等，i-1的所有可能答案包含i的所有可能答案，故跳过，所以直接continue i++
            int left = i+1;
            int right = size-1;
            while(left < right){
                if(nums[i] + nums[left] + nums[right] == 0){
                    temp.push_back(nums[i]);
                    temp.push_back(nums[left]);
                    temp.push_back(nums[right]);
                    answer.push_back(temp);
                    temp.clear();
                    while(left < right && nums[left] == nums[left+1]) left++;
                    while(left < right && nums[right] == nums[right-1]) right--;
                    left++;
                    right--;
                }
                else if(nums[i] + nums[left] + nums[right] > 0) right--;
                else left++;
            }
        }
        return answer;
    }
};
```

- ##### 611（番外篇，求三角形个数）

![image-20240319174152438](/Users/nnxs/Library/Application Support/typora-user-images/image-20240319174152438.png)

![image-20240319174552474](/Users/nnxs/Library/Application Support/typora-user-images/image-20240319174552474.png)

### 4.8 四数之和（18——非哈希表解法，哈希表很难写）

- ##### 18（双指针法）

![image-20230526105651681](/Users/nnxs/Library/Application Support/typora-user-images/image-20230526105651681.png)

```c++
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        vector<vector<int>> answer;
        if(nums.size() < 4) return answer;
        sort(nums.begin(), nums.end());
        int a, b, c, d;
        int num_size = nums.size();
        for(a = 0; a < num_size-3; a++){
            if(a > 0 && nums[a] == nums[a-1]) continue;
            for(b = a+1; b < num_size-2; b++){
                if(b > a+1 && nums[b] == nums[b-1]) continue;
                c = b+1;
                d = num_size-1;
                while(c < d){
                    if((long) nums[a] + nums[b] + nums[c] + nums[d] == target){
                        answer.push_back(vector<int>{nums[a], nums[b], nums[c], nums[d]});
                        while(c < d && nums[c] == nums[c+1]) c++;
                        while(c < d && nums[d] == nums[d-1]) d--;
                        c++;
                        d--;
                    }
                    else if((long) nums[a] + nums[b] + nums[c] + nums[d] < target){
                        c++;
                    }
                    else{
                        d--;
                    }
                }
            }
        }
        return answer;
    }
};
```

# 五、字符串

### 5.1 反转字符串（344）

- ##### 344

![image-20230526111053173](/Users/nnxs/Library/Application Support/typora-user-images/image-20230526111053173.png)

![image-20230526111538886](/Users/nnxs/Library/Application Support/typora-user-images/image-20230526111538886.png)

### 5.2 反转字符串2⃣️（541）

- ##### 541

![image-20230526114246421](/Users/nnxs/Library/Application Support/typora-user-images/image-20230526114246421.png)

![image-20230526114301238](/Users/nnxs/Library/Application Support/typora-user-images/image-20230526114301238.png)

### 5.3 替换空格（剑指offer.05）

- ##### 剑指offer.05

![image-20230529125628744](/Users/nnxs/Library/Application Support/typora-user-images/image-20230529125628744.png)

![image-20230529131020873](/Users/nnxs/Library/Application Support/typora-user-images/image-20230529131020873.png)

### 5.4 反转字符串中的单词（151）

- ##### 151

![image-20230529131716861](/Users/nnxs/Library/Application Support/typora-user-images/image-20230529131716861.png)

![image-20230529141240721](/Users/nnxs/Library/Application Support/typora-user-images/image-20230529141240721.png)

### 5.5 左旋转字符串（剑指Offer58-Ⅱ）

- ##### 剑指Offer58-Ⅱ

![image-20230531094846356](/Users/nnxs/Library/Application Support/typora-user-images/image-20230531094846356.png)

![image-20230531095414220](/Users/nnxs/Library/Application Support/typora-user-images/image-20230531095414220.png)

### 5.6 找出字符串第一个匹配项的下标（28）

- ##### 28

![image-20230531095551600](/Users/nnxs/Library/Application Support/typora-user-images/image-20230531095551600.png)

![image-20230531111735453](/Users/nnxs/Library/Application Support/typora-user-images/image-20230531111735453.png)



# 6、动态规划（dp）

### 6.1 动态规划基础

![img](https://code-thinking.cdn.bcebos.com/pics/%E5%8A%A8%E6%80%81%E8%A7%84%E5%88%92-%E6%80%BB%E7%BB%93%E5%A4%A7%E7%BA%B21.jpg)

![image-20230517104549597](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517104549597.png)

### 6.2 斐波那契数（509）

- ##### 509

![image-20230517103206107](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517103206107.png)

![image-20230517103219309](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517103219309.png)

### 6.3 爬楼梯（70）

- ##### 70

![image-20230517103407189](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517103407189.png)

![image-20230519224857262](/Users/nnxs/Library/Application Support/typora-user-images/image-20230519224857262.png)

### 6.4 使用最小花费爬楼梯（746）

- ##### 746

![image-20230517112225092](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517112225092.png)

![image-20230517142552146](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517142552146.png)

### 6.5 不同路径（62、63）

- ##### 62

![image-20230517143324435](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517143324435.png)

![image-20230517143329743](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517143329743.png)

![image-20230517152908859](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517152908859.png)

- ##### 63

![image-20230517153222047](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517153222047.png)

![image-20230517153227920](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517153227920.png)

![image-20230517153241992](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517153241992.png)

![image-20230517155049283](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517155049283.png)

### 6.6 整数拆分（343）

- ##### 343

![image-20230517155757141](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517155757141.png)

![image-20230517163233157](/Users/nnxs/Library/Application Support/typora-user-images/image-20230517163233157.png)

补充：dp[6]的24拆分，为什么不dp[2]dp[4]，因为dp[2]会拆成11，已经在1dp[5]考虑过了；同理dp[3]dp[3]，前面的dp[3]已经在2dp[4]考虑过了，因为3会拆成12和21，就算拆成111也在1dp[5]考虑过了

### 6.7 0-1背包问题

**0-1背包问题题目描述**：有n件物品和一个最多能背重量为w的背包。第i件物品的重量是weight[i]，得到的价值是value[i] 。每件物品只能用一次，求解将哪些物品装入背包里物品价值总和最大。假设物品信息如下，背包最多可装重量为4的物品。

|       | 重量 | 价值 |
| ----- | ---- | ---- |
| 物品0 | 1    | 15   |
| 物品1 | 3    | 20   |
| 物品2 | 4    | 30   |

##### 二维数据写法：

- dp [i] [j] 含义：表示从下标为 [0-i] 的物品里任意取，放进容量为j的背包，价值总和最大是多少
- 递推公式：dp [i] [j] = max(dp [i - 1] [j], dp [i - 1] [j - weight[i]] + value[i])，即不放物品i和放物品i
- 初始化：dp [i] [0] = 0，因为背包重量为0时放不进东西。dp [0] [j] 当j大于等于物品0的重量时，dp [0] [j] = value [0]，dp [0] [j] 当j小于物品0的重量时，dp [0] [j] = 0。其余位置均初始化为0即可（dp [i] [j] 是由左上方数值推导出来了，那么其他下标初始为什么数值都可以，因为都会被覆盖）
- 遍历顺序：先物品后重量（更好） / 先重量后物品，都是靠左上方数据推出来的，所以先后不影响

```c++
void test_2_wei_bag_problem1() {
    vector<int> weight = {1, 3, 4};
    vector<int> value = {15, 20, 30};
    int bagweight = 4;

    // 二维数组
    vector<vector<int>> dp(weight.size(), vector<int>(bagweight + 1, 0));

    // 初始化
    for (int j = weight[0]; j <= bagweight; j++) {
        dp[0][j] = value[0];
    }

    // weight数组的大小 就是物品个数
    for(int i = 1; i < weight.size(); i++) { // 遍历物品
        for(int j = 0; j <= bagweight; j++) { // 遍历背包容量
            if (j < weight[i]) dp[i][j] = dp[i - 1][j];
            else dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - weight[i]] + value[i]);

        }
    }

    cout << dp[weight.size() - 1][bagweight] << endl;
}

int main() {
    test_2_wei_bag_problem1();
}
```

##### 一维数据写法（滚动数组，自己覆盖自己）：

- dp[j] 含义：容量为j的背包，所背的物品价值可以最大为dp[j]
- 递推公式：dp[j] = max(dp[j], dp[j - weight[i]] + value[i])，即不放物品i和放物品i
- 初始化：全0即可
- 遍历顺序：先物品后重量（重量倒序遍历）❗️❗️

![image-20230518002300437](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518002300437.png)

![image-20230518002513143](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518002513143.png)

```c++
void test_1_wei_bag_problem() {
    vector<int> weight = {1, 3, 4};
    vector<int> value = {15, 20, 30};
    int bagWeight = 4;

    // 初始化
    vector<int> dp(bagWeight + 1, 0);
    for(int i = 0; i < weight.size(); i++) { // 遍历物品
        for(int j = bagWeight; j >= weight[i]; j--) { // 遍历背包容量
            dp[j] = max(dp[j], dp[j - weight[i]] + value[i]);
        }
    }
    cout << dp[bagWeight] << endl;
}

int main() {
    test_1_wei_bag_problem();
}
```

- ##### 416（01背包是否能装满，装满True）

![image-20230518003435485](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518003435485.png)

![image-20230518005102371](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518005102371.png)

- ##### 1049（dp含义同上，本题其实就是尽量让石头分成重量相同的两堆，相撞之后剩下的石头最小，**这样就化解成01背包问题了**）

![image-20240229201502074](/Users/nnxs/Library/Application Support/typora-user-images/image-20240229201502074.png)

![image-20240229202435270](/Users/nnxs/Library/Application Support/typora-user-images/image-20240229202435270.png)

- ##### 494（01背包有多少种方式装满）

![image-20240302140301948](/Users/nnxs/Library/Application Support/typora-user-images/image-20240302140301948.png)

![image-20240302143508149](/Users/nnxs/Library/Application Support/typora-user-images/image-20240302143508149.png)

假设所有取正数的为left，所有取负数的为right，left+right=sums，left-right=target，所以left=(sums+target)/2

- ##### 474（01背包二维背包容量，最多能装多少个物品）

![image-20240302143704366](/Users/nnxs/Library/Application Support/typora-user-images/image-20240302143704366.png)

![image-20240302143730994](/Users/nnxs/Library/Application Support/typora-user-images/image-20240302143730994.png)

### 6.8 完全背包问题

**完全背包问题题目描述**：有n件物品和一个最多能背重量为w的背包。第i件物品的重量是weight[i]，得到的价值是value[i] 。每件物品可以用无限次，求解将哪些物品装入背包里物品价值总和最大。**无限次的条件与01背包只差在遍历顺序上**❗️❗️

```python
# 一维dp的内层循环正序遍历，表示一个物品可以拿多次，且顺序可颠倒，原因看代码随想录笔记
for i in range(len(weight)):  # 遍历物品
    for j in range(weight[i], bagWeight + 1):  # 遍历背包容量
        dp[j] = max(dp[j], dp[j - weight[i]] + value[i])
```

- ##### 52（[卡码网KamaCoder](https://kamacoder.com/)）

![image-20240303110225109](/Users/nnxs/Library/Application Support/typora-user-images/image-20240303110225109.png)

![image-20240303110340408](/Users/nnxs/Library/Application Support/typora-user-images/image-20240303110340408.png)

- ##### 518（组合）

![image-20240303112504595](/Users/nnxs/Library/Application Support/typora-user-images/image-20240303112504595.png)

![image-20240303112930524](/Users/nnxs/Library/Application Support/typora-user-images/image-20240303112930524.png)

- ##### 377（排列）

![image-20240303114119329](/Users/nnxs/Library/Application Support/typora-user-images/image-20240303114119329.png)

![image-20240303114248075](/Users/nnxs/Library/Application Support/typora-user-images/image-20240303114248075.png)

- ##### 57（[卡码网KamaCoder](https://kamacoder.com/)）

![image-20240305103519085](/Users/nnxs/Library/Application Support/typora-user-images/image-20240305103519085.png)

![image-20240305103536685](/Users/nnxs/Library/Application Support/typora-user-images/image-20240305103536685.png)

- ##### 322

![image-20240305110433602](/Users/nnxs/Library/Application Support/typora-user-images/image-20240305110433602.png)

![image-20240307163535955](/Users/nnxs/Library/Application Support/typora-user-images/image-20240307163535955.png)

- ##### 279

![image-20240307155428753](/Users/nnxs/Library/Application Support/typora-user-images/image-20240307155428753.png)

![image-20240307163642616](/Users/nnxs/Library/Application Support/typora-user-images/image-20240307163642616.png)

- ##### 139

![image-20240309134947310](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309134947310.png)

![image-20240309135345828](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309135345828.png)

### 6.9 多重背包问题（基本不会考，只一个例题，解法同01）

- ##### 56（[卡码网KamaCoder](https://kamacoder.com/)）

![image-20240309145549305](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309145549305.png)

![image-20240309145948073](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309145948073.png)

### 6.10 背包问题总结

![416.分割等和子集1](https://code-thinking-1253855093.file.myqcloud.com/pics/20230310000726.png)

>1. 确定dp数组（dp table）以及下标的含义
>2. 确定递推公式
>3. dp数组如何初始化
>4. 确定遍历顺序
>5. 举例推导dp数组

- ##### 递推公式

| 类型                               | 递推公式                                           |
| ---------------------------------- | -------------------------------------------------- |
| 问能否能装满背包（或者最多装多少） | `dp[j] = max(dp[j], dp[j - nums[i]] + nums[i])`    |
| 问装满背包有几种方法               | `dp[j] += dp[j - nums[i]]`                         |
| 问背包装满最大价值                 | `dp[j] = max(dp[j], dp[j - weight[i]] + value[i])` |
| 问装满背包所有物品的最小个数       | `dp[j] = min(dp[j - coins[i]] + 1, dp[j])`         |

- ##### 遍历顺序

  - 01背包：一维dp数组01背包只能先遍历物品再遍历背包容量，且第二层for循环是**从大到小**遍历
  - 完全背包：
    - **求组合数就是外层for循环遍历物品，内层for遍历背包**
    - **求排列数就是外层for遍历背包，内层for循环遍历物品**
    - 求最小数，那么两层for循环的先后顺序就无所谓

### 6.11 打家劫舍（Ⅰ、Ⅱ、Ⅲ）

- ##### 198（Ⅰ）

![image-20240309152252959](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309152252959.png)

![image-20240309152528174](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309152528174.png)

- ##### 213（Ⅱ）

![image-20240309153118122](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309153118122.png)

![image-20240309153514387](/Users/nnxs/Library/Application Support/typora-user-images/image-20240309153514387.png)

- ##### 337（Ⅲ）

![image-20240310095021269](/Users/nnxs/Library/Application Support/typora-user-images/image-20240310095021269.png)

![image-20240310095124667](/Users/nnxs/Library/Application Support/typora-user-images/image-20240310095124667.png)

### 6.12 买卖股票的最佳时机（121、122、123、188、309、714）

- ##### 121

![image-20230518153953393](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518153953393.png)

![image-20230518154153172](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518154153172.png)

![image-20230518155926403](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518155926403.png)

- ##### 122

![image-20230518160349069](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518160349069.png)

![image-20230518161025840](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518161025840.png)

- ##### 123

![image-20230518162839742](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518162839742.png)

![image-20230518163343983](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518163343983.png)

- ##### 188

![image-20240310101947493](/Users/nnxs/Library/Application Support/typora-user-images/image-20240310101947493.png)

![image-20240310102032883](/Users/nnxs/Library/Application Support/typora-user-images/image-20240310102032883.png)

- ##### 309

![image-20240311192814366](/Users/nnxs/Library/Application Support/typora-user-images/image-20240311192814366.png)

![image-20240311195639174](/Users/nnxs/Library/Application Support/typora-user-images/image-20240311195639174.png)

解释：0状态为持有股票状态（买入或之前就买入一直持有），1状态为保持股票卖出状态（冷冻期后），2状态为卖出股票状态（卖出），3状态为冷冻期（卖出后第一天），其关系举例如下

| 0    | 0    | 0    | 2    | 3    | 1        | 1        | 1        | 0    | 2    | 3    |
| ---- | ---- | ---- | ---- | ---- | -------- | -------- | -------- | ---- | ---- | ---- |
| 买入 | 持有 | 持有 | 卖出 | 冷冻 | 保持卖出 | 保持卖出 | 保持卖出 | 买入 | 卖出 | 冷冻 |

![img](https://code-thinking-1253855093.file.myqcloud.com/pics/518d5baaf33f4b2698064f8efb42edbf.png)

- `dp[i][0] = max(dp[i-1][0], dp[i-1][1] - prices[i], dp[i-1][3] - prices[i])`：第i天买入，i-1天持有 / i-1天保持卖出i天买入 / i-1天冷冻i天买入
- `dp[i][1] = max(dp[i-1][1], dp[i-1][3])`：第i天保持卖出，i-1天保持卖出 / i-1天冷冻
- `dp[i][2] = dp[i-1][0] + prices[i]`：第i天卖出，i-1天持有
- `dp[i][3] = dp[i-1][2]`：第i天冷冻，i-1天卖出



- ##### 714

![image-20240314155055416](/Users/nnxs/Library/Application Support/typora-user-images/image-20240314155055416.png)

![image-20240314155241014](/Users/nnxs/Library/Application Support/typora-user-images/image-20240314155241014.png)

（最好还是卖出减手续费，比较好理解）



### 6.13 子序列问题

- ##### 300（最长递增子序列）

![image-20240315124148955](/Users/nnxs/Library/Application Support/typora-user-images/image-20240315124148955.png)

![image-20240315124259853](/Users/nnxs/Library/Application Support/typora-user-images/image-20240315124259853.png)

- ##### 674（最长连续递增序列）

![image-20240315124711817](/Users/nnxs/Library/Application Support/typora-user-images/image-20240315124711817.png)

![image-20240315124743822](/Users/nnxs/Library/Application Support/typora-user-images/image-20240315124743822.png)

- ##### 718（最长重复子数组）

![image-20240315124857164](/Users/nnxs/Library/Application Support/typora-user-images/image-20240315124857164.png)

![image-20240315131100830](/Users/nnxs/Library/Application Support/typora-user-images/image-20240315131100830.png)

- ##### 1143（最长公共子序列）

![image-20240316130314556](/Users/nnxs/Library/Application Support/typora-user-images/image-20240316130314556.png)

![image-20240316135004560](/Users/nnxs/Library/Application Support/typora-user-images/image-20240316135004560.png)

至于此处为什么是`dp[i][j] = max(dp[i-1][j], dp[i][j-1])`，我理解的是如果`text1[i-1] == text2[j-1]`，相等时用到了这两个位置上的字母，所以取的是`dp[i][[j] = dp[i-1][j-1] + 1`；如果不相等，则没有用到这两个位置的字母，那么递推公式取max时就可以用到这两个位置保存的信息，相当于用到了这两个位置的字母

- ##### 1035（不相交的线）

![image-20240317205620536](/Users/nnxs/Library/Application Support/typora-user-images/image-20240317205620536.png)

![image-20240317211955261](/Users/nnxs/Library/Application Support/typora-user-images/image-20240317211955261.png)

- ##### 53

![image-20240318101556262](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318101556262.png)

![image-20240318101753419](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318101753419.png)

- ##### 392（判断子序列）

![image-20240318102259989](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318102259989.png)

![image-20240318104041178](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318104041178.png)

- ##### 115（不同的子序列）

![image-20240318111059953](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318111059953.png)

![image-20240318111903067](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318111903067.png)

- ##### 583（两个字符串的删除操作）

![image-20240318114507179](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318114507179.png)

![image-20240318115845424](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318115845424.png)

- ##### 72（编辑距离）

![image-20240318140915981](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318140915981.png)

![image-20240318141221214](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318141221214.png)

- ##### 647

![image-20240318142021819](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318142021819.png)

![image-20240318145437505](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318145437505.png)

- ##### 516

![image-20240319163334146](/Users/nnxs/Library/Application Support/typora-user-images/image-20240319163334146.png)

![image-20240319165206892](/Users/nnxs/Library/Application Support/typora-user-images/image-20240319165206892.png)

# 七、贪心算法

- ##### 455

![image-20240321135307947](/Users/nnxs/Library/Application Support/typora-user-images/image-20240321135307947.png)

![image-20240321135408713](/Users/nnxs/Library/Application Support/typora-user-images/image-20240321135408713.png)

- ##### 376

![image-20240321142923989](/Users/nnxs/Library/Application Support/typora-user-images/image-20240321142923989.png)

![image-20240321143043995](/Users/nnxs/Library/Application Support/typora-user-images/image-20240321143043995.png)

所有数一样的数组返回1，这是用例测试出来的

- ##### 53

![image-20240318101556262](/Users/nnxs/Library/Application Support/typora-user-images/image-20240318101556262.png)

![image-20240322115017681](/Users/nnxs/Library/Application Support/typora-user-images/image-20240322115017681.png)

- ##### 122

![image-20230518160349069](/Users/nnxs/Library/Application Support/typora-user-images/image-20230518160349069.png)

- ##### 55

![image-20240324162007816](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324162007816.png)

![image-20240324162102533](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324162102533.png)

![image-20240324162254898](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324162254898.png)

- ##### 45

![image-20240324162259468](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324162259468.png)

![image-20240324164708737](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324164708737.png)

![image-20240324165116085](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324165116085.png)

- ##### 1005

![image-20240324165617330](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324165617330.png)

![image-20240324172004840](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324172004840.png)

![image-20240324172134390](/Users/nnxs/Library/Application Support/typora-user-images/image-20240324172134390.png)
