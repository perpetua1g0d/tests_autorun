## @Author: perpetua1.g0d

## LAB SETTINGS:
lab_number=4
your_variant=3
min_num_task=1
max_num_task=4
variants_amount=()
variants_amount[1]=0
variants_amount[2]=4
variants_amount[3]=2
variants_amount[4]=4
files_to_compile=()
files_to_compile[1]='main.c my_string.c'
files_to_compile[2]='main.c my_module.c'
files_to_compile[3]='main.c my_module.c'
files_to_compile[4]='main.c my_module.c'
execute_file_name=main

if [ ${lab_number} -lt 10 ]
then
    lab_number=0$lab_number
fi


for ((i=$min_num_task; i<=$max_num_task; ++i))
do
    name_task="lab_${lab_number}_0${i}"

    if [[ ${variants_amount[i]} -gt 0 ]]; then
        cur_var=$((${your_variant} % ${variants_amount[i]})) 
        name_task="lab_${lab_number}_0${i}_0${cur_var}"
    fi

    echo $name_task
    cd ./$name_task

    (rm *.gcda) || (rm *.gcov) || (rm *.gcno)
    gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-conversion\
    -Wfloat-equal -Wredundant-decls -Wsign-conversion -Wvla -Wmissing-braces\
    -O0 -fprofile-arcs -ftest-coverage ${files_to_compile[i]} -o main -lm

    if [ ! -d 'func_tests' ]; then
        echo 'Warning: '${name_task}' has no tests'
        if [[ ${variants_amount[i]} -eq 0 ]]; then
            ./${execute_file_name} && gcov ${files_to_compile[i]} && cd ..
        fi
        continue
    fi

    cd ./func_tests
    cnt_tests=0

    run_through() {
        for ((j=1;;++j))
        do
            tests_num=$j
            if [ ${tests_num} -lt 10 ]; then
                tests_num=0$tests_num
            fi

            File_name=${Test_Type}_${tests_num}_
            In=${File_name}in.txt
            Out=${File_name}out.txt

            if [ -f "$In" ]; then
                (.././${execute_file_name} < ${In}) > ${Out}
                exit_code=$?

                if [[ ${Test_Type} == 'neg' && ${exit_code} -eq 0 ]]; then
                    echo ">>>>>>> ${In} is NOT NEG!!! <<<<<<<"
                fi
                if [[ ${Test_Type} == 'pos' && ${exit_code} -ne 0 ]]; then
                    echo ">>>>>>> ${In} is NOT POS!!! <<<<<<<"
                fi
                
                continue
            fi

            cnt_tests=$(($j-1))
            echo 'Number of '${Test_Type}' tests: '$cnt_tests

            break
        done
    }

    Test_Type=pos
    run_through
    Test_Type=neg
    run_through

    cd .. && gcov ${files_to_compile[i]} && cd ..
done
