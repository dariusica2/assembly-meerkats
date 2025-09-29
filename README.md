# Assembly Assignment - Network Meerkats

## Description:

### Task 1 - Parenthetizer

* For this task, I checked the correctness of the parentheses using the stack
* I started by checking each element in the given string of parentheses
* If it is an open parenthese, I push it onto the stack, not being interested in what type of
  parenthese it is
* If it is a closed parenthese, I first check if the stack has any more elements
* If it has no more elements, it fails
* If the stack has elements, I check if the last parenthese added matches
  with the respective closed parenthese
* If it does not match, it fails
* Finally, I check if the stack has any more elements, and for each element
  remaining on the stack I pop it to avoid getting a segmentation fault

### Task 2 - Divide et impera

* Exercise 1 - Quicksort

* I took the last element in the array as a pivot and iterated from the beginning,
  comparing each element with the pivot
* I have two pointers (i and j)
* The pointer j iterates through the entire array, and if a value is smaller
  than the pivot, swaps with the pointer i
* Finally, the pivot element is swapped with the pointer i
* This process is repeated to the left and right of the new position of the pivot until
  the array is sorted

* Exercise 2 - Binary search

* Initially, the values ​​0 and end - 1 are given, that is, the first and last positions in the array
* The middle position is calculated
* The array is sorted
* So if the value in the middle is greater than needle, a
  left search will be done, and if the value in the middle is smaller than needle, a
  right search will be done

### Task 3 - Depth first search

* For this function, I took each node separately, I noted it as visited
  yet at first, we displayed it, and then we applied the expand function to find out
  its number of neighbors, but also the neighbors (which were in an array)
* For each neighbor, we check if it has already been visited
* If it has been visited, it is ignored
* If it has not been visited, the process is repeated (dfs recursion)

### Bonus - x64 assembly

* Here I used the pseudocode provided in the assignment text, also being
  very careful with the registers
* In short, I recreated the pseudocode given in assembly

#### Resources / Bibliography:

1. (https://www.programiz.com/dsa/quick-sort)
2. (https://www.geeksforgeeks.org/binary-search/)
3. (https://gitlab.cs.pub.ro/iocla/tema3-2024/-/tree/master)

