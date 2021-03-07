# tests_autorun
* The script's written for students of the 'C programming lang, bmstu university' course.
* This script runs your unit tests and writes the output of your solutions.
* The script won't work if you try to run it via not unix-like terminal.
* There are no any input defense, so read the guide below carefully.
* P.S. the code written pretty bad but it works fine. If you want to make the code look better, feel free to make a pull request.

# how to use:
1. Prepare your tests for each task. The name of file with test's data must be correspond following: (pos/neg . number_of_test . in.txt).
number_of_test counts with 1, if < 10, then it must consist 1 leading zero. Example: pos_01_in.txt
2. Put your files with tests in the directory: task_number/func tests/. Example: lab_01_02_03/func_tests 
3. Put the script in the directory where you store directories with tasks.
4. Edit script's settings (how to do it read below).
5. Run via terminal: bash run_tests.sh

# settings:
Open the script via any prefered text editor.
  ## lab_number
  the lab's number
  ## your_variant
  your general variant
  ## min_num_task
  the number of the first task
  ## max_num_task
  the number of the last task
  ## variants_amount
  how many variants i-th task have
  ## execute_file_name
  the name of .........
