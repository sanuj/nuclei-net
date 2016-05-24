from shutil import copyfile

file_name = '/home/sanuj/Projects/nuclei-net-data/20x/20-patients/big_validation.txt'
dest_name = '/home/sanuj/Projects/nuclei-net-data/20x/20-patients/dp-imagesource/validate'

if __name__ == '__main__':
    f = open(file_name, 'r')
    count = 0
    for line in f:
        img_path, label = line.split()
        temp = img_path.split('/')
        img_name = temp[-3] + '_' + temp[-1]
        copyfile(img_path, dest_name+'/'+label+'/'+img_name)
        count += 1
        print 'Copied: #' + str(count) + " " + dest_name+'/'+label+'/'+img_name

print str(count) + ' files copied.'