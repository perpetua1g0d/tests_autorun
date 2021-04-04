## @Author: perpetua1g0d

## LAB SETTINGS:
lab_number=2
your_variant=3
min_num_task=1
max_num_task=5
variants_amount=()
variants_amount[1]=4
variants_amount[2]=4
variants_amount[3]=4
variants_amount[4]=3
variants_amount[5]=5
execute_file_name=main


if [ ${lab_number} -lt 10 ]
then
    lab_number=0$lab_number
fi

# add_lead_zero(${N}) {
#     if [ ${N} -lt 10 ]
#     then
#         N=0$N
#     fi
#     return $N
# }


for ((i=$min_num_task; i<=$max_num_task; ++i))
do
    cur_var=$((${your_variant} % ${variants_amount[i]})) 
    name_lab="lab_${lab_number}_0${i}_0${cur_var}"
    echo $name_lab
    cd ./$name_lab/func_tests/
    run_through() {
        for ((j=1;;++j))
        do
            tests_num=$j
            if [ ${tests_num} -lt 10 ]
            then
                tests_num=0$tests_num
            fi
            File_name=${Test_Type}_${tests_num}_
            In=${File_name}in.txt
            Out=${File_name}out.txt
            if [ -f "$In" ]; then
                (.././${execute_file_name} < ${In}) > ${Out}
                continue
            fi
            break
        done
    }
    Test_Type=pos
    run_through
    Test_Type=neg
    run_through
    cd .. && cd ..
done
