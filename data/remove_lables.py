# This is used to remove images from training data which have the specified label.
# Used only for Caffe. Useful when you want to delete images to equalize training samples
# for each class.

label = 0 # training samples corresponding to this label will be deleted
# file_name = '/home/sanuj/Projects/nuclei-net/data/training-data/78_RLM_YR4_3_class/train.txt'
# file_name = '/home/sanuj/Projects/nuclei-net/data/training-data/78_RLM_YR4_3_class_31/train_small.txt'
#file_name = '/home/sanuj/Projects/nuclei-net/data/training-data/63_LLM_YR4_3_class/test.txt'
file_name = '/home/sanuj/Projects/nuclei-net/data/training-data/63_LLM_YR4_3_class_31/test_small.txt'
num_deletions = 104251 - 5000 # number of deletions

if __name__ == '__main__':
    f = open(file_name, 'r')
    lines = f.readlines()
    f.close()
    f = open(file_name, 'w')
    for line in lines:
        if num_deletions > 0 and line[-2] is str(label):
            num_deletions = num_deletions-1
        else:
            f.write(line)
    f.close()
