# This script counts the number of training samples for label 1 and 0
# from a text file prepared for representing training data for a Caffe model

# file_name = '/home/sanuj/temp_63_LLM_YR4_33/train_big.txt'
#
# if __name__ == '__main__':
#     f = open(file_name, 'r')
#     l = []
#     for line in f:
#         l.append(line[-2])
#     total = len(l)
#     ones = 0
#     for i in l:
#         ones = ones + int(i)
#
#     f.close()
#     print "number of ones:  " + str(ones)
#     print "number of zeros: " + str(total-ones)


# This script counts the number of training samples for label 0, 1, 2
# from a text file prepared for representing training data for a Caffe model

file_name = '/home/sanuj/Projects/nuclei-net-data/20x/20-patients/1/validate.txt'

if __name__ == '__main__':
    f = open(file_name, 'r')
    l = []
    for line in f:
        l.append(line[-2])
    total = len(l)
    zeros = 0
    ones = 0
    twos = 0
    for i in l:
        if int(i) is 0:
            zeros += 1
        elif int(i) is 1:
            ones += 1
        elif int(i) is 2:
            twos += 1
    f.close()
    print "number of zeros: " + str(zeros)
    print "number of ones:  " + str(ones)
    print "number of twos: " + str(twos)
